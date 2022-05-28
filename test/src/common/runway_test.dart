import 'package:awrep/src/common/runway.dart';
import 'package:awrep/src/common/runway_approach_direction.dart';
import 'package:awrep/src/common/runway_number.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Runway', () {
    group('constructor', () {
      runwayConstructor();
    });
    group('number', () {
      runwayNumber();
    });
    group('direction', () {
      runwayDirection();
    });
    group('toString', () {
      runwayToString();
    });
    group('equalityOperator', () {
      runwayEqualityOperator();
    });
    group('hashCode', () {
      runwayHashCode();
    });
  });
}

void runwayConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `Runway` format in `01 01`, but '
        'found `0` using `RegExp: pattern=^\\d{2}[L|C|R]?\$ flags=`';
    expectFormatException(() => Runway('01 01'), err);
  });

  test('Test compliance with format, negative with direction', () {
    var err = 'Expected to find one match of `Runway` format in `1RR`, but '
        'found `0` using `RegExp: pattern=^\\d{2}[L|C|R]?\$ flags=`';
    expectFormatException(() => Runway('1RR'), err);
  });

  test('Test compliance with format, positive', () {
    expect(Runway('01R'), isA<Runway>());
  });
}

void runwayNumber() {
  test('Test with leading zero, no approach', () {
    expect(Runway('01').number, RunwayNumber(1));
  });

  test('Test with leading zero, with approach', () {
    expect(Runway('01R').number, RunwayNumber(1));
  });

  test('Test without leading zero, no approach', () {
    expect(Runway('20').number, RunwayNumber(20));
  });

  test('Test without leading zero, with approach', () {
    expect(Runway('20R').number, RunwayNumber(20));
  });
}

void runwayDirection() {
  test('Test no match', () {
    expect(Runway('01').direction, RunwayApproachDirection.none);
  });

  test('Test left approach', () {
    expect(Runway('20L').direction, RunwayApproachDirection.left);
  });

  test('Test center approach', () {
    expect(Runway('25C').direction, RunwayApproachDirection.center);
  });

  test('Test right approach', () {
    expect(Runway('03R').direction, RunwayApproachDirection.right);
  });
}

void runwayEqualityOperator() {
  test('Test equality operator for non-equality, no approach', () {
    expect(Runway('01') == Runway('02'), false);
  });

  test('Test equality operator for non-equality, with approach', () {
    expect(Runway('02R') == Runway('02C'), false);
  });

  test('Test equality operator for equality, no approach', () {
    expect(Runway('01') == Runway('01'), true);
  });

  test('Test equality operator for equality, with approach', () {
    expect(Runway('02L') == Runway('02L'), true);
  });
}

void runwayHashCode() {
  test('Test hash generation for non-equality, no approach', () {
    expect(Runway('10').hashCode == Runway('20').hashCode, false);
  });

  test('Test hash generation for non-equality, with approach', () {
    expect(Runway('20R').hashCode == Runway('20C').hashCode, false);
  });

  test('Test hash generation for equality, no approach', () {
    expect(Runway('10').hashCode == Runway('10').hashCode, true);
  });

  test('Test hash generation for equality, with approach', () {
    expect(Runway('20L').hashCode == Runway('20L').hashCode, true);
  });
}

void runwayToString() {
  test('Test one-sign number value', () {
    expect(Runway('01').toString(), '01');
  });

  test('Test two-sign number value', () {
    expect(Runway('10').toString(), '10');
  });

  test('Test one-sign number value, left approach', () {
    expect(Runway('01L').toString(), '01L');
  });

  test('Test two-sign number value, left approach', () {
    expect(Runway('10L').toString(), '10L');
  });

  test('Test one-sign number value, center approach', () {
    expect(Runway('01C').toString(), '01C');
  });

  test('Test two-sign number value, center approach', () {
    expect(Runway('10C').toString(), '10C');
  });

  test('Test one-sign number value, right approach', () {
    expect(Runway('01R').toString(), '01R');
  });

  test('Test two-sign number value, right approach', () {
    expect(Runway('10R').toString(), '10R');
  });
}
