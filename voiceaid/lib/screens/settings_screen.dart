import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/ui_strings.dart';
import '../services/audio_backends.dart';
import '../state/app_state.dart';
import '../widgets/language_selector.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SpeechAvailability? _result;
  AppLanguage? _checkedLanguage;
  bool _checking = false;

  Future<void> _checkVoice() async {
    final scope = AppScope.of(context);
    final lang = scope.language;
    setState(() => _checking = true);
    final r = await scope.services.audio.speechAvailability(lang);
    if (!mounted) return;
    setState(() {
      _result = r;
      _checkedLanguage = lang;
      _checking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final theme = Theme.of(context);

    String? voiceMessage;
    if (_result != null && _checkedLanguage == lang) {
      switch (_result!) {
        case SpeechAvailability.ready:
          voiceMessage = UiStrings.voiceReady.of(lang);
        case SpeechAvailability.languageMissing:
          voiceMessage = UiStrings.voiceMissingLanguage.of(lang);
        case SpeechAvailability.engineUnavailable:
          voiceMessage = UiStrings.voiceUnavailable.of(lang);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(UiStrings.settings.of(lang))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(UiStrings.language.of(lang), style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            const LanguageSelector(),
            const SizedBox(height: 24),
            SwitchListTile(
              key: const ValueKey('audio_auto_switch'),
              contentPadding: EdgeInsets.zero,
              title: Text(UiStrings.audioAuto.of(lang), style: theme.textTheme.bodyLarge),
              subtitle: Text(UiStrings.audioAutoHint.of(lang)),
              value: scope.state.audioAutoPlay,
              onChanged: (v) => scope.state.setAudioAutoPlay(v),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              key: const ValueKey('check_voice'),
              onPressed: _checking ? null : _checkVoice,
              icon: const Icon(Icons.record_voice_over),
              label: Text(UiStrings.voiceCheck.of(lang)),
            ),
            if (voiceMessage != null) ...[
              const SizedBox(height: 8),
              Text(voiceMessage, key: const ValueKey('voice_check_result')),
            ],
            const SizedBox(height: 24),
            Text(UiStrings.appInfo.of(lang), style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('VoiceAid 0.1.0 (${UiStrings.worksOffline.of(lang)})',
                style: theme.textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(UiStrings.appInfoBody.of(lang), style: theme.textTheme.bodyMedium),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.health_and_safety),
                    const SizedBox(width: 8),
                    Text(UiStrings.disclaimerTitle.of(lang),
                        style: theme.textTheme.titleMedium),
                  ]),
                  const SizedBox(height: 8),
                  Text(UiStrings.disclaimer.of(lang),
                      key: const ValueKey('settings_disclaimer'),
                      style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
