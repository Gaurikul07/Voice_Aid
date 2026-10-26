import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voiceaid/app.dart';
import 'package:voiceaid/models/app_language.dart';
import 'package:voiceaid/services/audio_backends.dart';
import 'package:voiceaid/services/guidance_audio_controller.dart';
import 'package:voiceaid/services/preferences_service.dart';
import 'package:voiceaid/state/app_state.dart';

class FakeAssetChecker implements AssetChecker {
  FakeAssetChecker([this.existing = const {}]);
  final Set<String> existing;
  @override
  Future<bool> exists(String assetPath) async => existing.contains(assetPath);
}

class FakeRecordingPlayer implements RecordingPlayer {
  final List<String> calls = [];
  bool failOnPlay = false;
  @override
  void Function()? onComplete;
  @override
  Future<void> play(String assetPath) async {
    if (failOnPlay) throw Exception('boom');
    calls.add('play:$assetPath');
  }

  @override
  Future<void> pause() async => calls.add('pause');
  @override
  Future<void> resume() async => calls.add('resume');
  @override
  Future<void> stop() async => calls.add('stop');
  @override
  Future<void> dispose() async {}
}

class FakeSpeechEngine implements SpeechEngine {
  SpeechAvailability availability = SpeechAvailability.ready;
  bool failOnSpeak = false;
  final List<String> spoken = [];
  @override
  void Function()? onComplete;
  @override
  void Function(String message)? onError;
  @override
  Future<SpeechAvailability> checkLanguage(AppLanguage language) async => availability;
  @override
  Future<void> speak(String text, AppLanguage language) async {
    if (failOnSpeak) throw Exception('tts failed');
    spoken.add('${language.code}:$text');
  }

  @override
  Future<void> stop() async {}
  @override
  Future<void> dispose() async {}
}

class TestHarness {
  TestHarness._(this.prefs, this.player, this.speech, this.audio, this.services,
      this.launchedNumbers);

  final PreferencesService prefs;
  final FakeRecordingPlayer player;
  final FakeSpeechEngine speech;
  final GuidanceAudioController audio;
  final AppServices services;
  final List<String> launchedNumbers;

  static Future<TestHarness> create({
    Map<String, Object> initialPrefs = const {},
    Set<String> existingAssets = const {},
    bool dialerWorks = true,
  }) async {
    SharedPreferences.setMockInitialValues(initialPrefs);
    final prefs = PreferencesService(await SharedPreferences.getInstance());
    final player = FakeRecordingPlayer();
    final speech = FakeSpeechEngine();
    final audio = GuidanceAudioController(
      player: player,
      speech: speech,
      assets: FakeAssetChecker(existingAssets),
    );
    final launched = <String>[];
    final services = AppServices(
      prefs: prefs,
      audio: audio,
      phoneLauncher: (n) async {
        launched.add(n);
        return dialerWorks;
      },
    );
    return TestHarness._(prefs, player, speech, audio, services, launched);
  }

  Widget app() => VoiceAidApp(services: services);
}

/// Small helper so widget tests read clearly.
class SpeechAvailabilityHelper {
  static const missing = SpeechAvailability.languageMissing;
}
