import 'package:awrep/src/common/runway_approach_direction.dart';
import 'package:test/test.dart';

void main() {
  group('RunwayApproachDirection', () {
    group('string', () {
      runwayApproachDirectionString();
    });
    group('stringAsReportModifier', () {
      runwayApproachDirectionStringAsRunwayApproachDirection();
    });
  });
}

void runwayApproachDirectionString() {
  test('Test string representation of non-present runway direction', () {
    expect(RunwayApproachDirection.none.string.isEmpty, true);
  });
  test('Test string representation of left runway direction', () {
    expect(RunwayApproachDirection.left.string, 'L');
  });
  test('Test string representation of center runway direction', () {
    expect(RunwayApproachDirection.center.string, 'C');
  });
  test('Test string representation of right runway direction', () {
    expect(RunwayApproachDirection.right.string, 'R');
  });
}

void runwayApproachDirectionStringAsRunwayApproachDirection() {
  test('Test constructor with empty string input', () {
    expect(stringAsRunwayApproachDirection(''), RunwayApproachDirection.none);
  });

  test('Test constructor with null string input', () {
    expect(stringAsRunwayApproachDirection(null), RunwayApproachDirection.none);
  });

  test('Test constructor with left string input', () {
    expect(stringAsRunwayApproachDirection('l'), RunwayApproachDirection.left);
  });

  test('Test constructor with center string input', () {
    expect(
        stringAsRunwayApproachDirection('c'), RunwayApproachDirection.center);
  });

  test('Test constructor with right string input', () {
    expect(stringAsRunwayApproachDirection('r'), RunwayApproachDirection.right);
  });

  test('Test constructor with random case string input', () {
    expect(stringAsRunwayApproachDirection('R'), RunwayApproachDirection.right);
  });

  test('Test constructor with leading space string input', () {
    expect(stringAsRunwayApproachDirection(' L'), RunwayApproachDirection.left);
  });

  test('Test constructor with trailing space string input', () {
    expect(stringAsRunwayApproachDirection('L '), RunwayApproachDirection.left);
  });

  test('Test constructor with leading and trailing spaces string input', () {
    expect(
        stringAsRunwayApproachDirection(' C '), RunwayApproachDirection.center);
  });

  test('Test constructor with unexpected input', () {
    var err = 'Unexpected report runway approach direction value: `UNEXPECTED`';
    expect(
        () => stringAsRunwayApproachDirection('UNEXPECTED'),
        throwsA(predicate(
            (e) => e is RunwayApproachDirectionException && e.message == err)));
  });
}
