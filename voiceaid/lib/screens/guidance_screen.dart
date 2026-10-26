import 'package:flutter/material.dart';

import '../logic/step_navigator.dart';
import '../models/first_aid_models.dart';
import '../models/ui_strings.dart';
import '../state/app_state.dart';
import '../widgets/audio_controls.dart';
import '../widgets/step_card.dart';
import '../widgets/warning_banner.dart';
import 'emergency_screen.dart';

/// Step-by-step guidance. Steps change ONLY when the user presses Previous or
/// Next: nothing advances automatically.
class GuidanceScreen extends StatefulWidget {
  const GuidanceScreen({super.key, required this.category, required this.flow});

  final EmergencyCategory category;
  final GuidanceFlow flow;

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  late final StepNavigator _nav = StepNavigator(widget.flow.steps.length);
  bool _started = false;
  AppServices? _services;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = AppScope.of(context);
    _services = scope.services;
    if (!_started) {
      _started = true;
      if (scope.state.audioAutoPlay && !_nav.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _playCurrent();
        });
      }
    }
  }

  @override
  void dispose() {
    _services?.audio.stopSilently();
    super.dispose();
  }

  Future<void> _playCurrent() async {
    if (_nav.isEmpty) return;
    final scope = AppScope.of(context);
    final lang = scope.language;
    final step = widget.flow.steps[_nav.index];
    await scope.services.audio.playStep(
      assetPath: widget.flow.audioAssetPath(
        languageCode: lang.code,
        categoryId: widget.category.id,
        stepIndex: _nav.index,
      ),
      text: step.text.of(lang),
      language: lang,
    );
  }

  void _move(bool forward) {
    final scope = AppScope.of(context);
    final moved = forward ? _nav.next() : _nav.previous();
    if (!moved) return;
    setState(() {});
    scope.services.audio.stop();
    if (scope.state.audioAutoPlay) _playCurrent();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final flow = widget.flow;

    if (_nav.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(flow.title.of(lang))),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                WarningBanner(
                    message: UiStrings.contentUnavailable.of(lang), language: lang),
                const SizedBox(height: 16),
                FilledButton.icon(
                  key: const ValueKey('error_emergency'),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const EmergencyScreen()),
                  ),
                  icon: const Icon(Icons.phone_in_talk),
                  label: Text(UiStrings.emergencyHelp.of(lang)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final step = flow.steps[_nav.index];
    return Scaffold(
      appBar: AppBar(
        title: Text(flow.title.of(lang), key: const ValueKey('guidance_title')),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WarningBanner(message: flow.warning.of(lang), language: lang),
            const SizedBox(height: 14),
            StepCard(
              step: step,
              number: _nav.number,
              total: flow.steps.length,
              language: lang,
            ),
            const SizedBox(height: 14),
            AudioControls(
              controller: scope.services.audio,
              language: lang,
              onPlay: _playCurrent,
            ),
            if (flow.needsClinicalReview) ...[
              const SizedBox(height: 14),
              Text(
                UiStrings.reviewNotice.of(lang),
                key: const ValueKey('review_notice'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('prev_step'),
                      onPressed: _nav.canGoPrevious ? () => _move(false) : null,
                      icon: const Icon(Icons.arrow_back),
                      label: Text(UiStrings.previous.of(lang)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      key: const ValueKey('next_step'),
                      onPressed: _nav.isLast
                          ? () => Navigator.of(context).pop()
                          : () => _move(true),
                      icon: Icon(_nav.isLast ? Icons.check : Icons.arrow_forward),
                      label: Text(
                          (_nav.isLast ? UiStrings.done : UiStrings.next).of(lang)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('guidance_emergency'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const EmergencyScreen()),
                      ),
                      icon: const Icon(Icons.phone_in_talk),
                      label: Text(UiStrings.emergencyHelp.of(lang)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('exit_guidance'),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      label: Text(UiStrings.exitGuidance.of(lang)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
