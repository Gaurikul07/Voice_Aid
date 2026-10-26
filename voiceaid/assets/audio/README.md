# Bundled audio recordings

**No recordings are included in this project.** Every directory below
`assets/audio/<lang>/<category>/` currently contains only a `.gitkeep` file.
Until real recordings are added, VoiceAid uses the phone's offline
text-to-speech (if a voice for the language is installed) and always shows the
instruction text on screen.

## Naming convention

```
assets/audio/<lang>/<categoryId>/<flowId>_step<NN>.mp3
```

| Example                                         | Meaning                              |
|-------------------------------------------------|--------------------------------------|
| `assets/audio/en/burns/burns_step03.mp3`        | English, Burns, step 3               |
| `assets/audio/hi/bleeding/bleeding_step02.mp3`  | Hindi, Cuts and Bleeding, step 2     |
| `assets/audio/hi/choking/infant_step05.mp3`     | Hindi, Choking, infant flow, step 5  |

`<lang>` is `en` or `hi`. Category ids: `burns`, `bleeding`, `choking`,
`snakebite`, `fracture`. Flow ids: `burns`, `bleeding`, `adult`, `child`,
`infant`, `snakebite`, `fracture`. Step numbers are two digits and follow the
order in `lib/data/first_aid_content.dart`.

## Rules for recordings

1. Record the exact text of the step shown on screen for that language, so
   audio and text always match. If you change the wording in the content file,
   re-record the audio.
2. Recordings must be made by a real speaker. Do not label text-to-speech
   output as a "real recording".
3. Recordings should be reviewed together with the text by a qualified person.

No code change is needed to add a file: the app checks for each file at
playback time and falls back to TTS if it is missing.
