import 'package:flutter/foundation.dart';

import '../models/app_language.dart';
import 'audio_backends.dart';

enum PlaybackState {
  idle,
  playingRecording,
  pausedRecording,
  speaking,

  /// No audio could be produced; the on-screen text is the fallback.
  unavailable,
}

enum AudioNotice {
  none,
  usingPhoneVoice,
  languageVoiceMissing,
  voiceUnavailable,
  recordingError,
}

/// Plays guidance audio: a bundled recording if it exists, otherwise offline
/// text-to-speech, otherwise nothing (the screen always shows the text).
/// It never throws to the UI: all failures become a [AudioNotice].
class GuidanceAudioController extends ChangeNotifier {
  GuidanceAudioController({
    required RecordingPlayer player,
    required SpeechEngine speech,
    required AssetChecker assets,
  })  : _player = player,
        _speech = speech,
        _assets = assets {
    _player.onComplete = _onFinished;
    _speech.onComplete = _onFinished;
    _speech.onError = (_) => _onSpeechError();
  }

  final RecordingPlayer _player;
  final SpeechEngine _speech;
  final AssetChecker _assets;

  PlaybackState _state = PlaybackState.idle;
  AudioNotice _notice = AudioNotice.none;
  int _token = 0; // invalidates stale async work when a new request starts
  bool _disposed = false;

  PlaybackState get state => _state;
  AudioNotice get notice => _notice;
  bool get isPlaying =>
      _state == PlaybackState.playingRecording ||
      _state == PlaybackState.speaking;

  /// Pause/resume only works for recordings (flutter_tts cannot pause on
  /// Android), so the UI uses this to decide what to enable.
  bool get canPause => _state == PlaybackState.playingRecording;
  bool get canResume => _state == PlaybackState.pausedRecording;
  bool get canStop => isPlaying || _state == PlaybackState.pausedRecording;

  Future<SpeechAvailability> speechAvailability(AppLanguage language) =>
      _speech.checkLanguage(language);

  /// Plays one step: recording first, then TTS fallback.
  Future<void> playStep({
    required String assetPath,
    required String text,
    required AppLanguage language,
  }) async {
    final token = ++_token;
    await _haltBackends();
    if (token != _token) return;

    var recordingFailed = false;
    if (await _assets.exists(assetPath)) {
      if (token != _token) return;
      try {
        await _player.play(assetPath);
        if (token != _token) return;
        _set(PlaybackState.playingRecording, AudioNotice.none);
        return;
      } catch (_) {
        recordingFailed = true;
      }
    }
    if (token != _token) return;
    await _speakFallback(text, language, token, recordingFailed);
  }

  /// Speaks arbitrary text with TTS only (e.g. the home-screen help button).
  Future<void> speakPlain(String text, AppLanguage language) async {
    final token = ++_token;
    await _haltBackends();
    if (token != _token) return;
    await _speakFallback(text, language, token, false);
  }

  Future<void> _speakFallback(
    String text,
    AppLanguage language,
    int token,
    bool recordingFailed,
  ) async {
    final availability = await _speech.checkLanguage(language);
    if (token != _token) return;
    switch (availability) {
      case SpeechAvailability.ready:
        try {
          await _speech.speak(text, language);
          if (token != _token) return;
          _set(
            PlaybackState.speaking,
            recordingFailed ? AudioNotice.recordingError : AudioNotice.usingPhoneVoice,
          );
        } catch (_) {
          if (token != _token) return;
          _set(PlaybackState.unavailable, AudioNotice.voiceUnavailable);
        }
      case SpeechAvailability.languageMissing:
        _set(PlaybackState.unavailable, AudioNotice.languageVoiceMissing);
      case SpeechAvailability.engineUnavailable:
        _set(
          PlaybackState.unavailable,
          recordingFailed ? AudioNotice.recordingError : AudioNotice.voiceUnavailable,
        );
    }
  }

  Future<void> pause() async {
    if (!canPause) return;
    try {
      await _player.pause();
      _set(PlaybackState.pausedRecording, _notice);
    } catch (_) {
      _set(PlaybackState.unavailable, AudioNotice.recordingError);
    }
  }

  Future<void> resume() async {
    if (!canResume) return;
    try {
      await _player.resume();
      _set(PlaybackState.playingRecording, _notice);
    } catch (_) {
      _set(PlaybackState.unavailable, AudioNotice.recordingError);
    }
  }

  Future<void> stop() async {
    _token++;
    await _haltBackends();
    _set(PlaybackState.idle, AudioNotice.none);
  }

  /// For use in State.dispose(): stops audio without notifying listeners
  /// (notifying while the widget tree is being torn down can throw).
  void stopSilently() {
    _token++;
    _state = PlaybackState.idle;
    _notice = AudioNotice.none;
    _haltBackends();
  }

  Future<void> _haltBackends() async {
    try {
      await _player.stop();
    } catch (_) {}
    try {
      await _speech.stop();
    } catch (_) {}
  }

  void _onFinished() => _set(PlaybackState.idle, AudioNotice.none);

  void _onSpeechError() =>
      _set(PlaybackState.unavailable, AudioNotice.voiceUnavailable);

  void _set(PlaybackState s, AudioNotice n) {
    _state = s;
    _notice = n;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _token++;
    _player.dispose();
    _speech.dispose();
    super.dispose();
  }
}
