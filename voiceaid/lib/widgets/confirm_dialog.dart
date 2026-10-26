import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../models/ui_strings.dart';

/// Asks the user to confirm before opening the phone dialer.
Future<bool> confirmCall(
  BuildContext context, {
  required AppLanguage language,
  required String number,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(UiStrings.confirmCallTitle.of(language)),
      content: Text('$number\n\n${UiStrings.confirmCallBody.of(language)}',
          style: Theme.of(ctx).textTheme.bodyMedium),
      actions: [
        OutlinedButton(
          key: const ValueKey('confirm_cancel'),
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(UiStrings.cancel.of(language)),
        ),
        FilledButton.icon(
          key: const ValueKey('confirm_call'),
          onPressed: () => Navigator.of(ctx).pop(true),
          icon: const Icon(Icons.call),
          label: Text(UiStrings.call.of(language)),
        ),
      ],
    ),
  );
  return result ?? false;
}
