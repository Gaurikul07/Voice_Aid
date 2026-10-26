import '../models/first_aid_models.dart';
import 'first_aid_content.dart';

/// Read-only access to the bundled first-aid content, with validation so empty
/// or incomplete content is detected instead of silently shown.
class FirstAidRepository {
  const FirstAidRepository({
    this.categories = kEmergencyCategories,
  });

  final List<EmergencyCategory> categories;

  EmergencyCategory? categoryById(String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  /// Returns a human-readable list of problems; empty means content is valid.
  List<String> validate() {
    final problems = <String>[];
    if (categories.isEmpty) problems.add('No categories defined.');
    final seenCategories = <String>{};
    for (final c in categories) {
      if (c.id.trim().isEmpty) problems.add('Category with empty id.');
      if (!seenCategories.add(c.id)) problems.add('Duplicate category ${c.id}.');
      if (!c.label.isComplete) problems.add('${c.id}: label not translated.');
      if (c.flows.isEmpty) problems.add('${c.id}: no flows.');
      final seenFlows = <String>{};
      for (final f in c.flows) {
        final where = '${c.id}/${f.id}';
        if (!seenFlows.add(f.id)) problems.add('$where: duplicate flow id.');
        if (!f.title.isComplete) problems.add('$where: title not translated.');
        if (!f.warning.isComplete) {
          problems.add('$where: emergency warning missing/untranslated.');
        }
        if (f.steps.isEmpty) problems.add('$where: no steps.');
        if (f.sourceIds.isEmpty) problems.add('$where: no source reference.');
        final seenSteps = <String>{};
        var hasAvoid = false;
        var hasUrgent = false;
        for (final s in f.steps) {
          if (!seenSteps.add(s.id)) problems.add('$where/${s.id}: duplicate.');
          if (!s.text.isComplete) {
            problems.add('$where/${s.id}: text not translated.');
          }
          if (s.type == StepType.avoid) hasAvoid = true;
          if (s.type == StepType.urgent) hasUrgent = true;
        }
        if (!hasAvoid) problems.add('$where: no "do NOT" step.');
        if (!hasUrgent) problems.add('$where: no "get urgent help" step.');
      }
    }
    return problems;
  }
}
