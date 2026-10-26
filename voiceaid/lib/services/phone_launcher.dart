import 'package:url_launcher/url_launcher.dart';

/// Opens the phone dialer with [number] filled in. It never places the call:
/// the user must press the call button in the dialer.
typedef PhoneLauncher = Future<bool> Function(String number);

Future<bool> launchDialer(String number) async {
  try {
    final uri = Uri(scheme: 'tel', path: number);
    return await launchUrl(uri);
  } catch (_) {
    return false;
  }
}
