import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/ui_strings.dart';
import '../services/guidance_audio_controller.dart';

/// Play / Pause-Resume / Replay / Stop controls plus a notice area that
/// explains any audio fallback or failure in plain language.
class AudioControls extends StatelessWidget {
  const AudioControls({
    super.key,
    required this.controller,
    required this.language,
    required this.onPlay,
  });

  final GuidanceAudioController controller;
  final AppLanguage language;

  /// Starts (or restarts) the current step's audio.
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final c = controller;
        final showResume = c.canResume;
        final pauseLabel =
            (showResume ? UiStrings.resume : UiStrings.pause).of(language);
        final VoidCallback? pauseAction = showResume
            ? () => c.resume()
            : (c.canPause ? () => c.pause() : null);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _btn(
                  key: 'audio_play',
                  icon: Icons.volume_up,
                  label: UiStrings.play.of(language),
                  onPressed: onPlay,
                  primary: true,
                ),
                _btn(
                  key: 'audio_pause_resume',
                  icon: showResume ? Icons.play_arrow : Icons.pause,
                  label: pauseLabel,
                  onPressed: pauseAction,
                ),
                _btn(
                  key: 'audio_replay',
                  icon: Icons.replay,
                  label: UiStrings.replay.of(language),
                  onPressed: onPlay,
                ),
                _btn(
                  key: 'audio_stop',
                  icon: Icons.stop,
                  label: UiStrings.stop.of(language),
                  onPressed: c.canStop ? () => c.stop() : null,
                ),
              ],
            ),
            if (c.state == PlaybackState.speaking)
              _note(context, UiStrings.pauseUnsupported.of(language)),
            if (_noticeText(c.notice) != null)
              _note(context, _noticeText(c.notice)!, key: 'audio_notice'),
          ],
        );
      },
    );
  }

  String? _noticeText(AudioNotice n) {
    switch (n) {
      case AudioNotice.none:
        return null;
      case AudioNotice.usingPhoneVoice:
        return UiStrings.usingPhoneVoice.of(language);
      case AudioNotice.languageVoiceMissing:
        return UiStrings.voiceMissingLanguage.of(language);
      case AudioNotice.voiceUnavailable:
        return UiStrings.voiceUnavailable.of(language);
      case AudioNotice.recordingError:
        return UiStrings.voicePlaybackError.of(language);
    }
  }

  Widget _note(BuildContext context, String text, {String? key}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Semantics(
        liveRegion: true,
        child: Row(
          key: key == null ? null : ValueKey(key),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, size: 22),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }

  Widget _btn({
    required String key,
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    bool primary = false,
  }) {
    final child = Text(label);
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: ExcludeSemantics(
        child: primary
            ? FilledButton.icon(
                key: ValueKey(key), onPressed: onPressed, icon: Icon(icon), label: child)
            : OutlinedButton.icon(
                key: ValueKey(key), onPressed: onPressed, icon: Icon(icon), label: child),
      ),
    );
  }
}
