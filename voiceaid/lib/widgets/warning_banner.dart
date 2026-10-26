import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/ui_strings.dart';
import '../theme/app_theme.dart';

/// Prominent emergency warning. Uses an icon, a bold title and a thick border,
/// so it does not rely on colour alone.
class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key, required this.message, required this.language});

  final String message;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final title = UiStrings.warningTitle.of(language);
    return Semantics(
      container: true,
      label: '$title. $message',
      child: ExcludeSemantics(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.dangerBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.danger, width: 3),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(message, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
