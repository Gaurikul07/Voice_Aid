# VoiceAid - Offline Voice-Based First-Aid Guidance Assistant

An educational Flutter (Android) prototype that gives simple, step-by-step,
spoken first-aid guidance in **Hindi and English**, **without internet**.

> **Important:** VoiceAid is a prototype for a Design Thinking project. It does
> not diagnose injuries, does not replace emergency services or a doctor, and
> its medical content has **not yet been reviewed by qualified medical
> professionals**. In a real emergency call **112**.
>
> **Build status:** the code was written in an environment without the Flutter
> SDK, so it has **not been compiled, tested with `flutter test`, or built into
> an APK**. See TESTING_REPORT.md and KNOWN_LIMITATIONS.md.

## Problem statement

People in rural areas may have poor connectivity, limited reading ability,
language barriers and little access to reliable first-aid information in the
first minutes of an emergency, when it matters most.

## Features (as implemented in the source)

- Home screen: logo, app name, language toggle, speaker (read-aloud help) button, settings, welcome text.
- Five large emergency cards: Burns, Cuts and Bleeding, Choking, Snakebite, Suspected Fracture.
- Choking asks for **adult / child / infant** first; each has its own separate steps.
- Guidance screen: emergency warning banner, step X of N, short text, icon, Play / Pause-Resume / Replay / Stop, Previous / Next, Emergency help, Exit. Steps never advance automatically.
- "DO NOT" and "GET URGENT HELP" steps are labelled in words and icons, not colour only.
- Hindi and English interface and content (Hindi not yet reviewed by a medical translator).
- Bundled-recording playback with offline text-to-speech fallback; clear message if a voice is missing; text always visible.
- Emergency screen: 112 (verified from the Ministry of Home Affairs), unverified older numbers clearly labelled, user-configurable contact, confirmation dialog before opening the dialer (never auto-calls).
- Settings: language, voice auto-play, voice-support check, app info, safety disclaimer. Preferences stored locally.
- No internet permission needed, no backend, no login, no API key, no health data stored.

## Tech stack

Flutter + Dart, Material 3, `shared_preferences` (settings), `audioplayers`
(bundled audio), `flutter_tts` (offline speech), `url_launcher` (dialer),
`flutter_test` (tests). Content is plain Dart data.

## Architecture

```
UI (screens, widgets)
   |  reads AppScope (InheritedNotifier)
AppState (language, audio pref, contact)  --> PreferencesService --> SharedPreferences
AppServices
   |- FirstAidRepository  --> first_aid_content.dart (bundled Dart data, validated)
   |- GuidanceAudioController --> RecordingPlayer (audioplayers)
   |                          --> SpeechEngine   (flutter_tts)
   |                          --> AssetChecker   (rootBundle)
   '- PhoneLauncher (url_launcher)
```

Models, content, repository and `StepNavigator` are pure Dart (no Flutter
imports) so they can be tested without a device. Platform plugins sit behind
small interfaces so tests use fakes.

Design decisions: Dart data instead of JSON (type safety, runs in plain Dart
tests); `InheritedNotifier` instead of a state-management package (fewer
dependencies, easy to explain); asset existence checked with `rootBundle.load`.

## Folder structure

```
lib/
  main.dart, app.dart
  models/    app_language, localized_text, first_aid_models, ui_strings
  data/      first_aid_content (all instructions), first_aid_repository (+validation)
  logic/     step_navigator
  services/  preferences_service, audio_backends, guidance_audio_controller, phone_launcher
  state/     app_state (AppState, AppServices, AppScope)
  theme/     app_theme
  widgets/   emergency_card, warning_banner, step_card, audio_controls,
             language_selector, confirm_dialog, icon_mapper
  screens/   home, flow_picker, guidance, emergency, settings
assets/audio/<en|hi>/<category>/   (empty - see assets/audio/README.md)
test/        fakes.dart, unit/, widget/
tool/        verify_content.dart (pure Dart), setup_android.sh
```

## Setup

Prerequisites: Flutter 3.27+ (stable) with Android SDK and a device/emulator.

```bash
cd voiceaid
bash tool/setup_android.sh     # generates android/ and patches the manifest
flutter pub get
```

If versions in `pubspec.yaml` do not resolve: `flutter pub upgrade --major-versions`.

## Run

```bash
flutter run
```

## Test

```bash
flutter analyze
flutter test
dart run tool/verify_content.dart     # pure-Dart content checks (no Flutter needed)
```

## Build Android

```bash
flutter build apk --debug     # build/app/outputs/flutter-apk/app-debug.apk
```

## Offline testing

Install the app, open it once, enable airplane mode, force-stop and reopen.
Use the checklist in TESTING_REPORT.md section 5.

## Adding audio recordings

Follow `assets/audio/README.md` (naming `<flowId>_step<NN>.mp3`). No code change needed.

## Limitations

See KNOWN_LIMITATIONS.md. Highlights: unreviewed medical content; not compiled
or built yet; no recordings; device-dependent TTS; no real user testing.

## Future enhancements

Qualified medical review and India-specific sourcing; real recordings by local
speakers; custom illustrations; more languages; CPR and more scenarios;
region-aware emergency numbers; field usability testing; TalkBack audit.

## Documentation

DESIGN_THINKING.md, MEDICAL_CONTENT_SOURCES.md, TESTING_REPORT.md,
PROJECT_PRESENTATION.md, DEMO_SCRIPT.md, KNOWN_LIMITATIONS.md.
