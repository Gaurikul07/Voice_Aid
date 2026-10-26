import 'package:flutter/material.dart';

import '../models/first_aid_models.dart';
import '../models/ui_strings.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/emergency_card.dart';
import '../widgets/language_selector.dart';
import 'emergency_screen.dart';
import 'flow_picker_screen.dart';
import 'guidance_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, EmergencyCategory category) {
    final Widget page = category.hasMultipleFlows
        ? FlowPickerScreen(category: category)
        : GuidanceScreen(category: category, flow: category.flows.first);
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final services = scope.services;
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    final cardHeight = (170 * textScale).clamp(170.0, 300.0);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        titleSpacing: 12,
        title: Row(
          children: [
            const Icon(Icons.medical_services, color: AppColors.teal, size: 36),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                UiStrings.appName.of(lang),
                key: const ValueKey('app_name'),
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          const LanguageToggle(),
          const SizedBox(width: 4),
          Semantics(
            button: true,
            label: UiStrings.speakerHelp.of(lang),
            child: ExcludeSemantics(
              child: IconButton(
                key: const ValueKey('help_speaker'),
                iconSize: 32,
                constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
                tooltip: UiStrings.speakerHelp.of(lang),
                icon: const Icon(Icons.volume_up),
                onPressed: () =>
                    services.audio.speakPlain(UiStrings.helpSpoken.of(lang), lang),
              ),
            ),
          ),
          Semantics(
            button: true,
            label: UiStrings.settings.of(lang),
            child: ExcludeSemantics(
              child: IconButton(
                key: const ValueKey('open_settings'),
                iconSize: 32,
                constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
                tooltip: UiStrings.settings.of(lang),
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UiStrings.welcome.of(lang),
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 6),
                    Text(
                      UiStrings.chooseEmergency.of(lang),
                      key: const ValueKey('choose_emergency'),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  mainAxisExtent: cardHeight,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final c = services.repository.categories[i];
                    return KeyedSubtree(
                      key: ValueKey('category_${c.id}'),
                      child: EmergencyCard(
                        label: c.label.of(lang),
                        iconKey: c.iconKey,
                        onTap: () => _open(context, c),
                      ),
                    );
                  },
                  childCount: services.repository.categories.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Semantics(
                  button: true,
                  label: UiStrings.emergencyServices.of(lang),
                  hint: UiStrings.emergencyServicesHint.of(lang),
                  child: ExcludeSemantics(
                    child: FilledButton.icon(
                      key: const ValueKey('emergency_services_button'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.danger,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(72),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (_) => const EmergencyScreen()),
                      ),
                      icon: const Icon(Icons.phone_in_talk, size: 32),
                      label: Text(UiStrings.emergencyServices.of(lang)),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  UiStrings.disclaimerShort.of(lang),
                  key: const ValueKey('home_disclaimer'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
