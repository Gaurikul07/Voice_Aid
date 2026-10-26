/// Pure step-navigation logic (no Flutter), so it is easy to unit test.
///
/// It NEVER advances by itself: only [next] / [previous] / [goTo] move it.
class StepNavigator {
  StepNavigator(this.stepCount) : assert(stepCount >= 0);

  final int stepCount;
  int _index = 0;

  int get index => _index;
  int get number => stepCount == 0 ? 0 : _index + 1;
  bool get isEmpty => stepCount == 0;
  bool get isFirst => _index == 0;
  bool get isLast => stepCount == 0 || _index == stepCount - 1;
  bool get canGoNext => !isEmpty && _index < stepCount - 1;
  bool get canGoPrevious => !isEmpty && _index > 0;

  /// Moves forward. Returns false (and stays put) on the last step.
  bool next() {
    if (!canGoNext) return false;
    _index++;
    return true;
  }

  /// Moves back. Returns false (and stays put) on the first step.
  bool previous() {
    if (!canGoPrevious) return false;
    _index--;
    return true;
  }

  /// Jumps to [i] if valid; otherwise stays put and returns false.
  bool goTo(int i) {
    if (i < 0 || i >= stepCount) return false;
    _index = i;
    return true;
  }
}
