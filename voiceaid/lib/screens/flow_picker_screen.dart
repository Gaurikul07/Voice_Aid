import 'package:flutter/material.dart';

import '../models/first_aid_models.dart';
import '../models/ui_strings.dart';
import '../state/app_state.dart';
import '../widgets/emergency_card.dart';
import '../widgets/warning_banner.dart';
import 'guidance_screen.dart';

/// Lets the user pick the age group (used for choking) BEFORE any steps are
/// shown, so adult, child and infant procedures are never mixed.
class FlowPickerScreen extends StatelessWidget {
  const FlowPickerScreen({super.key, required this.category});

  final EmergencyCategory category;

  @override
  Widget build(BuildContext context) {
    final lang = AppScope.of(context).language;
    return Scaffold(
      appBar: AppBar(title: Text(category.label.of(lang))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WarningBanner(message: category.flows.first.warning.of(lang), language: lang),
            const SizedBox(height: 16),
            Text(UiStrings.chooseAge.of(lang),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(UiStrings.chooseAgeHint.of(lang),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            for (final f in category.flows) ...[
              SizedBox(
                height: 150,
                child: KeyedSubtree(
                  key: ValueKey('flow_${f.id}'),
                  child: EmergencyCard(
                    label: '${f.title.of(lang)}\n${f.subtitle.of(lang)}',
                    iconKey: f.iconKey,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => GuidanceScreen(category: category, flow: f),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}
