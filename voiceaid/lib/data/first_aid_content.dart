import '../models/first_aid_models.dart';
import '../models/localized_text.dart';

// =============================================================================
// FIRST-AID CONTENT (bundled, offline)
//
// MEDICAL SAFETY: Every flow below is marked needsClinicalReview = true.
// The wording was adapted from the sources listed in
// MEDICAL_CONTENT_SOURCES.md, and the Hindi was written by the developer, NOT
// by a certified medical translator. A qualified clinician / first-aid trainer
// and a native Hindi reviewer MUST review this file before any real-world use.
// Do not add or change procedures here without a source and review.
// =============================================================================

const _burns = GuidanceFlow(
  id: 'burns',
  iconKey: 'burn',
  title: LocalizedText(en: 'Burns', hi: 'जलना'),
  subtitle: LocalizedText(
    en: 'Fire, hot water, hot oil',
    hi: 'आग, गर्म पानी, गर्म तेल',
  ),
  warning: LocalizedText(
    en: 'Call 112 for a large or deep burn, a burn on the face, hands or private '
        'parts, a chemical or electric burn, or if the person is a baby or an '
        'older person.',
    hi: 'बड़ी या गहरी जलन, चेहरे, हाथ या गुप्तांग पर जलन, रसायन या बिजली से जलन, '
        'या शिशु या बुज़ुर्ग के जलने पर 112 पर कॉल करें।',
  ),
  sourceIds: ['S3'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'safe',
      text: LocalizedText(
        en: 'Move the person away from the fire, heat or hot object. If '
            'electricity caused the burn, switch it off first. Do not touch '
            'the person until the power is off.',
        hi: 'व्यक्ति को आग, गर्मी या गर्म चीज़ से दूर करें। अगर बिजली से जला है, '
            'तो पहले बिजली बंद करें। बिजली बंद होने तक व्यक्ति को न छुएँ।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'burn',
      text: LocalizedText(
        en: 'If clothes are on fire, make the person lie down and roll on the '
            'ground, or cover the flames with a thick blanket.',
        hi: 'अगर कपड़ों में आग लगी है, तो व्यक्ति को ज़मीन पर लिटाकर लुढ़कवाएँ, '
            'या मोटे कंबल से आग को ढक दें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'water',
      text: LocalizedText(
        en: 'Hold the burn under cool, clean running water for 20 minutes. '
            'Start as early as you can. If there is no running water, pour '
            'clean cool water over it.',
        hi: 'जले हुए हिस्से पर 20 मिनट तक ठंडा, साफ़ बहता पानी डालें। जितनी जल्दी हो '
            'सके शुरू करें। बहता पानी न हो तो साफ़ ठंडा पानी डालते रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'ring',
      text: LocalizedText(
        en: 'Gently take off rings, watches or tight things near the burn '
            'before it swells. Do not pull off clothes that are stuck to the skin.',
        hi: 'सूजन आने से पहले जले हिस्से के पास की अंगूठी, घड़ी या कसी चीज़ें धीरे से '
            'उतारें। त्वचा से चिपके कपड़े को न खींचें।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'bandage',
      text: LocalizedText(
        en: 'After cooling, cover the burn loosely with a clean, dry, '
            'non-fluffy cloth. Do not burst any blisters.',
        hi: 'ठंडा करने के बाद जले हिस्से को साफ़, सूखे, रोएँ-रहित कपड़े से ढीला ढक दें। '
            'फफोलों को न फोड़ें।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT put ice, toothpaste, butter, ghee, oil, or any paste or '
            'powder on a burn. They can make it worse.',
        hi: 'जले हुए हिस्से पर बर्फ़, टूथपेस्ट, मक्खन, घी, तेल या कोई लेप या पाउडर '
            'न लगाएँ। इससे हालत बिगड़ सकती है।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Get urgent medical help if the burn is large or deep, looks white '
            'or black, is on the face, hands, feet, private parts or over a '
            'joint, is from chemicals or electricity, or if the person has '
            'trouble breathing. Also for a baby, child or older person.',
        hi: 'जलन बड़ी या गहरी हो, सफ़ेद या काली दिखे, चेहरे, हाथ, पैर, गुप्तांग या जोड़ पर '
            'हो, रसायन या बिजली से हुई हो, या साँस लेने में तकलीफ़ हो, तो तुरंत '
            'चिकित्सा सहायता लें। शिशु, बच्चे या बुज़ुर्ग के लिए भी।',
      ),
    ),
  ],
);

const _bleeding = GuidanceFlow(
  id: 'bleeding',
  iconKey: 'bleeding',
  title: LocalizedText(en: 'Cuts and Bleeding', hi: 'कटना और खून बहना'),
  subtitle: LocalizedText(
    en: 'Cuts, wounds, heavy bleeding',
    hi: 'कट, घाव, ज़्यादा खून बहना',
  ),
  warning: LocalizedText(
    en: 'Call 112 now if blood is spurting, soaks through the cloth, or does '
        'not slow down with firm pressure.',
    hi: 'अगर खून फव्वारे की तरह निकल रहा है, कपड़ा भीग रहा है, या दबाने पर भी '
        'खून कम नहीं हो रहा, तो अभी 112 पर कॉल करें।',
  ),
  sourceIds: ['S5', 'S6'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'safe',
      text: LocalizedText(
        en: 'Make sure the place is safe. Have the person sit or lie down. '
            'Use gloves if you have them.',
        hi: 'देखें कि जगह सुरक्षित है। व्यक्ति को बैठाएँ या लिटाएँ। दस्ताने हों तो '
            'पहन लें।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'press',
      text: LocalizedText(
        en: 'Press firmly on the wound with a clean cloth or pad. Keep '
            'pressing without stopping.',
        hi: 'घाव पर साफ़ कपड़े या गद्दी से मज़बूती से दबाएँ। बिना रुके दबाए रखें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'press',
      text: LocalizedText(
        en: 'If blood soaks through, do not take the cloth off. Put more cloth '
            'on top and keep pressing.',
        hi: 'अगर खून कपड़े में से रिस आए, तो कपड़ा न हटाएँ। उसके ऊपर और कपड़ा रखकर '
            'दबाते रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'bandage',
      text: LocalizedText(
        en: 'When bleeding slows, tie the pad firmly with a bandage or cloth. '
            'Not too tight: fingers or toes should not turn pale, blue or numb.',
        hi: 'खून कम होने पर गद्दी को पट्टी या कपड़े से कसकर बाँधें। बहुत कसा नहीं: '
            'उँगलियाँ पीली, नीली या सुन्न नहीं होनी चाहिए।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'rest',
      text: LocalizedText(
        en: 'Keep the person lying down and warm. If you do not think a bone '
            'is broken, raise the injured arm or leg higher than the heart.',
        hi: 'व्यक्ति को लिटाकर गर्म रखें। अगर हड्डी टूटने का शक नहीं है, तो चोटिल हाथ '
            'या पैर को दिल से ऊपर उठाकर रखें।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT pull out anything stuck in the wound; press around it. Do '
            'NOT put soil, ash, powder, leaves or any paste on the wound. Do '
            'NOT tie a tight rope or band above the wound.',
        hi: 'घाव में फँसी चीज़ को न निकालें; उसके आसपास दबाएँ। घाव पर मिट्टी, राख, '
            'पाउडर, पत्ते या कोई लेप न लगाएँ। घाव के ऊपर कसकर रस्सी या पट्टी न बाँधें।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Get urgent help if bleeding does not slow with pressure, the '
            'wound is deep or on the head, neck, chest or belly, or the person '
            'is pale, dizzy, cold, confused or faints.',
        hi: 'अगर दबाने पर भी खून कम न हो, घाव गहरा हो या सिर, गर्दन, छाती या पेट पर '
            'हो, या व्यक्ति पीला, चक्कर में, ठंडा, उलझा हुआ हो या बेहोश हो जाए, तो '
            'तुरंत मदद लें।',
      ),
    ),
  ],
);

const _snakebite = GuidanceFlow(
  id: 'snakebite',
  iconKey: 'snake',
  title: LocalizedText(en: 'Snakebite', hi: 'साँप का काटना'),
  subtitle: LocalizedText(
    en: 'Go to hospital fast',
    hi: 'जल्दी अस्पताल पहुँचें',
  ),
  warning: LocalizedText(
    en: 'Every snakebite is an emergency. Get the person to a hospital as fast '
        'as possible. Call 112 or arrange a vehicle now.',
    hi: 'साँप का हर काटना आपातकाल है। व्यक्ति को जल्दी से जल्दी अस्पताल पहुँचाएँ। '
        'अभी 112 पर कॉल करें या गाड़ी का इंतज़ाम करें।',
  ),
  sourceIds: ['S2', 'S8'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'safe',
      text: LocalizedText(
        en: 'Move the person away from the snake to a safe place. Do not '
            'chase, catch or kill the snake.',
        hi: 'व्यक्ति को साँप से दूर सुरक्षित जगह ले जाएँ। साँप का पीछा न करें, उसे '
            'पकड़ें या मारें नहीं।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'phone',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Call 112 or arrange a vehicle to the nearest hospital right now. '
            'Do not wait for symptoms to start.',
        hi: 'अभी 112 पर कॉल करें या नज़दीकी अस्पताल के लिए गाड़ी का इंतज़ाम करें। '
            'लक्षण दिखने का इंतज़ार न करें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'rest',
      text: LocalizedText(
        en: 'Keep the person calm, lying down and as still as possible. '
            'Moving around can make things worse.',
        hi: 'व्यक्ति को शांत रखें, लिटाएँ और जितना हो सके स्थिर रखें। इधर-उधर हिलने '
            'से हालत बिगड़ सकती है।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'ring',
      text: LocalizedText(
        en: 'Gently take off rings, watches and tight clothes near the bite '
            'before swelling starts.',
        hi: 'सूजन शुरू होने से पहले काटे हुए हिस्से के पास की अंगूठी, घड़ी और कसे कपड़े '
            'धीरे से उतार दें।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'splint',
      text: LocalizedText(
        en: 'Keep the bitten arm or leg still. You can support it with a '
            'splint or sling, like a broken bone. Do not tie it tight.',
        hi: 'काटे गए हाथ या पैर को स्थिर रखें। टूटी हड्डी की तरह पट्टी या स्लिंग से '
            'सहारा दे सकते हैं। कसकर न बाँधें।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'vehicle',
      text: LocalizedText(
        en: 'Take the person to hospital by vehicle. Carry them or help them '
            'be carried. Do not let them walk or run.',
        hi: 'व्यक्ति को गाड़ी से अस्पताल ले जाएँ। उन्हें उठाकर ले जाएँ। उन्हें चलने या '
            'दौड़ने न दें।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT cut the wound. Do NOT suck out venom. Do NOT put ice. Do '
            'NOT tie a tight rope or tourniquet. Do NOT waste time catching or '
            'finding the snake. Do NOT use herbs or traditional remedies '
            'instead of going to hospital.',
        hi: 'घाव को न काटें। ज़हर को मुँह से न चूसें। बर्फ़ न लगाएँ। कसकर रस्सी या '
            'टूर्निकेट न बाँधें। साँप को पकड़ने या ढूँढने में समय बर्बाद न करें। '
            'अस्पताल जाने की जगह जड़ी-बूटी या देसी इलाज न करें।',
      ),
    ),
    FirstAidStep(
      id: 'step08',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Tell the hospital if there is trouble breathing or speaking, '
            'drooping eyelids, fast swelling, bleeding, vomiting or fainting. '
            'The doctors will decide the treatment.',
        hi: 'साँस लेने या बोलने में तकलीफ़, पलकें झुकना, तेज़ सूजन, खून बहना, उल्टी '
            'या बेहोशी हो तो अस्पताल को बताएँ। इलाज का फ़ैसला डॉक्टर करेंगे।',
      ),
    ),
  ],
);

const _fracture = GuidanceFlow(
  id: 'fracture',
  iconKey: 'bone',
  title: LocalizedText(en: 'Suspected Fracture', hi: 'हड्डी टूटने का शक'),
  subtitle: LocalizedText(
    en: 'Possible broken bone',
    hi: 'हड्डी टूटने की आशंका',
  ),
  warning: LocalizedText(
    en: 'Call 112 if a bone is sticking out, there is heavy bleeding, the '
        'person does not respond, or you suspect a neck, back or head injury.',
    hi: 'अगर हड्डी बाहर निकली है, ज़्यादा खून बह रहा है, व्यक्ति जवाब नहीं दे रहा, '
        'या गर्दन, पीठ या सिर की चोट का शक है, तो 112 पर कॉल करें।',
  ),
  sourceIds: ['S7'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'rest',
      text: LocalizedText(
        en: 'Keep the person still. Do not move them unless they are in '
            'danger. Do not let them stand on the injured part.',
        hi: 'व्यक्ति को स्थिर रखें। जब तक ख़तरा न हो, उन्हें न हिलाएँ। चोटिल हिस्से पर '
            'खड़ा न होने दें।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'warning',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If you suspect an injury to the neck, back or head, do not move '
            'the person at all. Call 112.',
        hi: 'अगर गर्दन, पीठ या सिर की चोट का शक है, तो व्यक्ति को बिल्कुल न हिलाएँ। '
            '112 पर कॉल करें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'press',
      text: LocalizedText(
        en: 'If the wound is bleeding, press gently with a clean cloth. Do '
            'not press on a bone that is sticking out.',
        hi: 'अगर घाव से खून बह रहा है, तो साफ़ कपड़े से हल्का दबाएँ। बाहर निकली '
            'हड्डी पर न दबाएँ।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'splint',
      text: LocalizedText(
        en: 'Keep the injured part from moving. Support it in the position you '
            'found it. If you know how to splint and help is far away, '
            'splint above and below the injury.',
        hi: 'चोटिल हिस्से को हिलने न दें। उसे वैसी ही स्थिति में सहारा दें जैसा मिला। '
            'अगर आपको पट्टी बाँधना आता है और मदद दूर है, तो चोट के ऊपर और नीचे '
            'पट्टी बाँधें।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'rest',
      text: LocalizedText(
        en: 'If the person feels faint, lay them down and keep them warm and '
            'calm. Stay with them.',
        hi: 'अगर व्यक्ति को चक्कर आ रहा है, तो उन्हें लिटाएँ, गर्म और शांत रखें। '
            'उनके साथ रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT try to straighten a bent bone. Do NOT push a bone back in. '
            'Do NOT let anyone pull, twist or massage the limb. Do NOT put ice '
            'directly on the skin.',
        hi: 'मुड़ी हुई हड्डी को सीधा करने की कोशिश न करें। हड्डी को अंदर न दबाएँ। '
            'किसी को अंग खींचने, मोड़ने या मालिश करने न दें। बर्फ़ सीधे त्वचा पर '
            'न रखें।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Take the person to a doctor or hospital. Get help urgently if '
            'the limb looks bent, even gentle movement hurts a lot, or the '
            'fingers or toes are numb or pale.',
        hi: 'व्यक्ति को डॉक्टर या अस्पताल ले जाएँ। अंग मुड़ा दिखे, हल्के हिलने से भी '
            'बहुत दर्द हो, या उँगलियाँ सुन्न या पीली हों, तो तुरंत मदद लें।',
      ),
    ),
  ],
);

// -- Choking: three SEPARATE flows. They are never merged. ---------------------

const _chokingWarning = LocalizedText(
  en: 'Choking is an emergency. If the person cannot cough, speak or breathe, '
      'act now and ask someone to call 112.',
  hi: 'दम घुटना आपातकाल है। अगर व्यक्ति खाँस, बोल या साँस नहीं ले पा रहा, तो '
      'तुरंत कार्रवाई करें और किसी से 112 पर कॉल करवाएँ।',
);

const _chokingAdult = GuidanceFlow(
  id: 'adult',
  iconKey: 'adult',
  title: LocalizedText(en: 'Choking: Adult', hi: 'दम घुटना: वयस्क'),
  subtitle: LocalizedText(
    en: 'Teenager or adult',
    hi: 'किशोर या वयस्क',
  ),
  warning: _chokingWarning,
  sourceIds: ['S4'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'listen',
      text: LocalizedText(
        en: 'Ask: "Are you choking?" If the person can cough strongly, speak '
            'or breathe, do not hit their back. Tell them to keep coughing and '
            'stay beside them.',
        hi: 'पूछें: "क्या आपका दम घुट रहा है?" अगर व्यक्ति ज़ोर से खाँस, बोल या साँस ले '
            'पा रहा है, तो उसकी पीठ पर न मारें। उसे खाँसते रहने को कहें और पास '
            'रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'phone',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the person cannot cough, speak or breathe, shout for help and '
            'ask someone to call 112. If you are alone, start first aid first.',
        hi: 'अगर व्यक्ति खाँस, बोल या साँस नहीं ले पा रहा, तो मदद के लिए चिल्लाएँ और '
            'किसी से 112 पर कॉल करवाएँ। अगर आप अकेले हैं, तो पहले प्राथमिक '
            'उपचार शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'back',
      text: LocalizedText(
        en: 'Stand to the side and slightly behind. Lean the person forward. '
            'Give 5 firm blows between the shoulder blades with the heel of '
            'your hand.',
        hi: 'बगल में थोड़ा पीछे खड़े हों। व्यक्ति को आगे झुकाएँ। हथेली के निचले हिस्से से '
            'कंधों के बीच 5 ज़ोरदार थपकियाँ मारें।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'abdomen',
      text: LocalizedText(
        en: 'If still choking, stand behind. Make a fist just above the belly '
            'button, hold it with your other hand, and pull sharply inward and '
            'upward. Do this 5 times.',
        hi: 'अगर अब भी दम घुट रहा है, तो पीछे खड़े हों। नाभि के ठीक ऊपर मुट्ठी रखें, '
            'दूसरे हाथ से पकड़ें, और तेज़ी से अंदर और ऊपर की ओर खींचें। यह 5 बार '
            'करें।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'repeat',
      text: LocalizedText(
        en: 'Keep alternating 5 back blows and 5 belly thrusts until the '
            'object comes out or the person stops responding.',
        hi: '5 थपकियाँ और 5 पेट के झटके बारी-बारी से तब तक करें जब तक चीज़ बाहर न '
            'आ जाए या व्यक्ति प्रतिक्रिया देना बंद न कर दे।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'warning',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the person stops responding, lay them on the ground and make '
            'sure 112 has been called. Follow the 112 operator. If you are '
            'trained in CPR, start it.',
        hi: 'अगर व्यक्ति प्रतिक्रिया देना बंद कर दे, तो उसे ज़मीन पर लिटाएँ और '
            'सुनिश्चित करें कि 112 पर कॉल हो चुकी है। 112 ऑपरेटर की बात मानें। '
            'अगर आपको CPR आता है, तो शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT hit the back if the person is coughing well. Do NOT give '
            'water. Do NOT push your fingers blindly into the mouth.',
        hi: 'अगर व्यक्ति अच्छे से खाँस रहा है, तो पीठ पर न मारें। पानी न दें। '
            'अंधाधुंध मुँह में उँगली न डालें।',
      ),
    ),
    FirstAidStep(
      id: 'step08',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Even if the object comes out, see a doctor, especially after '
            'belly thrusts or if there is cough, pain or trouble breathing '
            'or swallowing.',
        hi: 'चीज़ निकल जाने पर भी डॉक्टर को दिखाएँ, ख़ासकर पेट के झटकों के बाद या खाँसी, '
            'दर्द, साँस लेने या निगलने में तकलीफ़ हो तो।',
      ),
    ),
  ],
);

const _chokingChild = GuidanceFlow(
  id: 'child',
  iconKey: 'child',
  title: LocalizedText(en: 'Choking: Child', hi: 'दम घुटना: बच्चा'),
  subtitle: LocalizedText(
    en: 'Child, 1 year to about 8 years',
    hi: 'बच्चा, 1 साल से लगभग 8 साल तक',
  ),
  warning: _chokingWarning,
  sourceIds: ['S4'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'listen',
      text: LocalizedText(
        en: 'If the child can cough strongly, cry, speak or breathe, do not '
            'hit their back. Encourage them to keep coughing and stay close.',
        hi: 'अगर बच्चा ज़ोर से खाँस, रो, बोल या साँस ले पा रहा है, तो उसकी पीठ पर न '
            'मारें। उसे खाँसते रहने को कहें और पास रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'phone',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the child cannot cough, cry, speak or breathe, shout for help '
            'and ask someone to call 112. If you are alone, start first aid '
            'first.',
        hi: 'अगर बच्चा खाँस, रो, बोल या साँस नहीं ले पा रहा, तो मदद के लिए चिल्लाएँ और '
            'किसी से 112 पर कॉल करवाएँ। अगर आप अकेले हैं, तो पहले प्राथमिक '
            'उपचार शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'back',
      text: LocalizedText(
        en: 'Kneel down behind or beside the child. Lean them forward. Give 5 '
            'firm blows between the shoulder blades with the heel of your '
            'hand. Use less force than for an adult.',
        hi: 'बच्चे के पीछे या बगल में घुटनों के बल बैठें। उसे आगे झुकाएँ। हथेली के '
            'निचले हिस्से से कंधों के बीच 5 ज़ोरदार थपकियाँ मारें। वयस्क से कम '
            'ज़ोर लगाएँ।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'abdomen',
      text: LocalizedText(
        en: 'If still choking, kneel behind the child. Make a fist just above '
            'the belly button, hold it with your other hand, and pull inward '
            'and upward. Do this 5 times, with less force than for an adult.',
        hi: 'अगर अब भी दम घुट रहा है, तो बच्चे के पीछे घुटनों के बल बैठें। नाभि के ठीक '
            'ऊपर मुट्ठी रखें, दूसरे हाथ से पकड़ें, और अंदर और ऊपर की ओर खींचें। '
            'यह 5 बार करें, वयस्क से कम ज़ोर से।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'repeat',
      text: LocalizedText(
        en: 'Keep alternating 5 back blows and 5 belly thrusts until the '
            'object comes out or the child stops responding.',
        hi: '5 थपकियाँ और 5 पेट के झटके बारी-बारी से तब तक करें जब तक चीज़ बाहर न '
            'आ जाए या बच्चा प्रतिक्रिया देना बंद न कर दे।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'warning',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the child stops responding, lay them on the ground and make '
            'sure 112 has been called. Follow the 112 operator. If you are '
            'trained in child CPR, start it.',
        hi: 'अगर बच्चा प्रतिक्रिया देना बंद कर दे, तो उसे ज़मीन पर लिटाएँ और सुनिश्चित '
            'करें कि 112 पर कॉल हो चुकी है। 112 ऑपरेटर की बात मानें। अगर आपको '
            'बच्चों का CPR आता है, तो शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT hit the back if the child is coughing well. Do NOT give '
            'water. Do NOT push your fingers blindly into the mouth. Do NOT '
            'hold the child upside down.',
        hi: 'अगर बच्चा अच्छे से खाँस रहा है, तो पीठ पर न मारें। पानी न दें। अंधाधुंध '
            'मुँह में उँगली न डालें। बच्चे को उल्टा न लटकाएँ।',
      ),
    ),
    FirstAidStep(
      id: 'step08',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Even if the object comes out, take the child to a doctor, '
            'especially after belly thrusts or if there is cough, pain or '
            'trouble breathing or swallowing.',
        hi: 'चीज़ निकल जाने पर भी बच्चे को डॉक्टर को दिखाएँ, ख़ासकर पेट के झटकों के बाद '
            'या खाँसी, दर्द, साँस लेने या निगलने में तकलीफ़ हो तो।',
      ),
    ),
  ],
);

const _chokingInfant = GuidanceFlow(
  id: 'infant',
  iconKey: 'infant',
  title: LocalizedText(en: 'Choking: Infant', hi: 'दम घुटना: शिशु'),
  subtitle: LocalizedText(
    en: 'Baby under 1 year',
    hi: 'शिशु, 1 साल से कम',
  ),
  warning: _chokingWarning,
  sourceIds: ['S4'],
  steps: [
    FirstAidStep(
      id: 'step01',
      iconKey: 'listen',
      text: LocalizedText(
        en: 'If the baby can cry, cough or breathe, do not hit their back. Let '
            'the baby cough and stay close.',
        hi: 'अगर शिशु रो, खाँस या साँस ले पा रहा है, तो उसकी पीठ पर न मारें। उसे '
            'खाँसने दें और पास रहें।',
      ),
    ),
    FirstAidStep(
      id: 'step02',
      iconKey: 'phone',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the baby is silent, cannot cough, cry or breathe, or the face '
            'turns blue, shout for help and ask someone to call 112. If you '
            'are alone, start first aid first.',
        hi: 'अगर शिशु चुप है, खाँस, रो या साँस नहीं ले पा रहा, या चेहरा नीला पड़ रहा है, '
            'तो मदद के लिए चिल्लाएँ और किसी से 112 पर कॉल करवाएँ। अगर आप अकेले हैं, '
            'तो पहले प्राथमिक उपचार शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step03',
      iconKey: 'infant',
      text: LocalizedText(
        en: 'Sit down. Lay the baby face down along your forearm, with the '
            'head lower than the body. Support the head and jaw. Rest your '
            'arm on your thigh. Do not shake the baby.',
        hi: 'बैठ जाएँ। शिशु को अपनी बाँह पर पेट के बल लिटाएँ, सिर शरीर से नीचे रखें। '
            'सिर और जबड़े को सहारा दें। अपनी बाँह जाँघ पर टिकाएँ। शिशु को हिलाएँ '
            'नहीं।',
      ),
    ),
    FirstAidStep(
      id: 'step04',
      iconKey: 'back',
      text: LocalizedText(
        en: 'Give 5 firm blows between the shoulder blades with the heel of '
            'your hand.',
        hi: 'हथेली के निचले हिस्से से कंधों के बीच 5 ज़ोरदार थपकियाँ मारें।',
      ),
    ),
    FirstAidStep(
      id: 'step05',
      iconKey: 'chest',
      text: LocalizedText(
        en: 'Turn the baby face up on your forearm, head still lower than the '
            'body. Put two fingers on the middle of the chest and give 5 '
            'firm chest thrusts, pressing down and letting go.',
        hi: 'शिशु को पलटकर अपनी बाँह पर चेहरा ऊपर करके लिटाएँ, सिर अब भी नीचे रहे। '
            'छाती के बीच में दो उँगलियाँ रखें और 5 बार ज़ोर से दबाएँ और छोड़ें।',
      ),
    ),
    FirstAidStep(
      id: 'step06',
      iconKey: 'repeat',
      text: LocalizedText(
        en: 'Keep alternating 5 back blows and 5 chest thrusts until the '
            'object comes out or the baby stops responding.',
        hi: '5 थपकियाँ और 5 छाती के झटके बारी-बारी से तब तक करें जब तक चीज़ बाहर '
            'न आ जाए या शिशु प्रतिक्रिया देना बंद न कर दे।',
      ),
    ),
    FirstAidStep(
      id: 'step07',
      iconKey: 'warning',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'If the baby stops responding, lay the baby on a firm surface and '
            'make sure 112 has been called. Follow the 112 operator. If you '
            'are trained in infant CPR, start it.',
        hi: 'अगर शिशु प्रतिक्रिया देना बंद कर दे, तो उसे सख़्त सतह पर लिटाएँ और '
            'सुनिश्चित करें कि 112 पर कॉल हो चुकी है। 112 ऑपरेटर की बात मानें। '
            'अगर आपको शिशु का CPR आता है, तो शुरू करें।',
      ),
    ),
    FirstAidStep(
      id: 'step08',
      iconKey: 'no',
      type: StepType.avoid,
      text: LocalizedText(
        en: 'Do NOT give belly thrusts to a baby. Do NOT shake the baby. Do '
            'NOT push your fingers blindly into the mouth. Do NOT give water.',
        hi: 'शिशु को पेट के झटके न दें। शिशु को हिलाएँ नहीं। अंधाधुंध मुँह में उँगली न '
            'डालें। पानी न दें।',
      ),
    ),
    FirstAidStep(
      id: 'step09',
      iconKey: 'hospital',
      type: StepType.urgent,
      text: LocalizedText(
        en: 'Even if the object comes out, take the baby to a doctor.',
        hi: 'चीज़ निकल जाने पर भी शिशु को डॉक्टर को दिखाएँ।',
      ),
    ),
  ],
);

/// All home-screen categories, in display order.
const List<EmergencyCategory> kEmergencyCategories = [
  EmergencyCategory(
    id: 'burns',
    label: LocalizedText(en: 'Burns', hi: 'जलना'),
    iconKey: 'burn',
    flows: [_burns],
  ),
  EmergencyCategory(
    id: 'bleeding',
    label: LocalizedText(en: 'Cuts and Bleeding', hi: 'कटना और खून बहना'),
    iconKey: 'bleeding',
    flows: [_bleeding],
  ),
  EmergencyCategory(
    id: 'choking',
    label: LocalizedText(en: 'Choking', hi: 'दम घुटना'),
    iconKey: 'choking',
    flows: [_chokingAdult, _chokingChild, _chokingInfant],
  ),
  EmergencyCategory(
    id: 'snakebite',
    label: LocalizedText(en: 'Snakebite', hi: 'साँप का काटना'),
    iconKey: 'snake',
    flows: [_snakebite],
  ),
  EmergencyCategory(
    id: 'fracture',
    label: LocalizedText(en: 'Suspected Fracture', hi: 'हड्डी टूटने का शक'),
    iconKey: 'bone',
    flows: [_fracture],
  ),
];
