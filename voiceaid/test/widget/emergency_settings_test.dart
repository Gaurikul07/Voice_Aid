import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/models/app_language.dart';

import '../fakes.dart';

Future<TestHarness> openEmergency(WidgetTester tester,
    {bool dialerWorks = true, Map<String, Object> prefs = const {}}) async {
  final h = await TestHarness.create(dialerWorks: dialerWorks, initialPrefs: prefs);
  await tester.pumpWidget(h.app());
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.byKey(const ValueKey('emergency_services_button')));
  await tester.tap(find.byKey(const ValueKey('emergency_services_button')));
  await tester.pumpAndSettle();
  return h;
}

void main() {
  testWidgets('emergency screen shows 112 and a caution about regional service',
      (tester) async {
    await openEmergency(tester);
    expect(find.byKey(const ValueKey('number_112')), findsOneWidget);
    expect(find.textContaining('depend on your state'), findsOneWidget);
  });

  testWidgets('calling requires confirmation; cancel does not open the dialer',
      (tester) async {
    final h = await openEmergency(tester);
    await tester.tap(find.byKey(const ValueKey('call_112')));
    await tester.pumpAndSettle();
    expect(find.text('Open the phone dialer?'), findsOneWidget);
    expect(h.launchedNumbers, isEmpty);

    await tester.tap(find.byKey(const ValueKey('confirm_cancel')));
    await tester.pumpAndSettle();
    expect(h.launchedNumbers, isEmpty);
  });

  testWidgets('confirming opens the dialer with the number', (tester) async {
    final h = await openEmergency(tester);
    await tester.tap(find.byKey(const ValueKey('call_112')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm_call')));
    await tester.pumpAndSettle();
    expect(h.launchedNumbers, ['112']);
  });

  testWidgets('dialer failure shows the number to dial manually', (tester) async {
    await openEmergency(tester, dialerWorks: false).then((_) async {
      await tester.tap(find.byKey(const ValueKey('call_112')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('confirm_call')));
      await tester.pumpAndSettle();
      expect(find.textContaining('dial the number yourself'), findsOneWidget);
    });
  });

  testWidgets('custom contact can be saved with validation', (tester) async {
    final h = await openEmergency(tester);
    expect(find.byKey(const ValueKey('no_contact')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('edit_contact')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('contact_number_field')), '12');
    await tester.tap(find.byKey(const ValueKey('contact_save')));
    await tester.pumpAndSettle();
    expect(find.textContaining('valid phone number'), findsOneWidget);
    expect(h.prefs.customContact, isNull);

    await tester.enterText(find.byKey(const ValueKey('contact_name_field')), 'ANM');
    await tester.enterText(
        find.byKey(const ValueKey('contact_number_field')), '9876543210');
    await tester.tap(find.byKey(const ValueKey('contact_save')));
    await tester.pumpAndSettle();
    expect(h.prefs.customContact?.number, '9876543210');
    expect(find.byKey(const ValueKey('call_custom')), findsOneWidget);
  });

  testWidgets('settings: language buttons, audio switch, disclaimer', (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('open_settings')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('lang_en')), findsOneWidget);
    expect(find.byKey(const ValueKey('lang_hi')), findsOneWidget);
    expect(find.byKey(const ValueKey('settings_disclaimer')), findsOneWidget);
    expect(find.textContaining('does not replace emergency services'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('lang_hi')));
    await tester.pumpAndSettle();
    expect(h.prefs.language, AppLanguage.hindi);
    expect(find.text('सुरक्षा सूचना'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('audio_auto_switch')));
    await tester.pumpAndSettle();
    expect(h.prefs.audioAutoPlay, isFalse);
  });

  testWidgets('settings voice check reports readiness', (tester) async {
    final h = await TestHarness.create();
    await tester.pumpWidget(h.app());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('open_settings')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('check_voice')));
    await tester.tap(find.byKey(const ValueKey('check_voice')));
    await tester.pumpAndSettle();
    expect(find.text('Voice is ready on this phone.'), findsOneWidget);
    expect(h.speech.availability, isNotNull);
  });
}
