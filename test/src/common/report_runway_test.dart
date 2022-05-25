import 'package:awrep/src/common/report_runway.dart';
import 'package:awrep/body/report_runway_approach_direction.dart';
import 'package:test/test.dart';

void main() {
  group('ReportRunway', () {
    group('number', () {
      reportRunwayNumber();
    });
    group('direction', () {
      reportRunwayDirection();
    });
    group('equalityOperator', () {
      reportRunwayEqualityOperator();
    });
    group('hashCode', () {
      reportRunwayHashCode();
    });
    group('toString', () {
      reportRunwayToString();
    });
  });
}

void reportRunwayNumber() {
  test('Test no match', () {
    var err = 'Failed to find RegEx `RegExp: pattern=^(?<number>\\d{2}) '
        'flags=` in runway coding `L`';

    expect(
        () => ReportRunway('L').number,
        throwsA(
            predicate((e) => e is ReportRunwayException && e.message == err)));
  });

  test('Test with leading zero, no approach', () {
    expect(ReportRunway('01').number, 1);
  });

  test('Test with leading zero, with approach', () {
    expect(ReportRunway('01R').number, 1);
  });

  test('Test without leading zero, no approach', () {
    expect(ReportRunway('20').number, 20);
  });

  test('Test without leading zero, with approach', () {
    expect(ReportRunway('20R').number, 20);
  });

  test('Test lower limit', () {
    var err = 'Report runway value must be within [1; 36] range, '
        'provided: `0` from `00`';

    expect(
        () => ReportRunway('00').number,
        throwsA(
            predicate((e) => e is ReportRunwayException && e.message == err)));
  });

  test('Test upper limit', () {
    var err = 'Report runway value must be within [1; 36] range, '
        'provided: `37` from `37`';

    expect(
        () => ReportRunway('37').number,
        throwsA(
            predicate((e) => e is ReportRunwayException && e.message == err)));
  });
}

void reportRunwayDirection() {
  test('Test no match', () {
    expect(ReportRunway('01').direction, ReportRunwayApproachDirection.none);
  });

  test('Test left approach', () {
    expect(ReportRunway('20L').direction, ReportRunwayApproachDirection.left);
  });

  test('Test center approach', () {
    expect(ReportRunway('25C').direction, ReportRunwayApproachDirection.center);
  });

  test('Test right approach', () {
    expect(ReportRunway('03R').direction, ReportRunwayApproachDirection.right);
  });

  test('Test left approach, low case', () {
    expect(ReportRunway('20l').direction, ReportRunwayApproachDirection.left);
  });

  test('Test center approach, low case', () {
    expect(ReportRunway('25c').direction, ReportRunwayApproachDirection.center);
  });

  test('Test right approach, low case', () {
    expect(ReportRunway('03r').direction, ReportRunwayApproachDirection.right);
  });
}

void reportRunwayEqualityOperator() {
  test('Test equality operator for non-equality, no approach', () {
    expect(ReportRunway('01') == ReportRunway('02'), false);
  });

  test('Test equality operator for non-equality, with approach', () {
    expect(ReportRunway('02R') == ReportRunway('02C'), false);
  });

  test('Test equality operator for equality, no approach', () {
    expect(ReportRunway('01') == ReportRunway('01'), true);
  });

  test('Test equality operator for equality, with approach', () {
    expect(ReportRunway('02L') == ReportRunway('02L'), true);
  });
}

void reportRunwayHashCode() {
  test('Test hash generation for non-equality, no approach', () {
    expect(ReportRunway('10').hashCode == ReportRunway('20').hashCode, false);
  });

  test('Test hash generation for non-equality, with approach', () {
    expect(ReportRunway('20R').hashCode == ReportRunway('20C').hashCode, false);
  });

  test('Test hash generation for equality, no approach', () {
    expect(ReportRunway('10').hashCode == ReportRunway('10').hashCode, true);
  });

  test('Test hash generation for equality, with approach', () {
    expect(ReportRunway('20L').hashCode == ReportRunway('20L').hashCode, true);
  });
}

void reportRunwayToString() {
  test('Test one-sign number value', () {
    expect(ReportRunway('01').toString(), '01');
  });

  test('Test two-sign number value', () {
    expect(ReportRunway('10').toString(), '10');
  });

  test('Test one-sign number value, left approach', () {
    expect(ReportRunway('01L').toString(), '01L');
  });

  test('Test two-sign number value, left approach', () {
    expect(ReportRunway('10l').toString(), '10L');
  });

  test('Test one-sign number value, center approach', () {
    expect(ReportRunway('01c').toString(), '01C');
  });

  test('Test two-sign number value, center approach', () {
    expect(ReportRunway('10C').toString(), '10C');
  });

  test('Test one-sign number value, right approach', () {
    expect(ReportRunway('01r').toString(), '01R');
  });

  test('Test two-sign number value, right approach', () {
    expect(ReportRunway('10R').toString(), '10R');
  });
}
