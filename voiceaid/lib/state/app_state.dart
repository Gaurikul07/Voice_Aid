import 'package:flutter/material.dart';

import '../data/first_aid_repository.dart';
import '../models/app_language.dart';
import '../services/guidance_audio_controller.dart';
import '../services/phone_launcher.dart';
import '../services/preferences_service.dart';

/// Long-lived services shared by all screens.
class AppServices {
  AppServices({
    required this.prefs,
    required this.audio,
    this.repository = const FirstAidRepository(),
    this.phoneLauncher = launchDialer,
  });

  final PreferencesService prefs;
  final GuidanceAudioController audio;
  final FirstAidRepository repository;
  final PhoneLauncher phoneLauncher;
}

/// Observable user settings, persisted through [PreferencesService].
class AppState extends ChangeNotifier {
  AppState(this._prefs)
      : _language = _prefs.language,
        _audioAutoPlay = _prefs.audioAutoPlay,
        _contact = _prefs.customContact;

  final PreferencesService _prefs;
  AppLanguage _language;
  bool _audioAutoPlay;
  CustomContact? _contact;

  AppLanguage get language => _language;
  bool get audioAutoPlay => _audioAutoPlay;
  CustomContact? get customContact => _contact;

  Future<void> setLanguage(AppLanguage l) async {
    if (l == _language) return;
    _language = l;
    notifyListeners();
    await _prefs.setLanguage(l);
  }

  Future<void> setAudioAutoPlay(bool v) async {
    _audioAutoPlay = v;
    notifyListeners();
    await _prefs.setAudioAutoPlay(v);
  }

  Future<void> setCustomContact(CustomContact? c) async {
    _contact = c;
    notifyListeners();
    await _prefs.setCustomContact(c);
  }
}

/// Gives widgets access to [AppState] and [AppServices].
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required this.services,
    required super.child,
  }) : super(notifier: state);

  final AppServices services;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope missing above this widget');
    return scope!;
  }

  AppState get state => notifier!;
  AppLanguage get language => notifier!.language;

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      super.updateShouldNotify(oldWidget) || services != oldWidget.services;
}
