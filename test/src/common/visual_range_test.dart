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
        'but found `0` using `RegExp: pattern=^[M|P]?\\d{4}\$ flags=`';
    expectFormatException(() => VisualRange('01010'), err);
  });

  test('Test compliance with format, negative with qualifier', () {
    var err = 'Expected to find one match of `VisualRange` format in `RR101`, '
        'but found `0` using `RegExp: pattern=^[M|P]?\\d{4}\$ flags=`';
    expectFormatException(() => VisualRange('RR101'), err);
  });

  test('Test compliance with format, positive', () {
    expect(VisualRange('M1000'), isA<VisualRange>());
  });
}

void visualRangeDistance() {
  test('Test with no leading zero, no qualifier', () {
    expect(VisualRange('1000').distance, 1000);
  });

  test('Test with one leading zero, no qualifier', () {
    expect(VisualRange('0100').distance, 100);
  });

  test('Test with two leading zero, no qualifier', () {
    expect(VisualRange('0010').distance, 10);
  });

  test('Test with three leading zero, no qualifier', () {
    expect(VisualRange('0001').distance, 1);
  });

  test('Test with four leading zero, no qualifier', () {
    expect(VisualRange('0000').distance, 0);
  });

  test('Test with no leading zero, with qualifier', () {
    expect(VisualRange('P2000').distance, 2000);
  });

  test('Test with one leading zero, with qualifier', () {
    expect(VisualRange('P0200').distance, 200);
  });

  test('Test with two leading zero, with qualifier', () {
    expect(VisualRange('P0020').distance, 20);
  });

  test('Test with three leading zero, with qualifier', () {
    expect(VisualRange('P0002').distance, 2);
  });

  test('Test with four leading zero, with qualifier', () {
    expect(VisualRange('P0000').distance, 0);
  });
}

void visualRangeQualifier() {
  test('Test no match', () {
    expect(VisualRange('2000').qualifier, DistanceQualifier.none);
  });

  test('Test MINUS qualifier', () {
    expect(VisualRange('M1000').qualifier, DistanceQualifier.less);
  });

  test('Test PLUS qualifier', () {
    expect(VisualRange('P5000').qualifier, DistanceQualifier.more);
  });
}

void visualRangeEqualityOperator() {
  test('Test equality operator for non-equality, no approach', () {
    expect(VisualRange('0100') == VisualRange('0200'), false);
  });

  test('Test equality operator for non-equality, with approach', () {
    expect(VisualRange('M0100') == VisualRange('0100'), false);
  });

  test('Test equality operator for equality, no approach', () {
    expect(VisualRange('0100') == VisualRange('0100'), true);
  });

  test('Test equality operator for equality, with approach', () {
    expect(VisualRange('P0200') == VisualRange('P0200'), true);
  });
}

void visualRangeHashCode() {
  test('Test hash generation for non-equality, no approach', () {
    expect(VisualRange('0100').hashCode == VisualRange('0200').hashCode, false);
  });

  test('Test hash generation for non-equality, with approach', () {
    expect(
        VisualRange('M0100').hashCode == VisualRange('0100').hashCode, false);
  });

  test('Test hash generation for equality, no approach', () {
    expect(VisualRange('0100').hashCode == VisualRange('0100').hashCode, true);
  });

  test('Test hash generation for equality, with approach', () {
    expect(
        VisualRange('P0200').hashCode == VisualRange('P0200').hashCode, true);
  });
}

void visualRangeToString() {
  test('Test no leading zeros', () {
    expect(VisualRange('1000').toString(), '1000');
  });

  test('Test one leading zeros', () {
    expect(VisualRange('0100').toString(), '0100');
  });

  test('Test two leading zeros', () {
    expect(VisualRange('0010').toString(), '0010');
  });

  test('Test three leading zeros', () {
    expect(VisualRange('0001').toString(), '0001');
  });

  test('Test four leading zeros', () {
    expect(VisualRange('0000').toString(), '0000');
  });

  test('Test four leading zeros with PLUS modifier', () {
    expect(VisualRange('P0000').toString(), 'P0000');
  });

  test('Test no leading zeros with MINUS modifier', () {
    expect(VisualRange('M5555').toString(), 'M5555');
  });
}
