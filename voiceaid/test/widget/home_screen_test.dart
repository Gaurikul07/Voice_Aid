import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/models/app_language.dart';
import 'package:voiceaid/screens/guidance_screen.dart';

import '../fakes.dart';

void main() {
  testWidgets('home shows app name, instruction, 5 categories, emergency section',
      (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('app_name')), findsOneWidget);
    expect(find.text('Choose the type of emergency.'), findsOneWidget);
    for (final id in ['burns', 'bleeding', 'choking', 'snakebite', 'fracture']) {
      expect(find.byKey(ValueKey('category_$id')), findsOneWidget, reason: id);
    }
    expect(find.byKey(const ValueKey('emergency_services_button')), findsOneWidget);
    expect(find.byKey(const ValueKey('help_speaker')), findsOneWidget);
    expect(find.byKey(const ValueKey('language_toggle')), findsOneWidget);
    expect(find.byKey(const ValueKey('home_disclaimer')), findsOneWidget);
  });

  testWidgets('language toggle switches the whole interface to Hindi and persists',
      (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('language_toggle')));
    await tester.pumpAndSettle();
    expect(find.text('आपातकाल का प्रकार चुनें।'), findsOneWidget);
    expect(find.text('जलना'), findsOneWidget);
    expect(h.prefs.language, AppLanguage.hindi);
  });

  testWidgets('a stored Hindi preference is applied at startup', (tester) async {
    final h = await TestHarness.create(initialPrefs: {'language_code': 'hi'});
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    expect(find.text('आपातकाल का प्रकार चुनें।'), findsOneWidget);
  });

  testWidgets('help speaker button speaks the welcome message', (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.tap(find.byKey(const ValueKey('help_speaker')));
    await tester.pumpAndSettle();
    expect(h.speech.spoken, isNotEmpty);
    expect(h.speech.spoken.first, startsWith('en:'));
  });

  testWidgets('selecting Burns opens the Burns guidance screen', (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('category_burns')));
    await tester.pumpAndSettle();
    expect(find.byType(GuidanceScreen), findsOneWidget);
    expect(find.byKey(const ValueKey('guidance_title')), findsOneWidget);
  });

  testWidgets('each non-choking category opens its own guidance flow', (tester) async {
    for (final id in ['bleeding', 'snakebite', 'fracture']) {
      final h = await TestHarness.create();
      await tester.pumpWidget(h.app());
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(ValueKey('category_$id')));
      await tester.tap(find.byKey(ValueKey('category_$id')));
      await tester.pumpAndSettle();
      expect(find.byType(GuidanceScreen), findsOneWidget, reason: id);
    }
  });

  testWidgets('choking asks for age group first, then opens that flow',
      (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('category_choking')));
    await tester.tap(find.byKey(const ValueKey('category_choking')));
    await tester.pumpAndSettle();
    expect(find.byType(GuidanceScreen), findsNothing);
    expect(find.text('Who is choking?'), findsOneWidget);
    expect(find.byKey(const ValueKey('flow_adult')), findsOneWidget);
    expect(find.byKey(const ValueKey('flow_child')), findsOneWidget);
    expect(find.byKey(const ValueKey('flow_infant')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('flow_infant')));
    await tester.pumpAndSettle();
    expect(find.byType(GuidanceScreen), findsOneWidget);
    expect(find.text('Choking: Infant'), findsOneWidget);
  });

  testWidgets('home fits a small screen with large system font', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);
    final h = await TestHarness.create();
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(320, 568),
          textScaler: TextScaler.linear(1.6),
        ),
        child: h.app(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
