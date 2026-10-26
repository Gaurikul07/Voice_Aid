import 'localized_text.dart';

/// What kind of instruction a step is. The UI shows a text label and an icon
/// for each type so danger is never communicated by colour alone.
enum StepType {
  /// Something to do.
  action,

  /// Something that must NOT be done.
  avoid,

  /// When to get urgent medical help.
  urgent,
}

/// One short, speakable instruction.
class FirstAidStep {
  const FirstAidStep({
    required this.id,
    required this.text,
    required this.iconKey,
    this.type = StepType.action,
  });

  final String id;
  final LocalizedText text;

  /// Name of an icon; mapped to an IconData in widgets/icon_mapper.dart.
  final String iconKey;
  final StepType type;
}

/// An ordered guidance sequence, e.g. "Choking - infant".
class GuidanceFlow {
  const GuidanceFlow({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.warning,
    required this.steps,
    required this.sourceIds,
    this.needsClinicalReview = true,
    this.iconKey = 'info',
  });

  final String id;
  final LocalizedText title;

  /// Short description, e.g. "Baby under 1 year".
  final LocalizedText subtitle;

  /// Emergency warning always shown at the top of the guidance screen.
  final LocalizedText warning;
  final List<FirstAidStep> steps;

  /// Ids into MEDICAL_CONTENT_SOURCES.md (S1, S2...).
  final List<String> sourceIds;

  /// True until a qualified reviewer signs the content off.
  final bool needsClinicalReview;
  final String iconKey;

  /// Relative asset path of the recorded audio for a step, whether or not the
  /// file actually exists. Convention:
  /// assets/audio/<lang>/<categoryId>/<flowId>_step<NN>.mp3
  String audioAssetPath({
    required String languageCode,
    required String categoryId,
    required int stepIndex,
  }) {
    final n = (stepIndex + 1).toString().padLeft(2, '0');
    return 'assets/audio/$languageCode/$categoryId/${id}_step$n.mp3';
  }
}

/// A home-screen emergency category with one or more guidance flows.
class EmergencyCategory {
  const EmergencyCategory({
    required this.id,
    required this.label,
    required this.iconKey,
    required this.flows,
  });

  final String id;
  final LocalizedText label;
  final String iconKey;

  /// Most categories have one flow. Choking has three (adult/child/infant),
  /// which are deliberately NOT merged into one sequence.
  final List<GuidanceFlow> flows;

  bool get hasMultipleFlows => flows.length > 1;

  GuidanceFlow? flowById(String flowId) {
    for (final f in flows) {
      if (f.id == flowId) return f;
    }
    return null;
  }
}
