import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/models/app_language.dart';
import 'package:voiceaid/services/audio_backends.dart';
import 'package:voiceaid/services/guidance_audio_controller.dart';

import '../fakes.dart';

void main() {
  const path = 'assets/audio/en/burns/burns_step01.mp3';
  late FakeRecordingPlayer player;
  late FakeSpeechEngine speech;

  GuidanceAudioController make(Set<String> assets) {
    player = FakeRecordingPlayer();
    speech = FakeSpeechEngine();
    return GuidanceAudioController(
        player: player, speech: speech, assets: FakeAssetChecker(assets));
  }

  test('plays the bundled recording when the asset exists', () async {
    final c = make({path});
    await c.playStep(assetPath: path, text: 'Hi', language: AppLanguage.english);
    expect(c.state, PlaybackState.playingRecording);
    expect(player.calls, contains('play:$path'));
    expect(speech.spoken, isEmpty);
  });

  test('falls back to TTS when the recording is missing', () async {
    final c = make({});
    await c.playStep(assetPath: path, text: 'Hello', language: AppLanguage.english);
    expect(c.state, PlaybackState.speaking);
    expect(c.notice, AudioNotice.usingPhoneVoice);
    expect(speech.spoken, ['en:Hello']);
  });

  test('missing language voice: no crash, clear notice', () async {
    final c = make({});
    speech.availability = SpeechAvailability.languageMissing;
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.hindi);
    expect(c.state, PlaybackState.unavailable);
    expect(c.notice, AudioNotice.languageVoiceMissing);
  });

  test('TTS engine unavailable: no crash', () async {
    final c = make({});
    speech.availability = SpeechAvailability.engineUnavailable;
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    expect(c.state, PlaybackState.unavailable);
    expect(c.notice, AudioNotice.voiceUnavailable);
  });

  test('TTS speak throwing is handled', () async {
    final c = make({});
    speech.failOnSpeak = true;
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    expect(c.state, PlaybackState.unavailable);
  });

  test('recording playback error falls back to TTS and reports it', () async {
    final c = make({path});
    player.failOnPlay = true;
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    expect(c.state, PlaybackState.speaking);
    expect(c.notice, AudioNotice.recordingError);
  });

  test('pause and resume work for recordings only', () async {
    final c = make({path});
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    expect(c.canPause, isTrue);
    await c.pause();
    expect(c.state, PlaybackState.pausedRecording);
    expect(c.canResume, isTrue);
    await c.resume();
    expect(c.state, PlaybackState.playingRecording);

    final t = make({});
    await t.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    expect(t.canPause, isFalse);
  });

  test('stop returns to idle; completion returns to idle', () async {
    final c = make({path});
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    await c.stop();
    expect(c.state, PlaybackState.idle);
    await c.playStep(assetPath: path, text: 'x', language: AppLanguage.english);
    player.onComplete?.call();
    expect(c.state, PlaybackState.idle);
  });
}
