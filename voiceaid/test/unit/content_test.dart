import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/data/first_aid_content.dart';
import 'package:voiceaid/data/first_aid_repository.dart';
import 'package:voiceaid/models/app_language.dart';
import 'package:voiceaid/models/first_aid_models.dart';
import 'package:voiceaid/models/localized_text.dart';

void main() {
  const repo = FirstAidRepository();

  test('bundled content passes validation', () {
    expect(repo.validate(), isEmpty);
  });

  test('exactly the five required categories exist, in order', () {
    expect(repo.categories.map((c) => c.id).toList(),
        ['burns', 'bleeding', 'choking', 'snakebite', 'fracture']);
  });

  test('choking has separate adult, child and infant flows', () {
    final choking = repo.categoryById('choking')!;
    expect(choking.flows.map((f) => f.id).toList(), ['adult', 'child', 'infant']);
    expect(choking.hasMultipleFlows, isTrue);
  });

  test('infant flow never instructs belly thrusts outside a "do not" step', () {
    final infant = repo.categoryById('choking')!.flowById('infant')!;
    for (final s in infant.steps.where((s) => s.type != StepType.avoid)) {
      expect(s.text.en.toLowerCase(), isNot(contains('belly thrust')));
    }
  });

  test('adult and child flows do not use the infant chest-thrust method', () {
    final choking = repo.categoryById('choking')!;
    for (final id in ['adult', 'child']) {
      for (final s in choking.flowById(id)!.steps) {
        expect(s.text.en.toLowerCase(), isNot(contains('chest thrust')));
      }
    }
  });

  test('every flow has a warning, a do-NOT step, an urgent step and a source', () {
    for (final c in repo.categories) {
      for (final f in c.flows) {
        expect(f.warning.isComplete, isTrue, reason: '${c.id}/${f.id}');
        expect(f.steps.any((s) => s.type == StepType.avoid), isTrue);
        expect(f.steps.any((s) => s.type == StepType.urgent), isTrue);
        expect(f.sourceIds, isNotEmpty);
        expect(f.needsClinicalReview, isTrue);
      }
    }
  });

  test('burns: ice, toothpaste and butter appear only in the do-NOT step', () {
    final f = repo.categoryById('burns')!.flows.first;
    for (final s in f.steps.where((s) => s.type != StepType.avoid)) {
      final t = s.text.en.toLowerCase();
      for (final w in ['ice', 'toothpaste', 'butter']) {
        expect(t.contains(w), isFalse, reason: '${s.id} mentions $w');
      }
    }
  });

  test('snakebite prohibits cutting, sucking, ice, tourniquet, catching snake', () {
    final f = repo.categoryById('snakebite')!.flows.first;
    final avoid = f.steps
        .where((s) => s.type == StepType.avoid)
        .map((s) => s.text.en.toLowerCase())
        .join(' ');
    for (final w in ['cut the wound', 'suck', 'ice', 'tourniquet', 'catching']) {
      expect(avoid, contains(w));
    }
  });

  test('Hindi text exists, differs from English and contains Devanagari', () {
    final dev = RegExp(r'[\u0900-\u097F]');
    for (final c in repo.categories) {
      for (final f in c.flows) {
        for (final s in f.steps) {
          expect(dev.hasMatch(s.text.hi), isTrue, reason: '${c.id}/${f.id}/${s.id}');
          expect(s.text.hi, isNot(s.text.en));
        }
      }
    }
  });

  test('audio asset path follows the naming convention', () {
    final f = repo.categoryById('choking')!.flowById('infant')!;
    expect(
      f.audioAssetPath(languageCode: 'hi', categoryId: 'choking', stepIndex: 2),
      'assets/audio/hi/choking/infant_step03.mp3',
    );
  });

  group('invalid content handling', () {
    test('empty category list is reported', () {
      expect(const FirstAidRepository(categories: []).validate(), isNotEmpty);
    });

    test('untranslated and empty-step content is reported', () {
      const bad = FirstAidRepository(categories: [
        EmergencyCategory(
          id: 'x',
          label: LocalizedText(en: 'X', hi: ''),
          iconKey: 'info',
          flows: [
            GuidanceFlow(
              id: 'f',
              title: LocalizedText(en: 'X', hi: 'एक्स'),
              subtitle: LocalizedText(en: 'x', hi: 'x'),
              warning: LocalizedText(en: '', hi: ''),
              steps: [],
              sourceIds: [],
            ),
          ],
        ),
      ]);
      final problems = bad.validate().join('\n');
      expect(problems, contains('label not translated'));
      expect(problems, contains('warning missing'));
      expect(problems, contains('no steps'));
      expect(problems, contains('no source'));
    });

    test('unknown category/flow ids return null, not an exception', () {
      expect(repo.categoryById('nope'), isNull);
      expect(repo.categoryById('burns')!.flowById('nope'), isNull);
    });

    test('LocalizedText falls back to English if Hindi is empty', () {
      const t = LocalizedText(en: 'Hello', hi: '');
      expect(t.of(AppLanguage.hindi), 'Hello');
    });
  });
}
