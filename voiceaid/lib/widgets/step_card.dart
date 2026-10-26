import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/first_aid_models.dart';
import '../models/ui_strings.dart';
import '../theme/app_theme.dart';
import 'icon_mapper.dart';

/// Shows the current step: type label, icon, and the instruction text.
/// Type is conveyed by a text label + icon + border, not colour alone.
class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.step,
    required this.number,
    required this.total,
    required this.language,
  });

  final FirstAidStep step;
  final int number;
  final int total;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late final String typeLabel;
    late final IconData typeIcon;
    late final Color accent;
    late final Color bg;
    switch (step.type) {
      case StepType.action:
        typeLabel = UiStrings.doThis.of(language);
        typeIcon = Icons.check_circle_outline;
        accent = AppColors.tealDark;
        bg = AppColors.card;
      case StepType.avoid:
        typeLabel = UiStrings.doNot.of(language);
        typeIcon = Icons.block;
        accent = AppColors.danger;
        bg = AppColors.dangerBg;
      case StepType.urgent:
        typeLabel = UiStrings.urgentHelp.of(language);
        typeIcon = Icons.local_hospital;
        accent = const Color(0xFF8A5A00);
        bg = AppColors.warnBg;
    }
    final stepWord = UiStrings.step.of(language);
    final ofWord = UiStrings.of_.of(language);
    final text = step.text.of(language);

    return Semantics(
      container: true,
      liveRegion: true,
      label: '$stepWord $number $ofWord $total. $typeLabel. $text',
      child: ExcludeSemantics(
        child: Container(
          key: const ValueKey('step_card'),
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accent, width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$stepWord $number $ofWord $total',
                key: const ValueKey('step_counter'),
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: total == 0 ? 0 : number / total,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(typeIcon, color: accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      typeLabel,
                      style: theme.textTheme.titleMedium?.copyWith(color: accent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: Icon(iconFor(step.iconKey), size: 72, color: accent),
              ),
              const SizedBox(height: 12),
              Text(
                text,
                key: const ValueKey('step_text'),
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
