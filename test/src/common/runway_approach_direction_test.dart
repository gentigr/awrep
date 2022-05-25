import 'package:awrep/src/common/report_runway_approach_direction.dart';
import 'package:test/test.dart';

void main() {
  group('ReportRunwayApproachDirection', () {
    group('string', () {
      reportRunwayApproachDirectionString();
    });
    group('stringAsReportModifier', () {
      reportRunwayApproachDirectionStringAsReportRunwayApproachDirection();
    });
  });
}

void reportRunwayApproachDirectionString() {
  test('Test string representation of non-present runway direction', () {
    expect(ReportRunwayApproachDirection.none.string.isEmpty, true);
  });
  test('Test string representation of left runway direction', () {
    expect(ReportRunwayApproachDirection.left.string, 'L');
  });
  test('Test string representation of center runway direction', () {
    expect(ReportRunwayApproachDirection.center.string, 'C');
  });
  test('Test string representation of right runway direction', () {
    expect(ReportRunwayApproachDirection.right.string, 'R');
  });
}

void reportRunwayApproachDirectionStringAsReportRunwayApproachDirection() {
  test('Test constructor with empty string input', () {
    expect(stringAsReportRunwayApproachDirection(''),
        ReportRunwayApproachDirection.none);
  });

  test('Test constructor with null string input', () {
    expect(stringAsReportRunwayApproachDirection(null),
        ReportRunwayApproachDirection.none);
  });

  test('Test constructor with left string input', () {
    expect(stringAsReportRunwayApproachDirection('l'),
        ReportRunwayApproachDirection.left);
  });

  test('Test constructor with center string input', () {
    expect(stringAsReportRunwayApproachDirection('c'),
        ReportRunwayApproachDirection.center);
  });

  test('Test constructor with right string input', () {
    expect(stringAsReportRunwayApproachDirection('r'),
        ReportRunwayApproachDirection.right);
  });

  test('Test constructor with random case string input', () {
    expect(stringAsReportRunwayApproachDirection('R'),
        ReportRunwayApproachDirection.right);
  });

  test('Test constructor with leading space string input', () {
    expect(stringAsReportRunwayApproachDirection(' L'),
        ReportRunwayApproachDirection.left);
  });

  test('Test constructor with trailing space string input', () {
    expect(stringAsReportRunwayApproachDirection('L '),
        ReportRunwayApproachDirection.left);
  });

  test('Test constructor with leading and trailing spaces string input', () {
    expect(stringAsReportRunwayApproachDirection(' C '),
        ReportRunwayApproachDirection.center);
  });

  test('Test constructor with unexpected input', () {
    var err = 'Unexpected report runway approach direction value: `UNEXPECTED`';
    expect(
        () => stringAsReportRunwayApproachDirection('UNEXPECTED'),
        throwsA(predicate((e) =>
            e is ReportRunwayApproachDirectionException && e.message == err)));
  });
}
