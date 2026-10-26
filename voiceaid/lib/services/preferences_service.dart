import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_language.dart';

/// A contact the user saved themselves (e.g. local health worker).
class CustomContact {
  const CustomContact({required this.name, required this.number});
  final String name;
  final String number;

  /// 3 to 15 digits, optional leading +. Prevents junk being dialled.
  static bool isValidNumber(String raw) {
    return RegExp(r'^\+?[0-9]{3,15}$').hasMatch(raw.trim());
  }
}

/// Stores only app settings locally. NO health information is stored.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const keyLanguage = 'language_code';
  static const keyAudioAuto = 'audio_auto_play';
  static const keyContactName = 'custom_contact_name';
  static const keyContactNumber = 'custom_contact_number';

  AppLanguage get language => AppLanguage.fromCode(_prefs.getString(keyLanguage));
  Future<void> setLanguage(AppLanguage l) => _prefs.setString(keyLanguage, l.code);

  bool get audioAutoPlay => _prefs.getBool(keyAudioAuto) ?? true;
  Future<void> setAudioAutoPlay(bool v) => _prefs.setBool(keyAudioAuto, v);

  CustomContact? get customContact {
    final number = _prefs.getString(keyContactNumber);
    if (number == null || !CustomContact.isValidNumber(number)) return null;
    return CustomContact(
      name: _prefs.getString(keyContactName) ?? '',
      number: number,
    );
  }

  Future<void> setCustomContact(CustomContact? c) async {
    if (c == null) {
      await _prefs.remove(keyContactName);
      await _prefs.remove(keyContactNumber);
      return;
    }
    await _prefs.setString(keyContactName, c.name.trim());
    await _prefs.setString(keyContactNumber, c.number.trim());
  }
}
