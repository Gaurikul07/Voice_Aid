# VoiceAid - Design Thinking Documentation

**Honesty note:** No interviews, surveys or field visits were carried out. All
statements about users below are **assumptions** to be checked by field
research, and are labelled as such. No participant numbers or success rates are
invented anywhere in this project.

## 1. EMPATHIZE

### The problem (context)
In an emergency, the first minutes matter. In rural areas people may be far from
a clinic, have unreliable mobile data, speak a local language, and may not read
long text easily. Common home remedies for burns and snakebite can be harmful.

### Potential users
| User | Why they might need VoiceAid | Status |
|------|------------------------------|--------|
| Rural residents | First on scene for farm, kitchen, road injuries | Assumption |
| Family caregivers (children, elderly) | Need quick guidance for people at home | Assumption |
| Community volunteers / village health helpers | May want a quick refresher | Assumption |
| People with limited literacy | Need pictures and voice, not paragraphs | Assumption |
| People with limited internet | Need everything to work offline | Assumption |

### Assumptions vs. what needs field research
| Assumption | How to verify |
|------------|---------------|
| Many target users own an Android phone | Household survey in the target village |
| Hindi is the preferred language | Ask; also consider regional languages |
| Users can tap picture buttons without training | Usability test (Section 5) |
| Voice guidance is preferred over text | Observe and ask |
| Phones have an offline Hindi TTS voice | Check devices; test the voice check button |
| People currently use harmful remedies (e.g. ghee on burns) | Interviews with health workers |
| Panic reduces ability to read | Literature/health-worker input |

**Findings from real research: none yet.**

## 2. DEFINE

**Problem statement:** Rural residents with limited connectivity and literacy
lack immediate, understandable, trustworthy first-aid guidance in their own
language during the first minutes of an injury emergency.

**How Might We:** How might we give a frightened, low-literacy person with no
internet clear spoken first-aid steps in their own language, while pushing them
to call for professional help?

**Needs:** work offline; voice and pictures first; Hindi and English; very few
taps; large buttons; clear "call 112" prompt; no harmful advice; no personal
data collection.

**Constraints:** low-cost phones, varying TTS support, no clinical validation
yet, no recordings yet, student prototype, cannot replace medical care.

## 3. IDEATE

| Criterion | 1. Offline Android app | 2. Keypad offline audio device | 3. IVR telephone helpline |
|-----------|-----------------------|--------------------------------|---------------------------|
| Cost to user | Low if they own a smartphone; free app | Needs a new device purchase and distribution | Free to low (phone call cost) |
| Accessibility | Pictures + voice + text, two languages; needs a smartphone | Very simple (buttons + audio); no screen literacy; but fixed content and a single device per household | Works on basic phones; voice only; menu navigation by keypad |
| Connectivity | None for content | None | Needs mobile network coverage (often weak in rural areas) |
| Dev. complexity | Medium (app, TTS, audio) | High (hardware, manufacturing, power) | High (telephony, hosting, operating costs) |
| Scalability | High (distribute APK/Play Store; update content) | Low-medium (hardware logistics) | Medium (per-minute costs, capacity) |
| Update content | App update needed | Hard | Easy (server side) |

*(Ratings are qualitative judgements by the project team, not measured data.)*

**Why the Android app for the prototype:** it can be built and demonstrated
quickly by students, works with no connectivity, is cheap to distribute, and
supports pictures, voice and two languages. The IVR helpline and a hardware
device are good future complements for feature-phone users.

## 4. PROTOTYPE

What is implemented (see README.md): home screen with five large category cards,
language toggle, spoken help, step-by-step guidance with audio controls and
warnings, emergency numbers screen with confirmation before dialling, settings
with disclaimer, local preferences, bundled content in Hindi and English, TTS
fallback and recording support. Architecture: see README.md.

What is **not** done: build/run verification, recordings, clinical review,
custom illustrations (see KNOWN_LIMITATIONS.md).

## 5. TEST

### Usability-testing protocol (simulated scenarios only - no real injuries)

**Participants:** recruit from the intended groups (rural residents, caregivers,
village health volunteers, low-literacy adults). Record age range, language,
smartphone familiarity and literacy level, with consent; do not record names
or health data. Sample size: decide with your supervisor; **not predetermined here**.

**Setup:** Android phone with the app installed; airplane mode ON for the
offline task; quiet room; facilitator script; observer with timer; permission to
record observations (audio/video only with consent).

**Scenarios (read aloud, no demonstration):**
1. "A child has touched a hot pan and the hand is burned."
2. "A man cut his arm with a sickle and it is bleeding."
3. "A baby is choking on a piece of food." (checks age-group choice)
4. "A farmer was bitten by a snake in the field."
5. "A woman fell from a ladder and her arm looks bent."

**Tasks per scenario:** find the right category; start voice guidance; move
through the steps; say what they would do (and what NOT to do); find the
emergency number screen. Repeat one scenario in the other language.

**Measures**
| Criterion | How measured |
|-----------|--------------|
| Finds correct category | Yes/No, number of wrong taps, time |
| Starts audio guidance | Yes/No, time, help needed |
| Navigates the steps | Reaches the last step; Next/Previous used correctly |
| Understands spoken instructions | Participant restates key actions and "do not" items; scored against an answer key by a reviewer |
| Uses the app offline | Completes tasks in airplane mode without error |
| Finds emergency number | Yes/No, time |
| Confidence/clarity | Simple 1-5 rating (self-reported) |

**Safety rules:** facilitator stresses this is a simulation; no real injuries;
participants are told the app is a prototype and not a substitute for care.

### Results template (fill in AFTER real testing)

| Participant ID | Group | Language | Literacy | Scenario | Right category? | Started audio? | Reached last step? | Restated key actions correctly (x of y) | Offline OK? | Found 112? | Time | Observations |
|----------------|-------|----------|----------|----------|-----------------|----------------|--------------------|-----------------------------------------|-------------|------------|------|--------------|
| | | | | | | | | | | | | |

Summary (to be completed): number of participants ___; per-criterion counts ___;
top usability problems ___; changes to make ___.

**Current results: none. No testing has been done.**
