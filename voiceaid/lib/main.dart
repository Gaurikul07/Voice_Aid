import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'services/audio_backends.dart';
import 'services/guidance_audio_controller.dart';
import 'services/preferences_service.dart';
import 'state/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferencesService(await SharedPreferences.getInstance());
  final audio = GuidanceAudioController(
    player: AudioplayersRecordingPlayer(),
    speech: FlutterTtsEngine(),
    assets: const RootBundleAssetChecker(),
  );
  runApp(VoiceAidApp(services: AppServices(prefs: prefs, audio: audio)));
}
