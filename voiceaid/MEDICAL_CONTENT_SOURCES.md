# Medical Content Sources and Review Status

**Status of ALL content: PROTOTYPE - REQUIRES QUALIFIED MEDICAL REVIEW.**
Every guidance flow in the app has `needsClinicalReview = true`, and the app
shows this on the guidance screen. Nothing here has been validated by a
clinician, first-aid trainer, or certified medical translator.

## How the sources were gathered (honest method note)

- Sources were located by web search on **22 October 2026** and read as search
  excerpts. Full pages were **not** all opened and read end to end. The
  "review date" below is the date these excerpts were checked, not a clinical
  review date.
- Wording was adapted into short, spoken-style steps by the developer
  (an AI assistant). Where a step goes beyond what a listed source says, it is
  flagged in the "Not directly supported / needs review" column.
- Most sources are not from India. Only the emergency-number source (S1) is an
  Indian government source. India-specific first-aid guidance (for example from
  the Indian Red Cross Society, NDMA, or national snakebite guidelines) should
  be added by the reviewer.
- Hindi text was written by the developer and has not been checked by a native
  medical translator.

## Source list

| ID | Title / publisher | URL | Used for | Checked |
|----|-------------------|-----|----------|---------|
| S1 | Emergency Response Support System (ERSS), Ministry of Home Affairs, Government of India | https://www.mha.gov.in/en/commoncontent/emergency-response-support-system-erss | National emergency number 112 | 2026-10-22 |
| S2 | Snakebite envenoming - Treatment, World Health Organization | https://www.who.int/teams/control-of-neglected-tropical-diseases/snakebite-envenoming/treatment | Snakebite: immobilise completely, never use a tight arterial tourniquet, avoid traditional remedies, early hospital care | 2026-10-22 |
| S3 | First aid for burns, British Red Cross | https://www.redcross.org.uk/first-aid/learn-first-aid/burns | Burns: cool under running water at least 20 min; no ice, butter, toothpaste | 2026-10-22 |
| S4 | Choking: First aid, Mayo Clinic (cites American Red Cross First Aid/CPR/AED Participant's Manual, 2021) | https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637 | Choking: 5 back blows + 5 abdominal thrusts (adult/child); infant back blows + chest thrusts; if alone, start first aid | 2026-10-22 |
| S5 | Bleeding, Better Health Channel (Victoria State Government, Australia) | https://www.betterhealth.vic.gov.au/health/conditionsandtreatments/bleeding | Bleeding: direct pressure, do not remove soaked dressing | 2026-10-22 |
| S6 | Bleeding first aid guide, Australian Red Cross (PDF, "accurate as of July 2015" - dated) | https://www.redcross.org.au/globalassets/cms/first-aid/first-aid-pdfs/first-aid-guides/bleeding.pdf | Bleeding: pressure with pad/bandage, do not over-tighten, do not remove embedded object | 2026-10-22 |
| S7 | Fractures (broken bones): First aid, Mayo Clinic | https://www.mayoclinic.org/first-aid/first-aid-fractures/basics/art-20056641 | Fracture: do not move unless needed, stop bleeding, keep still, do not realign or push bone back, splint only if trained and help is far | 2026-10-22 |
| S8 | First aid for snakebite, Instituto Clodomiro Picado, University of Costa Rica | https://icp.ucr.ac.cr/en/information-and-materials/first-aid | Snakebite: do not cut, suck, apply ice or tourniquet; snake need not be brought for identification | 2026-10-22 |

## Per-category status

| Category | Sources | Flagged items needing qualified review |
|----------|---------|----------------------------------------|
| Burns | S3 | "Roll on the ground / smother flames with blanket" (standard advice but not in the excerpt read); "do not burst blisters"; cover with a clean dry non-fluffy cloth (S3 mentions cling film / non-stick dressing; cling film omitted as it may not be available in rural settings); the list of severe-burn warning signs and the absence of a numeric size threshold; "ghee / any paste or powder" examples; "pour clean cool water if no running water" |
| Cuts and bleeding | S5, S6 | Raising the limb above the heart (S5 says "if possible"; conflicts with fracture suspicion, hence the caveat); "do not put soil, ash, powder, leaves or paste" (reasonable but not quoted from S5/S6); "do not tie a tight rope/band above the wound" (sources allow a tourniquet only if trained and pressure fails - tourniquet use is intentionally NOT taught); the urgent-help list |
| Choking | S4 | **Child age range ("1 year to about 8")** and "less force" wording; infant flow: S4 excerpt says back thumps then chest compressions - the exact finger position/depth is not stated, so none is given; CPR is only mentioned as "follow the 112 operator / start if trained" - no CPR steps are taught; pregnant or very large adults (chest thrusts) and self-treatment are **not included**; the "see a doctor even if object comes out" step |
| Snakebite | S2, S8 | **Pressure-immobilisation bandaging is deliberately NOT included**: guidance differs by species and region and must be decided by a qualified reviewer for India; "splint like a fracture, do not tie tight" (from secondary sources); removing rings/watches; "carry, do not let them walk"; danger-sign list; no instruction on photographing the snake |
| Suspected fracture | S7 | Neck/back/head caution wording; "stand/weight bearing" wording; splinting is conditional ("if you know how and help is far") as in S7; food/drink advice is intentionally omitted; cold packs omitted except "no ice directly on skin" |
| Emergency numbers | S1 | **Only 112 is verified from an official source.** 108/100/101 are shown in a separate section labelled "not verified here"; they came from news reports describing the older numbers that 112 integrates, and their availability varies by state. A user-configurable contact is provided instead of guessing local numbers. |

## What is explicitly NOT covered

CPR, choking for pregnant/obese adults, choking self-help, pressure-immobilisation
bandaging, chemical or electrical burns beyond "get urgent help", head/spine
injury care beyond "do not move, call 112", shock management beyond "lie down
and keep warm", and any medication advice.

## Reviewer checklist

- [ ] Each step compared line-by-line with an Indian authority (Indian Red Cross Society, MoHFW/NDMA, national snakebite guideline).
- [ ] Hindi reviewed by a native speaker with medical/first-aid knowledge (simple register for low-literacy listeners).
- [ ] Choking child/infant steps checked by a certified first-aid instructor.
- [ ] Snakebite immobilisation wording approved for the regional snake species.
- [ ] Reviewer name, qualification and date recorded here before real-world use: ______
