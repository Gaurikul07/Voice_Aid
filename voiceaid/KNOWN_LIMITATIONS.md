# Known Limitations

Please read this before presenting or distributing the app.

1. **Prototype status.** VoiceAid is a student Design Thinking prototype. It is
   not a medical device and must not be relied on in a real emergency.
2. **Medical content is unreviewed.** The steps were adapted from public
   sources by an AI assistant and have not been validated by a qualified
   clinician. See MEDICAL_CONTENT_SOURCES.md for what is and is not
   supported. Hindi wording is not reviewed by a medical translator.
3. **Not built or run in the authoring environment.** The Flutter SDK, pub.dev
   and the Android SDK were not reachable where the code was written, so
   `flutter pub get`, `flutter analyze`, `flutter test` and `flutter build apk`
   were **not executed**. The Flutter code and tests have never been compiled.
   Expect to fix small compile errors or dependency-version issues on first run.
   See TESTING_REPORT.md.
4. **The `android/` folder is not included.** Generate it with
   `tool/setup_android.sh` (untested) or `flutter create`.
5. **No audio recordings.** The audio folders contain only `.gitkeep` files.
   Playback code for recordings exists but has only been exercised through
   fake players in tests that have not been run. Until recordings are added the
   app relies on text-to-speech.
6. **TTS is device-specific.** Offline speech needs a voice installed on the
   phone. Hindi voices are often not pre-installed or may need a download
   (which needs internet once). The app detects a missing voice where the
   engine reports it and shows the text instead, but detection varies by
   device and Android version.
7. **Pause is not available for TTS** on Android (a `flutter_tts` limitation).
   Pause/Resume works only for recordings; TTS offers Stop and Replay.
8. **Generic icons.** Illustrations are Material icons (there is no snake or
   bone icon), not custom pictures. Low-literacy users may need custom
   illustrations, tested with real users.
9. **No real user testing.** No interviews or usability tests were done. All
   user needs in DESIGN_THINKING.md are assumptions until field research is
   completed.
10. **India emergency numbers.** Only 112 is verified from an official source.
    The app does not know the user's state. Older numbers (108/100/101) are
    labelled unverified. Dialling opens the phone dialer; the user must press
    call. The dialer does not work on devices without telephony (tablets/emulators).
11. **Two languages only** (Hindi, English); no regional languages.
12. **Accessibility is not audited.** Semantics labels and large touch targets
    were added, but TalkBack and large-font behaviour were not tested on
    devices.
13. **Dart-defined content.** Content is compiled into the app (not JSON), so
    editing it requires a rebuild.
14. **Package versions unverified.** Versions in `pubspec.yaml` were written
    from knowledge, not resolved by `pub get`. Code assumes a recent Flutter
    (it uses `Color.withValues`, which needs Flutter 3.27 or newer).
