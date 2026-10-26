import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/app_language.dart';

/// Checks whether a bundled asset exists (used to detect missing recordings).
abstract class AssetChecker {
  Future<bool> exists(String assetPath);
}

class RootBundleAssetChecker implements AssetChecker {
  const RootBundleAssetChecker();

  @override
  Future<bool> exists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// Plays bundled recordings. Abstract so tests can use a fake.
abstract class RecordingPlayer {
  void Function()? onComplete;
  Future<void> play(String assetPath);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> dispose();
}

class AudioplayersRecordingPlayer implements RecordingPlayer {
  AudioplayersRecordingPlayer() {
    _sub = _player.onPlayerComplete.listen((_) => onComplete?.call());
  }

  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<void>? _sub;

  @override
  void Function()? onComplete;

  @override
  Future<void> play(String assetPath) {
    // AssetSource paths are relative to the "assets/" folder.
    final rel = assetPath.startsWith('assets/')
        ? assetPath.substring('assets/'.length)
        : assetPath;
    return _player.play(AssetSource(rel));
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> resume() => _player.resume();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    await _player.dispose();
  }
}

/// Result of checking whether the phone can speak a language.
enum SpeechAvailability { ready, languageMissing, engineUnavailable }

/// Text-to-speech. Abstract so tests can use a fake.
abstract class SpeechEngine {
  void Function()? onComplete;
  void Function(String message)? onError;
  Future<SpeechAvailability> checkLanguage(AppLanguage language);
  Future<void> speak(String text, AppLanguage language);
  Future<void> stop();
  Future<void> dispose();
}

class FlutterTtsEngine implements SpeechEngine {
  FlutterTtsEngine() {
    try {
      _tts.setCompletionHandler(() => onComplete?.call());
      _tts.setCancelHandler(() {});
      _tts.setErrorHandler((message) => onError?.call('$message'));
    } catch (_) {
      // Handlers are best effort; failures surface when speaking.
    }
  }

  final FlutterTts _tts = FlutterTts();

  @override
  void Function()? onComplete;

  @override
  void Function(String message)? onError;

  @override
  Future<SpeechAvailability> checkLanguage(AppLanguage language) async {
    try {
      final available = await _tts.isLanguageAvailable(language.ttsLocale);
      if (available != true) return SpeechAvailability.languageMissing;
      try {
        // Android only: false means the voice data is not installed
        // (it might need a download, which would need internet).
        final installed = await _tts.isLanguageInstalled(language.ttsLocale);
        if (installed == false) return SpeechAvailability.languageMissing;
      } catch (_) {
        // Not supported on this platform/version: trust isLanguageAvailable.
      }
      return SpeechAvailability.ready;
    } catch (_) {
      return SpeechAvailability.engineUnavailable;
    }
  }

  @override
  Future<void> speak(String text, AppLanguage language) async {
    await _tts.setLanguage(language.ttsLocale);
    await _tts.setSpeechRate(0.4); // slower than normal for clarity
    await _tts.setVolume(1.0);
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }

  @override
  Future<void> dispose() => stop();
}
