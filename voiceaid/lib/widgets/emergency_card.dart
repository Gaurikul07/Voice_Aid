import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'icon_mapper.dart';

/// Large rounded card for one emergency category.
class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    super.key,
    required this.label,
    required this.iconKey,
    required this.onTap,
    this.semanticHint,
  });

  final String label;
  final String iconKey;
  final VoidCallback onTap;
  final String? semanticHint;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      hint: semanticHint,
      child: ExcludeSemantics(
        child: Card(
          color: AppColors.card,
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.teal.withValues(alpha: 0.12),
                    child: Icon(iconFor(iconKey), size: 40, color: AppColors.tealDark),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
