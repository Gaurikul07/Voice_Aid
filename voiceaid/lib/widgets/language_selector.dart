import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/ui_strings.dart';
import '../state/app_state.dart';

/// Two big buttons to choose Hindi or English. Used in settings.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return Row(
      children: [
        for (final l in AppLanguage.values) ...[
          Expanded(
            child: Semantics(
              button: true,
              selected: scope.language == l,
              label: l.nativeName,
              child: ExcludeSemantics(
                child: scope.language == l
                    ? FilledButton.icon(
                        key: ValueKey('lang_${l.code}'),
                        onPressed: () => scope.state.setLanguage(l),
                        icon: const Icon(Icons.check_circle),
                        label: Text(l.nativeName),
                      )
                    : OutlinedButton(
                        key: ValueKey('lang_${l.code}'),
                        onPressed: () => scope.state.setLanguage(l),
                        child: Text(l.nativeName),
                      ),
              ),
            ),
          ),
          if (l != AppLanguage.values.last) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

/// Compact selector for the home-screen header.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final other = scope.language == AppLanguage.english
        ? AppLanguage.hindi
        : AppLanguage.english;
    return Semantics(
      button: true,
      label: '${UiStrings.language.of(scope.language)}: '
          '${scope.language.nativeName}. ${other.nativeName}',
      child: ExcludeSemantics(
        child: OutlinedButton(
          key: const ValueKey('language_toggle'),
          style: OutlinedButton.styleFrom(minimumSize: const Size(72, 48)),
          onPressed: () => scope.state.setLanguage(other),
          child: Text(other.nativeName),
        ),
      ),
    );
  }
}
