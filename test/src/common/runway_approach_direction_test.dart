import 'package:metar/src/common/runway_approach_direction.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('RunwayApproachDirection', () {
    group('factory', () {
      runwayApproachDirectionFactory();
    });
    group('toString', () {
      runwayApproachDirectionToString();
    });
  });
}

void runwayApproachDirectionFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Runway approach direction must consist only of 1 non-space '
        'character, provided `UNEXPECTED`';
    expectFormatException(() => RunwayApproachDirection('UNEXPECTED'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Unexpected runway approach direction, provided: `U`';
    expectFormatException(() => RunwayApproachDirection('U'), err);
  });

  test('Test constructor with empty string input', () {
    expect(RunwayApproachDirection(''), RunwayApproachDirection.none);
  });

  test('Test constructor with null string input', () {
    expect(RunwayApproachDirection(null), RunwayApproachDirection.none);
  });

  test('Test constructor with left string input', () {
    expect(RunwayApproachDirection('l'), RunwayApproachDirection.left);
  });

  test('Test constructor with center string input', () {
    expect(RunwayApproachDirection('c'), RunwayApproachDirection.center);
  });

  test('Test constructor with right string input', () {
    expect(RunwayApproachDirection('r'), RunwayApproachDirection.right);
  });

  test('Test constructor with random case string input', () {
    expect(RunwayApproachDirection('R'), RunwayApproachDirection.right);
  });

  test('Test constructor with leading space string input', () {
    expect(RunwayApproachDirection(' L'), RunwayApproachDirection.left);
  });

  test('Test constructor with trailing space string input', () {
    expect(RunwayApproachDirection('L '), RunwayApproachDirection.left);
  });

  test('Test constructor with leading and trailing spaces string input', () {
    expect(RunwayApproachDirection(' C '), RunwayApproachDirection.center);
  });
}

void runwayApproachDirectionToString() {
  test('Test string representation of non-present runway direction', () {
    expect(RunwayApproachDirection.none.toString().isEmpty, true);
  });
  test('Test string representation of left runway direction', () {
    expect(RunwayApproachDirection.left.toString(), 'L');
  });
  test('Test string representation of center runway direction', () {
    expect(RunwayApproachDirection.center.toString(), 'C');
  });
  test('Test string representation of right runway direction', () {
    expect(RunwayApproachDirection.right.toString(), 'R');
  });
}
