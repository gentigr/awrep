import 'package:awrep/src/common/stable_visual_range.dart';
import 'package:awrep/src/common/distance_qualifier.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('StableVisualRange', () {
    group('constructor', () {
      stableVisualRangeConstructor();
    });
    group('distance', () {
      stableVisualRangeDistance();
    });
    group('qualifier', () {
      stableVisualRangeQualifier();
    });
    group('toString', () {
      stableVisualRangeToString();
    });
    group('equalityOperator', () {
      stableVisualRangeEqualityOperator();
    });
    group('hashCode', () {
      stableVisualRangeHashCode();
    });
  });
}

void stableVisualRangeConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `StableVisualRange` format in '
        '`01010`, but found `0` using '
        '`RegExp: pattern=^[M|P]?\\d{4}FT\$ flags=`';
    expectFormatException(() => StableVisualRange('01010'), err);
  });

  test('Test compliance with format, negative with qualifier', () {
    var err = 'Expected to find one match of `StableVisualRange` format in '
        '`RR101`, but found `0` using '
        '`RegExp: pattern=^[M|P]?\\d{4}FT\$ flags=`';
    expectFormatException(() => StableVisualRange('RR101'), err);
  });

  test('Test compliance with format, positive', () {
    expect(StableVisualRange('M1000FT'), isA<StableVisualRange>());
  });
}

void stableVisualRangeDistance() {
  test('Test with no leading zero, no qualifier', () {
    expect(StableVisualRange('1000FT').distance, 1000);
  });

  test('Test with one leading zero, no qualifier', () {
    expect(StableVisualRange('0100FT').distance, 100);
  });

  test('Test with two leading zero, no qualifier', () {
    expect(StableVisualRange('0010FT').distance, 10);
  });

  test('Test with three leading zero, no qualifier', () {
    expect(StableVisualRange('0001FT').distance, 1);
  });

  test('Test with four leading zero, no qualifier', () {
    expect(StableVisualRange('0000FT').distance, 0);
  });

  test('Test with no leading zero, with qualifier', () {
    expect(StableVisualRange('P2000FT').distance, 2000);
  });

  test('Test with one leading zero, with qualifier', () {
    expect(StableVisualRange('P0200FT').distance, 200);
  });

  test('Test with two leading zero, with qualifier', () {
    expect(StableVisualRange('P0020FT').distance, 20);
  });

  test('Test with three leading zero, with qualifier', () {
    expect(StableVisualRange('P0002FT').distance, 2);
  });

  test('Test with four leading zero, with qualifier', () {
    expect(StableVisualRange('P0000FT').distance, 0);
  });
}

void stableVisualRangeQualifier() {
  test('Test no match', () {
    expect(StableVisualRange('2000FT').qualifier, DistanceQualifier.none);
  });

  test('Test MINUS qualifier', () {
    expect(StableVisualRange('M1000FT').qualifier, DistanceQualifier.less);
  });

  test('Test PLUS qualifier', () {
    expect(StableVisualRange('P5000FT').qualifier, DistanceQualifier.more);
  });
}

void stableVisualRangeToString() {
  test('Test no leading zeros', () {
    expect(StableVisualRange('1000FT').toString(), '1000FT');
  });

  test('Test one leading zeros', () {
    expect(StableVisualRange('0100FT').toString(), '0100FT');
  });

  test('Test two leading zeros', () {
    expect(StableVisualRange('0010FT').toString(), '0010FT');
  });

  test('Test three leading zeros', () {
    expect(StableVisualRange('0001FT').toString(), '0001FT');
  });

  test('Test four leading zeros', () {
    expect(StableVisualRange('0000FT').toString(), '0000FT');
  });

  test('Test four leading zeros with PLUS modifier', () {
    expect(StableVisualRange('P0000FT').toString(), 'P0000FT');
  });

  test('Test no leading zeros with MINUS modifier', () {
    expect(StableVisualRange('M5555FT').toString(), 'M5555FT');
  });
}

void stableVisualRangeEqualityOperator() {
  test('Test equality operator for non-equality, no qualifier', () {
    expect(StableVisualRange('0100FT') == StableVisualRange('0200FT'), false);
  });

  test('Test equality operator for non-equality, with qualifier', () {
    expect(StableVisualRange('M0100FT') == StableVisualRange('0100FT'), false);
  });

  test('Test equality operator for equality, no qualifier', () {
    expect(StableVisualRange('0100FT') == StableVisualRange('0100FT'), true);
  });

  test('Test equality operator for equality, with qualifier', () {
    expect(StableVisualRange('P0200FT') == StableVisualRange('P0200FT'), true);
  });
}

void stableVisualRangeHashCode() {
  test('Test hash generation for non-equality, no qualifier', () {
    expect(
        StableVisualRange('0100FT').hashCode ==
            StableVisualRange('0200FT').hashCode,
        false);
  });

  test('Test hash generation for non-equality, with qualifier', () {
    expect(
        StableVisualRange('M0100FT').hashCode ==
            StableVisualRange('0100FT').hashCode,
        false);
  });

  test('Test hash generation for equality, no qualifier', () {
    expect(
        StableVisualRange('0100FT').hashCode ==
            StableVisualRange('0100FT').hashCode,
        true);
  });

  test('Test hash generation for equality, with qualifier', () {
    expect(
        StableVisualRange('P0200FT').hashCode ==
            StableVisualRange('P0200FT').hashCode,
        true);
  });
}
