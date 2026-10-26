import 'package:flutter/material.dart';

import '../models/ui_strings.dart';
import '../services/preferences_service.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/confirm_dialog.dart';

/// Emergency numbers. Works fully offline. Never places a call itself: it
/// asks for confirmation, then opens the dialer.
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Future<void> _call(BuildContext context, String number) async {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final messenger = ScaffoldMessenger.of(context);
    final ok = await confirmCall(context, language: lang, number: number);
    if (!ok) return;
    final opened = await scope.services.phoneLauncher(number);
    if (!opened) {
      messenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 8),
          content: Text('${UiStrings.callFailed.of(lang)} $number'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final theme = Theme.of(context);
    final contact = scope.state.customContact;

    return Scaffold(
      appBar: AppBar(title: Text(UiStrings.emergencyHelp.of(lang))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.dangerBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.danger, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(UiStrings.nationalNumber.of(lang), style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('112',
                      key: const ValueKey('number_112'),
                      style: theme.textTheme.headlineSmall?.copyWith(fontSize: 56)),
                  const SizedBox(height: 4),
                  Text(UiStrings.nationalNumberNote.of(lang), style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    key: const ValueKey('call_112'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(64),
                    ),
                    onPressed: () => _call(context, '112'),
                    icon: const Icon(Icons.call),
                    label: Text('${UiStrings.call.of(lang)} 112'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(UiStrings.myContact.of(lang), style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(UiStrings.myContactNote.of(lang), style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            if (contact == null)
              Text(UiStrings.noContact.of(lang), key: const ValueKey('no_contact'))
            else
              FilledButton.icon(
                key: const ValueKey('call_custom'),
                onPressed: () => _call(context, contact.number),
                icon: const Icon(Icons.call),
                label: Text(
                    '${UiStrings.call.of(lang)} ${contact.name.isEmpty ? '' : '${contact.name} '}${contact.number}'),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    key: const ValueKey('edit_contact'),
                    onPressed: () => _editContact(context, contact),
                    icon: const Icon(Icons.edit),
                    label: Text(UiStrings.editContact.of(lang)),
                  ),
                ),
                if (contact != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('clear_contact'),
                      onPressed: () => scope.state.setCustomContact(null),
                      icon: const Icon(Icons.delete_outline),
                      label: Text(UiStrings.clear.of(lang)),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            Text(UiStrings.otherNumbers.of(lang), style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(UiStrings.otherNumbersNote.of(lang), style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            _other(context, '108', UiStrings.ambulance.of(lang)),
            const SizedBox(height: 8),
            _other(context, '100', UiStrings.police.of(lang)),
            const SizedBox(height: 8),
            _other(context, '101', UiStrings.fire.of(lang)),
            const SizedBox(height: 16),
            Text(UiStrings.disclaimerShort.of(lang), style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _other(BuildContext context, String number, String label) {
    final lang = AppScope.of(context).language;
    return OutlinedButton.icon(
      key: ValueKey('call_$number'),
      onPressed: () => _call(context, number),
      icon: const Icon(Icons.call),
      label: Text('${UiStrings.call.of(lang)} $label ($number)'),
    );
  }

  Future<void> _editContact(BuildContext context, CustomContact? current) async {
    final scope = AppScope.of(context);
    final lang = scope.language;
    final nameCtl = TextEditingController(text: current?.name ?? '');
    final numCtl = TextEditingController(text: current?.number ?? '');
    String? error;
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(UiStrings.myContact.of(lang)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  key: const ValueKey('contact_name_field'),
                  controller: nameCtl,
                  decoration: InputDecoration(labelText: UiStrings.contactName.of(lang)),
                ),
                const SizedBox(height: 8),
                TextField(
                  key: const ValueKey('contact_number_field'),
                  controller: numCtl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: UiStrings.contactNumber.of(lang),
                    errorText: error,
                    errorMaxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(UiStrings.cancel.of(lang)),
            ),
            FilledButton(
              key: const ValueKey('contact_save'),
              onPressed: () async {
                final number = numCtl.text.trim();
                if (!CustomContact.isValidNumber(number)) {
                  setState(() => error = UiStrings.invalidNumber.of(lang));
                  return;
                }
                await scope.state.setCustomContact(
                  CustomContact(name: nameCtl.text.trim(), number: number),
                );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: Text(UiStrings.save.of(lang)),
            ),
          ],
        ),
      ),
    );
    nameCtl.dispose();
    numCtl.dispose();
  }
}
