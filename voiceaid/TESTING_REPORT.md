# Testing Report

Report date: 22 October 2026. **Read the "What was NOT run" section first.**

## 1. What was NOT run (and why)

The environment where this project was authored had no Flutter SDK, and network
access to `pub.dev`, `storage.googleapis.com` (Flutter/Dart SDK engine
downloads), `dl.google.com` and `maven.google.com` (Android SDK) was blocked.
These were checked with `curl` (all returned no HTTP response). Therefore:

| Command | Status |
|---------|--------|
| `flutter pub get` | **NOT RUN** (no Flutter SDK; pub.dev unreachable) |
| `flutter analyze` | **NOT RUN** |
| `flutter test` | **NOT RUN** - the 60 Flutter tests below (33 unit + 27 widget) have **never been executed** |
| `flutter build apk` | **NOT RUN - there is NO Android build** |
| Airplane-mode test on a device/emulator | **NOT RUN** |
| TalkBack / large-font checks on a device | **NOT RUN** |

No test result below should be read as "the Flutter app works". It means the
tests are written and are ready to run.

## 2. What WAS actually run

A standalone Dart SDK 3.13.6 (from conda-forge) was installed to check the
parts of the code that do not depend on Flutter (models, content, repository,
step navigator).

```
$ dart analyze lib/models lib/data lib/logic tool
Analyzing models, data, logic, tool...
No issues found!

$ dart run tool/verify_content.dart
155 checks, 0 failed.
```

(`dart run` also printed "Got socket error trying to find package
shared_preferences at https://pub.dev", because pub.dev is blocked; the script
itself does not need that package and completed.)

`tool/verify_content.dart` checks: five categories in order; three separate
choking flows; every flow has warning/do-NOT/urgent steps and a source; burns
and snakebite forbidden items only appear in "do NOT" steps; infant flow has no
belly thrusts and adult/child flows have no infant chest-thrust method; every
step has distinct Devanagari Hindi text; audio path naming; step navigation
boundaries; language fallback; invalid-content detection.

`dart analyze lib test` (whole project) was also run only to look for parse
errors. It reported 1345 issues, all of which are unresolved `package:flutter`
/ `package:voiceaid` imports and their knock-on errors (no SDK/package config).
No syntax (parse) errors were reported. This is **not** a type-check of the
Flutter code.

## 3. Automated tests written (not yet executed)

| File | Covers |
|------|--------|
| `test/unit/content_test.dart` | Category data, five categories, choking flows, forbidden advice, Hindi present, audio path convention, invalid/empty content handling |
| `test/unit/step_navigator_test.dart` | Step navigation and boundaries |
| `test/unit/preferences_test.dart` | Default/persisted language, audio preference, custom contact validation and persistence, invalid stored values |
| `test/unit/audio_controller_test.dart` | Recording playback, TTS fallback, missing recording, missing language voice, TTS failure, recording error, pause/resume, stop (uses fakes - no platform audio) |
| `test/widget/home_screen_test.dart` | Home rendering, five cards, language toggle to Hindi, persisted language, help speaker, category selection, choking age picker, small screen + 1.6x font |
| `test/widget/guidance_screen_test.dart` | Warning visibility, step counter/text, all audio and navigation controls visible, manual navigation, no auto-advance, "DO NOT" text label, Done button, TTS vs recording, auto-play off, Hindi speech, missing voice message, emergency/exit buttons |
| `test/widget/emergency_settings_test.dart` | 112 shown with regional caution, call confirmation (cancel/confirm), dialer failure message, custom contact validation, settings controls, disclaimer, voice check |

`test/fakes.dart` provides fake audio player, fake TTS engine and a test harness
so no platform plugin is touched.

### Commands to run on a machine with Flutter

```bash
cd voiceaid
bash tool/setup_android.sh        # generates android/, patches manifest (untested)
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

### Actual results table (fill in after running)

| Command | Date | Result (paste real output) |
|---------|------|----------------------------|
| flutter pub get | | |
| flutter analyze | | |
| flutter test | | |
| flutter build apk --debug | | |

## 4. Manual testing checklist (to be done on a device)

- [ ] App starts and shows header, welcome text, five category cards, 112 button.
- [ ] Each category opens a guidance screen (Choking asks adult/child/infant first).
- [ ] Warning banner visible on every guidance screen.
- [ ] Step text, step counter and icon change only when Next/Previous is pressed.
- [ ] Play, Pause/Resume, Replay, Stop behave as described (Pause disabled for phone voice).
- [ ] Audio matches the text of the visible step (EN and HI).
- [ ] Language toggle on home and in Settings switches all text; choice survives app restart.
- [ ] Settings "Check phone voice support" reports sensible result for EN and HI.
- [ ] Hindi voice not installed: message shown, text still readable, no crash.
- [ ] Emergency screen: Call 112 shows confirmation; Cancel does nothing; Confirm opens dialer, does not auto-call.
- [ ] Custom contact: invalid number rejected; valid number saved, survives restart, can be removed.
- [ ] Font size set to largest in phone settings: no overflow, buttons still tappable.
- [ ] Small phone (about 320 dp wide) and a tablet: layout usable.
- [ ] TalkBack reads category cards, step text, warnings and buttons sensibly.
- [ ] Rotating the screen mid-guidance does not lose the step (**not verified: step index is held in widget state; confirm behaviour**).

## 5. Offline-mode checklist

1. Install the app while online. Open it once.
2. Turn on **airplane mode** (disable Wi-Fi and mobile data).
3. Force-stop and reopen the app.
- [ ] Home screen loads.
- [ ] All five categories open; all steps readable in EN and HI.
- [ ] Phone-voice (TTS) speaks if an offline voice is installed.
- [ ] Bundled recordings (when added) play.
- [ ] Emergency screen loads and shows 112 (the dialer can still be opened on a phone with a SIM; call connectivity is separate from data).
- [ ] Settings change and persist.
- [ ] Check that the app declares no INTERNET permission in the built manifest.

## 6. Known issues

- Flutter code uncompiled; first compile may surface errors (see KNOWN_LIMITATIONS.md).
- `pubspec.yaml` versions unresolved.
- `android/` folder not generated.
- No audio recordings bundled.
- The guidance step index is not restored after process death.
