# VoiceAid - Presentation Outline (10 slides)

Only features that exist in the source are described. Screenshots are **not**
included because the app has not been run; replace "Screen description" items
with real screenshots after a successful build.

**Slide 1 - Title and team**
- VoiceAid: An Offline Voice-Based First-Aid Guidance Assistant for Rural Areas
- Domain: Health-Tech / Conversational AI / Social Impact
- Team names, roll numbers, guide/mentor, institution (fill in)

**Slide 2 - Problem statement**
- Rural emergencies: far from care, weak internet, low literacy, language barriers
- Harmful home remedies are common (assumption - to verify)
- Need: simple, spoken, offline guidance

**Slide 3 - Empathize**
- Users: rural residents, caregivers, volunteers, low-literacy and low-connectivity users
- Challenges (assumptions): panic, reading difficulty, no data
- Next step: real field interviews

**Slide 4 - Define**
- Problem statement and the How Might We question (DESIGN_THINKING.md section 2)
- Needs: offline, voice + pictures, Hindi/English, large buttons, safe

**Slide 5 - Ideate**
- Compare: offline app vs keypad audio device vs IVR helpline (cost, accessibility, connectivity, complexity, scalability)
- Chosen: offline Android app for the first prototype

**Slide 6 - Proposed solution**
- 5 categories; choking split by adult/child/infant
- Voice + text + icon steps, manual navigation, emergency warning, "Call 112" with confirmation

**Slide 7 - Architecture and tech stack**
- Flutter/Dart; shared_preferences; audioplayers; flutter_tts; url_launcher
- Bundled Dart content -> repository -> screens; audio controller (recording -> TTS -> text)

**Slide 8 - Screens (descriptions; add real screenshots later)**
- Home: header, language toggle, speaker, 5 cards, red 112 button
- Guidance: warning banner, step card, audio buttons, Previous/Next
- Emergency: 112, unverified older numbers, custom contact
- Settings: language, voice auto-play, voice check, disclaimer

**Slide 9 - Testing and evaluation metrics**
- Automated: 60 tests written (not yet run on Flutter); 155 pure-Dart content checks passed
- Planned usability metrics: correct category, audio started, steps navigated, instructions understood, works offline
- No user-test results yet

**Slide 10 - Conclusion and future scope**
- Prototype shows an offline, voice-first approach
- Next: medical review, real recordings, illustrations, more languages, field testing, build and device testing
- Honest limits: educational prototype, not a replacement for 112 or a doctor
