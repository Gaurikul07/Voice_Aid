#!/usr/bin/env bash
# One-time setup on a machine that HAS the Flutter SDK + Android SDK.
# Generates the android/ folder (not included in this source drop because the
# Flutter SDK was not available where this project was authored) and patches
# the manifest. NOT executed during authoring - see TESTING_REPORT.md.
set -euo pipefail
cd "$(dirname "$0")/.."

flutter create --platforms=android --project-name voiceaid --org in.voiceaid .
rm -f test/widget_test.dart   # default template test; we have our own tests

MANIFEST=android/app/src/main/AndroidManifest.xml
python3 - "$MANIFEST" <<'PY'
import sys,re
p=sys.argv[1]
s=open(p).read()
queries='''
    <!-- Needed on Android 11+ so flutter_tts can find the TTS engine and
         url_launcher can open the dialer. No INTERNET permission is needed. -->
    <queries>
        <intent><action android:name="android.intent.action.TTS_SERVICE"/></intent>
        <intent><action android:name="android.intent.action.DIAL"/><data android:scheme="tel"/></intent>
    </queries>
'''
if '<queries>' not in s:
    s=s.replace('<application',queries+'    <application',1)
s=s.replace('android:label="voiceaid"','android:label="VoiceAid"')
open(p,'w').write(s)
print("Patched",p)
PY
echo "Next: flutter pub get && flutter analyze && flutter test && flutter build apk --debug"
