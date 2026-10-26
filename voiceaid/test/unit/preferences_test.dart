import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voiceaid/models/app_language.dart';
import 'package:voiceaid/services/preferences_service.dart';
import 'package:voiceaid/state/app_state.dart';

void main() {
  test('defaults: English, auto audio on, no contact', () async {
    SharedPreferences.setMockInitialValues({});
    final p = PreferencesService(await SharedPreferences.getInstance());
    expect(p.language, AppLanguage.english);
    expect(p.audioAutoPlay, isTrue);
    expect(p.customContact, isNull);
  });

  test('language selection persists across a "restart"', () async {
    SharedPreferences.setMockInitialValues({});
    final sp = await SharedPreferences.getInstance();
    final state = AppState(PreferencesService(sp));
    await state.setLanguage(AppLanguage.hindi);
    expect(state.language, AppLanguage.hindi);

    final reloaded = AppState(PreferencesService(sp));
    expect(reloaded.language, AppLanguage.hindi);
  });

  test('unknown stored language falls back to English', () async {
    SharedPreferences.setMockInitialValues({PreferencesService.keyLanguage: 'zz'});
    final p = PreferencesService(await SharedPreferences.getInstance());
    expect(p.language, AppLanguage.english);
  });

  test('audio preference persists', () async {
    SharedPreferences.setMockInitialValues({});
    final sp = await SharedPreferences.getInstance();
    await AppState(PreferencesService(sp)).setAudioAutoPlay(false);
    expect(PreferencesService(sp).audioAutoPlay, isFalse);
  });

  test('custom contact validates numbers and persists', () async {
    expect(CustomContact.isValidNumber('9876543210'), isTrue);
    expect(CustomContact.isValidNumber('+919876543210'), isTrue);
    expect(CustomContact.isValidNumber('12'), isFalse);
    expect(CustomContact.isValidNumber('abc123'), isFalse);
    expect(CustomContact.isValidNumber('1234567890123456'), isFalse);

    SharedPreferences.setMockInitialValues({});
    final p = PreferencesService(await SharedPreferences.getInstance());
    await p.setCustomContact(const CustomContact(name: 'ANM', number: '9876543210'));
    expect(p.customContact?.number, '9876543210');
    await p.setCustomContact(null);
    expect(p.customContact, isNull);
  });

  test('an invalid stored contact number is ignored', () async {
    SharedPreferences.setMockInitialValues(
        {PreferencesService.keyContactNumber: 'not-a-number'});
    final p = PreferencesService(await SharedPreferences.getInstance());
    expect(p.customContact, isNull);
  });
}
