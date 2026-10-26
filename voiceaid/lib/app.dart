import 'package:flutter/material.dart';

import 'models/ui_strings.dart';
import 'screens/home_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

class VoiceAidApp extends StatefulWidget {
  const VoiceAidApp({super.key, required this.services});

  final AppServices services;

  @override
  State<VoiceAidApp> createState() => _VoiceAidAppState();
}

class _VoiceAidAppState extends State<VoiceAidApp> {
  late final AppState _state = AppState(widget.services.prefs);

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      services: widget.services,
      child: Builder(
        builder: (context) => MaterialApp(
          title: UiStrings.appName.en,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: const HomeScreen(),
          // Unknown routes never crash: show a simple, safe page.
          onUnknownRoute: (_) => MaterialPageRoute<void>(
            builder: (ctx) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(UiStrings.notFound.of(AppScope.of(ctx).language)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
