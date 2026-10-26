// Pure-Dart content checks. Runs with the plain Dart SDK (no Flutter needed):
//   dart run tool/verify_content.dart
// This complements, but does NOT replace, the Flutter tests in test/.
import 'dart:io';

import '../lib/data/first_aid_repository.dart';
import '../lib/logic/step_navigator.dart';
import '../lib/models/app_language.dart';
import '../lib/models/first_aid_models.dart';

int _failures = 0;
int _checks = 0;

void check(String name, bool ok) {
  _checks++;
  if (!ok) {
    _failures++;
    stdout.writeln('FAIL: $name');
  }
}

void main() {
  const repo = FirstAidRepository();
  final problems = repo.validate();
  check('repository content valid (${problems.join('; ')})', problems.isEmpty);

  check('five categories', repo.categories.length == 5);
  check(
    'category ids',
    repo.categories.map((c) => c.id).join(',') ==
        'burns,bleeding,choking,snakebite,fracture',
  );
  final choking = repo.categoryById('choking')!;
  check('choking has 3 flows', choking.flows.length == 3);
  check(
    'choking flows are adult/child/infant',
    choking.flows.map((f) => f.id).join(',') == 'adult,child,infant',
  );

  // Forbidden advice must never be instructed. These phrases may appear only
  // inside a "Do NOT" (avoid) step.
  final forbidden = <String, List<String>>{
    'burns': ['ice', 'toothpaste', 'butter'],
    'snakebite': ['cut the wound', 'suck', 'ice', 'tourniquet'],
  };
  for (final entry in forbidden.entries) {
    final flow = repo.categoryById(entry.key)!.flows.first;
    for (final s in flow.steps.where((s) => s.type != StepType.avoid)) {
      final t = s.text.en.toLowerCase();
      for (final w in entry.value) {
        check('${entry.key}/${s.id} (non-avoid) must not mention "$w"',
            !t.contains(w));
      }
    }
    final avoid = flow.steps.where((s) => s.type == StepType.avoid).toList();
    for (final w in entry.value) {
      check('${entry.key} avoid step mentions "$w"',
          avoid.any((s) => s.text.en.toLowerCase().contains(w)));
    }
  }

  // Infant flow must not instruct belly thrusts; adult/child must not use the
  // infant chest-thrust method.
  final infant = choking.flowById('infant')!;
  for (final s in infant.steps.where((s) => s.type != StepType.avoid)) {
    check('infant/${s.id} no belly thrusts',
        !s.text.en.toLowerCase().contains('belly thrust'));
  }
  for (final id in ['adult', 'child']) {
    for (final s in choking.flowById(id)!.steps) {
      check('$id/${s.id} no "chest thrust"',
          !s.text.en.toLowerCase().contains('chest thrust'));
    }
  }

  // Hindi must be real Devanagari, not a copy of the English text.
  final devanagari = RegExp(r'[\u0900-\u097F]');
  for (final c in repo.categories) {
    for (final f in c.flows) {
      check('${c.id}/${f.id} warning hindi differs and has Devanagari',
          f.warning.hi != f.warning.en && devanagari.hasMatch(f.warning.hi));
      for (final s in f.steps) {
        check('${c.id}/${f.id}/${s.id} hindi has Devanagari',
            devanagari.hasMatch(s.text.hi) && s.text.hi != s.text.en);
      }
    }
  }

  // Audio path convention.
  final p = repo.categoryById('burns')!.flows.first.audioAssetPath(
        languageCode: AppLanguage.hindi.code,
        categoryId: 'burns',
        stepIndex: 0,
      );
  check('audio path convention ($p)',
      p == 'assets/audio/hi/burns/burns_step01.mp3');

  // Step navigation.
  final nav = StepNavigator(3);
  check('nav starts at 0', nav.index == 0 && nav.isFirst && !nav.canGoPrevious);
  check('nav next', nav.next() && nav.index == 1);
  check('nav next to last', nav.next() && nav.isLast && !nav.canGoNext);
  check('nav next at end stays', !nav.next() && nav.index == 2);
  check('nav previous', nav.previous() && nav.index == 1);
  check('nav goTo invalid', !nav.goTo(9) && !nav.goTo(-1) && nav.index == 1);
  final empty = StepNavigator(0);
  check('empty nav safe', empty.isEmpty && !empty.next() && !empty.previous());

  // Language lookup.
  check('fromCode hi', AppLanguage.fromCode('hi') == AppLanguage.hindi);
  check('fromCode unknown -> en', AppLanguage.fromCode('zz') == AppLanguage.english);
  check('fromCode null -> en', AppLanguage.fromCode(null) == AppLanguage.english);

  // Invalid content detection.
  const broken = FirstAidRepository(categories: []);
  check('empty content detected', broken.validate().isNotEmpty);

  stdout.writeln('$_checks checks, $_failures failed.');
  if (_failures > 0) exit(1);
}
