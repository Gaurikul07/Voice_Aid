import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/data/first_aid_content.dart';

import '../fakes.dart';

Future<TestHarness> openBurns(WidgetTester tester,
    {Map<String, Object> prefs = const {}, Set<String> assets = const {}}) async {
  final h = await TestHarness.create(initialPrefs: prefs, existingAssets: assets);
  await tester.pumpWidget(h.app());
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('category_burns')));
  await tester.pumpAndSettle();
  return h;
}

void main() {
  final burns = kEmergencyCategories.first.flows.first;

  testWidgets('shows safety warning, step counter, text and all controls',
      (tester) async {
    await openBurns(tester);
    expect(find.text('EMERGENCY WARNING'), findsOneWidget);
    expect(find.textContaining('Call 112'), findsWidgets);
    expect(find.byKey(const ValueKey('step_counter')), findsOneWidget);
    expect(find.text('Step 1 of ${burns.steps.length}'), findsOneWidget);
    expect(find.text(burns.steps.first.text.en), findsOneWidget);

    for (final k in [
      'audio_play',
      'audio_pause_resume',
      'audio_replay',
      'audio_stop',
      'prev_step',
      'next_step',
      'guidance_emergency',
      'exit_guidance',
    ]) {
      expect(find.byKey(ValueKey(k)), findsOneWidget, reason: k);
    }
    expect(find.byKey(const ValueKey('review_notice')), findsOneWidget);
  });

  testWidgets('Next/Previous move manually; Previous disabled on first step',
      (tester) async {
    await openBurns(tester);
    final prev = find.byKey(const ValueKey('prev_step'));
    expect(tester.widget<OutlinedButton>(prev).onPressed, isNull);

    await tester.tap(find.byKey(const ValueKey('next_step')));
    await tester.pumpAndSettle();
    expect(find.text('Step 2 of ${burns.steps.length}'), findsOneWidget);
    expect(find.text(burns.steps[1].text.en), findsOneWidget);

    await tester.tap(prev);
    await tester.pumpAndSettle();
    expect(find.text('Step 1 of ${burns.steps.length}'), findsOneWidget);
  });

  testWidgets('does not advance by itself', (tester) async {
    await openBurns(tester);
    await tester.pump(const Duration(seconds: 30));
    expect(find.text('Step 1 of ${burns.steps.length}'), findsOneWidget);
  });

  testWidgets('"do NOT" step is labelled with text, not colour alone',
      (tester) async {
    await openBurns(tester);
    final avoidIndex = burns.steps.indexWhere((s) => s.type.name == 'avoid');
    for (var i = 0; i < avoidIndex; i++) {
      await tester.tap(find.byKey(const ValueKey('next_step')));
      await tester.pumpAndSettle();
    }
    expect(find.text('DO NOT DO THIS'), findsOneWidget);
  });

  testWidgets('last step shows Done which exits to home', (tester) async {
    await openBurns(tester);
    for (var i = 0; i < burns.steps.length - 1; i++) {
      await tester.tap(find.byKey(const ValueKey('next_step')));
      await tester.pumpAndSettle();
    }
    expect(find.text('Done'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('next_step')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('app_name')), findsOneWidget);
  });

  testWidgets('with no recordings, auto audio uses phone voice with the same text',
      (tester) async {
    final h = await openBurns(tester);
    expect(h.speech.spoken, ['en:${burns.steps.first.text.en}']);
    expect(find.byKey(const ValueKey('audio_notice')), findsOneWidget);
  });

  testWidgets('with a bundled recording present, the recording plays', (tester) async {
    final h = await openBurns(tester,
        assets: {'assets/audio/en/burns/burns_step01.mp3'});
    expect(h.player.calls, contains('play:assets/audio/en/burns/burns_step01.mp3'));
    expect(h.speech.spoken, isEmpty);
  });

  testWidgets('audio auto-play can be turned off; Play still works', (tester) async {
    final h = await openBurns(tester, prefs: {'audio_auto_play': false});
    expect(h.speech.spoken, isEmpty);
    await tester.tap(find.byKey(const ValueKey('audio_play')));
    await tester.pumpAndSettle();
    expect(h.speech.spoken, hasLength(1));
  });

  testWidgets('Hindi speech language is used when Hindi is selected', (tester) async {
    final h = await openBurns(tester, prefs: {'language_code': 'hi'});
    expect(h.speech.spoken.single, startsWith('hi:'));
    expect(find.text('आपातकालीन चेतावनी'), findsOneWidget);
  });

  testWidgets('missing Hindi voice shows a clear message and keeps the text',
      (tester) async {
    final h = await TestHarness.create(initialPrefs: {'language_code': 'hi'});
    h.speech.availability = SpeechAvailabilityHelper.missing;
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('category_burns')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('audio_notice')), findsOneWidget);
    expect(find.text(burns.steps.first.text.hi), findsOneWidget);
  });

  testWidgets('emergency button opens the emergency screen', (tester) async {
    await openBurns(tester);
    await tester.tap(find.byKey(const ValueKey('guidance_emergency')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('number_112')), findsOneWidget);
  });

  testWidgets('exit button returns to home and stops audio', (tester) async {
    final h = await openBurns(tester);
    await tester.tap(find.byKey(const ValueKey('exit_guidance')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('app_name')), findsOneWidget);
    expect(h.player.calls, contains('stop'));
  });
}
