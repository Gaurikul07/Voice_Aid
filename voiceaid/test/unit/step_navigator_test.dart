import 'package:flutter_test/flutter_test.dart';
import 'package:voiceaid/logic/step_navigator.dart';

void main() {
  test('starts on the first step', () {
    final n = StepNavigator(3);
    expect(n.index, 0);
    expect(n.number, 1);
    expect(n.isFirst, isTrue);
    expect(n.canGoPrevious, isFalse);
  });

  test('next and previous move one step at a time', () {
    final n = StepNavigator(3);
    expect(n.next(), isTrue);
    expect(n.index, 1);
    expect(n.next(), isTrue);
    expect(n.isLast, isTrue);
    expect(n.previous(), isTrue);
    expect(n.index, 1);
  });

  test('cannot go past either end', () {
    final n = StepNavigator(2);
    expect(n.previous(), isFalse);
    n.next();
    expect(n.next(), isFalse);
    expect(n.index, 1);
  });

  test('goTo validates the index', () {
    final n = StepNavigator(3);
    expect(n.goTo(2), isTrue);
    expect(n.goTo(3), isFalse);
    expect(n.goTo(-1), isFalse);
    expect(n.index, 2);
  });

  test('empty navigator is safe', () {
    final n = StepNavigator(0);
    expect(n.isEmpty, isTrue);
    expect(n.next(), isFalse);
    expect(n.previous(), isFalse);
    expect(n.number, 0);
  });
}
