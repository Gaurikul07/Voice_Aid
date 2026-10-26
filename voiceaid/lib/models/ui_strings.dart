import 'localized_text.dart';

/// Every piece of interface text, in English and Hindi.
/// (First-aid content lives in data/first_aid_content.dart.)
class UiStrings {
  UiStrings._();

  static const appName = LocalizedText(en: 'VoiceAid', hi: 'वॉइसएड');
  static const welcome = LocalizedText(
    en: 'Welcome. I will guide you with simple first-aid steps.',
    hi: 'स्वागत है। मैं आपको प्राथमिक उपचार के आसान कदम बताऊँगा।',
  );
  static const chooseEmergency = LocalizedText(
    en: 'Choose the type of emergency.',
    hi: 'आपातकाल का प्रकार चुनें।',
  );
  static const helpSpoken = LocalizedText(
    en: 'Welcome to VoiceAid. Tap a big picture button to choose the type of '
        'emergency. For serious emergencies, call 112.',
    hi: 'वॉइसएड में आपका स्वागत है। आपातकाल का प्रकार चुनने के लिए बड़ा बटन दबाएँ। '
        'गंभीर आपातकाल में 112 पर कॉल करें।',
  );
  static const speakerHelp = LocalizedText(
    en: 'Listen to help',
    hi: 'मदद सुनें',
  );
  static const emergencyServices = LocalizedText(
    en: 'Emergency help: 112',
    hi: 'आपातकालीन मदद: 112',
  );
  static const emergencyServicesHint = LocalizedText(
    en: 'Open emergency numbers',
    hi: 'आपातकालीन नंबर खोलें',
  );
  static const settings = LocalizedText(en: 'Settings', hi: 'सेटिंग्स');
  static const language = LocalizedText(en: 'Language', hi: 'भाषा');
  static const audioAuto = LocalizedText(
    en: 'Play voice automatically for each step',
    hi: 'हर कदम की आवाज़ अपने-आप चलाएँ',
  );
  static const audioAutoHint = LocalizedText(
    en: 'You can always press Play to hear a step.',
    hi: 'किसी भी कदम को सुनने के लिए आप हमेशा "सुनें" दबा सकते हैं।',
  );
  static const appInfo = LocalizedText(
    en: 'About this app',
    hi: 'इस ऐप के बारे में',
  );
  static const appInfoBody = LocalizedText(
    en: 'VoiceAid is an educational prototype. It works without internet. '
        'It does not collect personal health information.',
    hi: 'वॉइसएड एक शैक्षिक प्रोटोटाइप है। यह बिना इंटरनेट के चलता है। यह कोई '
        'निजी स्वास्थ्य जानकारी इकट्ठा नहीं करता।',
  );
  static const disclaimerTitle = LocalizedText(
    en: 'Safety notice',
    hi: 'सुरक्षा सूचना',
  );
  static const disclaimer = LocalizedText(
    en: 'This app gives general first-aid information only. It cannot '
        'diagnose injuries and does not replace emergency services or a '
        'doctor. In a serious emergency, call 112 or go to a hospital. The '
        'content is a prototype and still needs review by qualified medical '
        'professionals.',
    hi: 'यह ऐप केवल सामान्य प्राथमिक उपचार की जानकारी देता है। यह चोट की जाँच '
        '(निदान) नहीं कर सकता और आपातकालीन सेवाओं या डॉक्टर की जगह नहीं ले '
        'सकता। गंभीर आपातकाल में 112 पर कॉल करें या अस्पताल जाएँ। यह सामग्री '
        'प्रोटोटाइप है और इसकी योग्य चिकित्सा विशेषज्ञों से समीक्षा बाकी है।',
  );
  static const disclaimerShort = LocalizedText(
    en: 'Educational first-aid guide. Not a substitute for a doctor or 112.',
    hi: 'शैक्षिक प्राथमिक उपचार गाइड। डॉक्टर या 112 का विकल्प नहीं।',
  );
  static const voiceCheck = LocalizedText(
    en: 'Check phone voice support',
    hi: 'फ़ोन की आवाज़ का समर्थन जाँचें',
  );
  static const voiceReady = LocalizedText(
    en: 'Voice is ready on this phone.',
    hi: 'इस फ़ोन पर आवाज़ तैयार है।',
  );
  static const voiceMissingLanguage = LocalizedText(
    en: 'This language voice is not installed on this phone. Read the text '
        'on screen. You can install it in phone Settings, under '
        'Text-to-speech.',
    hi: 'इस भाषा की आवाज़ इस फ़ोन में इंस्टॉल नहीं है। स्क्रीन पर लिखा पढ़ें। '
        'आप फ़ोन की सेटिंग्स में Text-to-speech से इसे इंस्टॉल कर सकते हैं।',
  );
  static const voiceUnavailable = LocalizedText(
    en: 'Voice is not available on this phone. Please read the text on screen.',
    hi: 'इस फ़ोन पर आवाज़ उपलब्ध नहीं है। कृपया स्क्रीन पर लिखा पढ़ें।',
  );
  static const voicePlaybackError = LocalizedText(
    en: 'The recording could not be played. Please read the text on screen.',
    hi: 'रिकॉर्डिंग नहीं चल सकी। कृपया स्क्रीन पर लिखा पढ़ें।',
  );
  static const usingPhoneVoice = LocalizedText(
    en: 'Using the phone voice (no recording for this step).',
    hi: 'फ़ोन की आवाज़ इस्तेमाल हो रही है (इस कदम की रिकॉर्डिंग नहीं है)।',
  );
  static const step = LocalizedText(en: 'Step', hi: 'कदम');
  static const of_ = LocalizedText(en: 'of', hi: 'में से');
  static const previous = LocalizedText(en: 'Previous', hi: 'पिछला');
  static const next = LocalizedText(en: 'Next', hi: 'अगला');
  static const done = LocalizedText(en: 'Done', hi: 'पूरा हुआ');
  static const play = LocalizedText(en: 'Play', hi: 'सुनें');
  static const pause = LocalizedText(en: 'Pause', hi: 'रोकें');
  static const resume = LocalizedText(en: 'Resume', hi: 'फिर चलाएँ');
  static const replay = LocalizedText(en: 'Replay', hi: 'दोबारा सुनें');
  static const stop = LocalizedText(en: 'Stop', hi: 'बंद करें');
  static const pauseUnsupported = LocalizedText(
    en: 'Pause is not available for phone voice. Use Stop and Replay.',
    hi: 'फ़ोन की आवाज़ में "रोकें" उपलब्ध नहीं है। "बंद करें" और "दोबारा सुनें" '
        'का उपयोग करें।',
  );
  static const exitGuidance = LocalizedText(
    en: 'Exit guidance',
    hi: 'गाइड से बाहर निकलें',
  );
  static const emergencyHelp = LocalizedText(
    en: 'Emergency help',
    hi: 'आपातकालीन मदद',
  );
  static const warningTitle = LocalizedText(
    en: 'EMERGENCY WARNING',
    hi: 'आपातकालीन चेतावनी',
  );
  static const doNot = LocalizedText(en: 'DO NOT DO THIS', hi: 'यह न करें');
  static const urgentHelp = LocalizedText(
    en: 'GET URGENT HELP',
    hi: 'तुरंत मदद लें',
  );
  static const doThis = LocalizedText(en: 'DO THIS', hi: 'यह करें');
  static const chooseAge = LocalizedText(
    en: 'Who is choking?',
    hi: 'किसका दम घुट रहा है?',
  );
  static const chooseAgeHint = LocalizedText(
    en: 'The steps are different for each age. Choose carefully.',
    hi: 'हर उम्र के लिए कदम अलग हैं। ध्यान से चुनें।',
  );
  static const contentUnavailable = LocalizedText(
    en: 'These instructions could not be loaded. Call 112 now.',
    hi: 'ये निर्देश लोड नहीं हो सके। अभी 112 पर कॉल करें।',
  );
  static const notFound = LocalizedText(
    en: 'This page was not found. Go back and try again.',
    hi: 'यह पन्ना नहीं मिला। वापस जाकर फिर कोशिश करें।',
  );
  static const back = LocalizedText(en: 'Back', hi: 'वापस');
  static const reviewNotice = LocalizedText(
    en: 'Prototype content: pending review by qualified medical professionals.',
    hi: 'प्रोटोटाइप सामग्री: योग्य चिकित्सा विशेषज्ञों की समीक्षा बाकी है।',
  );

  // Emergency screen
  static const nationalNumber = LocalizedText(
    en: 'National emergency number (India)',
    hi: 'राष्ट्रीय आपातकालीन नंबर (भारत)',
  );
  static const nationalNumberNote = LocalizedText(
    en: 'Police, fire, ambulance and other help. Service can depend on your '
        'state or area. Works from most phones, even without credit.',
    hi: 'पुलिस, दमकल, एम्बुलेंस और अन्य मदद। सेवा आपके राज्य या क्षेत्र पर निर्भर हो '
        'सकती है।',
  );
  static const otherNumbers = LocalizedText(
    en: 'Older numbers (not verified here)',
    hi: 'पुराने नंबर (यहाँ सत्यापित नहीं)',
  );
  static const otherNumbersNote = LocalizedText(
    en: 'These may still work in some areas. Availability differs by state. '
        'Please check locally.',
    hi: 'ये कुछ क्षेत्रों में अब भी काम कर सकते हैं। उपलब्धता राज्य के अनुसार '
        'अलग है। कृपया स्थानीय रूप से जाँच लें।',
  );
  static const ambulance = LocalizedText(en: 'Ambulance', hi: 'एम्बुलेंस');
  static const police = LocalizedText(en: 'Police', hi: 'पुलिस');
  static const fire = LocalizedText(en: 'Fire', hi: 'दमकल');
  static const myContact = LocalizedText(
    en: 'My own emergency contact',
    hi: 'मेरा अपना आपातकालीन संपर्क',
  );
  static const myContactNote = LocalizedText(
    en: 'Save a local doctor, health worker or family number. It stays only '
        'on this phone.',
    hi: 'स्थानीय डॉक्टर, स्वास्थ्यकर्मी या परिवार का नंबर सहेजें। यह केवल इसी फ़ोन में '
        'रहता है।',
  );
  static const noContact = LocalizedText(
    en: 'No contact saved yet.',
    hi: 'अभी कोई संपर्क सहेजा नहीं है।',
  );
  static const editContact = LocalizedText(en: 'Edit', hi: 'बदलें');
  static const save = LocalizedText(en: 'Save', hi: 'सहेजें');
  static const clear = LocalizedText(en: 'Remove', hi: 'हटाएँ');
  static const contactName = LocalizedText(en: 'Name', hi: 'नाम');
  static const contactNumber = LocalizedText(en: 'Phone number', hi: 'फ़ोन नंबर');
  static const invalidNumber = LocalizedText(
    en: 'Enter a valid phone number (digits only, 3 to 15 digits).',
    hi: 'सही फ़ोन नंबर लिखें (केवल अंक, 3 से 15 अंक)।',
  );
  static const call = LocalizedText(en: 'Call', hi: 'कॉल करें');
  static const cancel = LocalizedText(en: 'Cancel', hi: 'रद्द करें');
  static const confirmCallTitle = LocalizedText(
    en: 'Open the phone dialer?',
    hi: 'फ़ोन डायलर खोलें?',
  );
  static const confirmCallBody = LocalizedText(
    en: 'The dialer will open with this number. You must press the call button '
        'there.',
    hi: 'यह नंबर डायलर में खुलेगा। कॉल करने के लिए आपको वहाँ कॉल बटन दबाना होगा।',
  );
  static const callFailed = LocalizedText(
    en: 'Could not open the dialer. Please dial the number yourself:',
    hi: 'डायलर नहीं खुल सका। कृपया यह नंबर खुद डायल करें:',
  );
  static const worksOffline = LocalizedText(
    en: 'Works offline',
    hi: 'बिना इंटरनेट चलता है',
  );
}
