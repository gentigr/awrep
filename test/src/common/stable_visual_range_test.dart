import 'package:awrep/src/common/visual_range.dart';
import 'package:awrep/src/common/distance_qualifier.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('VisualRange', () {
    group('constructor', () {
      visualRangeConstructor();
    });
    group('distance', () {
      visualRangeDistance();
    });
    group('qualifier', () {
      visualRangeQualifier();
    });
    group('toString', () {
      visualRangeToString();
    });
    group('equalityOperator', () {
      visualRangeEqualityOperator();
    });
    group('hashCode', () {
      visualRangeHashCode();
    });
  });
}

void visualRangeConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `VisualRange` format in `01010`, '
        'but found `0` using `RegExp: pattern=^[M|P]?\\d{4}FT\$ flags=`';
    expectFormatException(() => VisualRange('01010'), err);
  });

  test('Test compliance with format, negative with qualifier', () {
    var err = 'Expected to find one match of `VisualRange` format in `RR101`, '
        'but found `0` using `RegExp: pattern=^[M|P]?\\d{4}FT\$ flags=`';
    expectFormatException(() => VisualRange('RR101'), err);
  });

  test('Test compliance with format, positive', () {
    expect(VisualRange('M1000FT'), isA<VisualRange>());
  });
}

void visualRangeDistance() {
  test('Test with no leading zero, no qualifier', () {
    expect(VisualRange('1000FT').distance, 1000);
  });

  test('Test with one leading zero, no qualifier', () {
    expect(VisualRange('0100FT').distance, 100);
  });

  test('Test with two leading zero, no qualifier', () {
    expect(VisualRange('0010FT').distance, 10);
  });

  test('Test with three leading zero, no qualifier', () {
    expect(VisualRange('0001FT').distance, 1);
  });

  test('Test with four leading zero, no qualifier', () {
    expect(VisualRange('0000FT').distance, 0);
  });

  test('Test with no leading zero, with qualifier', () {
    expect(VisualRange('P2000FT').distance, 2000);
  });

  test('Test with one leading zero, with qualifier', () {
    expect(VisualRange('P0200FT').distance, 200);
  });

  test('Test with two leading zero, with qualifier', () {
    expect(VisualRange('P0020FT').distance, 20);
  });

  test('Test with three leading zero, with qualifier', () {
    expect(VisualRange('P0002FT').distance, 2);
  });

  test('Test with four leading zero, with qualifier', () {
    expect(VisualRange('P0000FT').distance, 0);
  });
}

void visualRangeQualifier() {
  test('Test no match', () {
    expect(VisualRange('2000FT').qualifier, DistanceQualifier.none);
  });

  test('Test MINUS qualifier', () {
    expect(VisualRange('M1000FT').qualifier, DistanceQualifier.less);
  });

  test('Test PLUS qualifier', () {
    expect(VisualRange('P5000FT').qualifier, DistanceQualifier.more);
  });
}

void visualRangeToString() {
  test('Test no leading zeros', () {
    expect(VisualRange('1000FT').toString(), '1000FT');
  });

  test('Test one leading zeros', () {
    expect(VisualRange('0100FT').toString(), '0100FT');
  });

  test('Test two leading zeros', () {
    expect(VisualRange('0010FT').toString(), '0010FT');
  });

  test('Test three leading zeros', () {
    expect(VisualRange('0001FT').toString(), '0001FT');
  });

  test('Test four leading zeros', () {
    expect(VisualRange('0000FT').toString(), '0000FT');
  });

  test('Test four leading zeros with PLUS modifier', () {
    expect(VisualRange('P0000FT').toString(), 'P0000FT');
  });

  test('Test no leading zeros with MINUS modifier', () {
    expect(VisualRange('M5555FT').toString(), 'M5555FT');
  });
}

void visualRangeEqualityOperator() {
  test('Test equality operator for non-equality, no qualifier', () {
    expect(VisualRange('0100FT') == VisualRange('0200FT'), false);
  });

  test('Test equality operator for non-equality, with qualifier', () {
    expect(VisualRange('M0100FT') == VisualRange('0100FT'), false);
  });

  test('Test equality operator for equality, no qualifier', () {
    expect(VisualRange('0100FT') == VisualRange('0100FT'), true);
  });

  test('Test equality operator for equality, with qualifier', () {
    expect(VisualRange('P0200FT') == VisualRange('P0200FT'), true);
  });
}

void visualRangeHashCode() {
  test('Test hash generation for non-equality, no qualifier', () {
    expect(VisualRange('0100FT').hashCode == VisualRange('0200FT').hashCode,
        false);
  });

  test('Test hash generation for non-equality, with qualifier', () {
    expect(VisualRange('M0100FT').hashCode == VisualRange('0100FT').hashCode,
        false);
  });

  test('Test hash generation for equality, no qualifier', () {
    expect(
        VisualRange('0100FT').hashCode == VisualRange('0100FT').hashCode, true);
  });

  test('Test hash generation for equality, with qualifier', () {
    expect(VisualRange('P0200FT').hashCode == VisualRange('P0200FT').hashCode,
        true);
  });
}
