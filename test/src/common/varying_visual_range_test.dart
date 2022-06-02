import 'package:metar/src/common/distance_qualifier.dart';
import 'package:metar/src/common/varying_visual_range.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('VaryingVisualRange', () {
    group('constructor', () {
      varyingVisualRangeConstructor();
    });
    group('lowestDistance', () {
      varyingVisualRangeLowestDistance();
    });
    group('lowestQualifier', () {
      varyingVisualRangeLowestQualifier();
    });
    group('highestDistance', () {
      varyingVisualRangeHighestDistance();
    });
    group('highestQualifier', () {
      varyingVisualRangeHighestQualifier();
    });
    group('toString', () {
      varyingVisualRangeToString();
    });
    group('equalityOperator', () {
      varyingVisualRangeEqualityOperator();
    });
    group('hashCode', () {
      varyingVisualRangeHashCode();
    });
  });
}

void varyingVisualRangeConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`M01010`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(() => VaryingVisualRange('M01010'), err);
  });

  test('Test compliance with format, negative with qualifier', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`M1010VP10FT`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(() => VaryingVisualRange('M1010VP10FT'), err);
  });

  test('Test compliance with format, positive', () {
    expect(VaryingVisualRange('M1000VP2000FT'), isA<VaryingVisualRange>());
  });
}

void varyingVisualRangeLowestDistance() {
  test('Test with no leading zero, no qualifier', () {
    expect(VaryingVisualRange('1000V2000FT').lowestDistance, 1000);
  });

  test('Test with one leading zero, no qualifier', () {
    expect(VaryingVisualRange('0100V2000FT').lowestDistance, 100);
  });

  test('Test with two leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V2000FT').lowestDistance, 10);
  });

  test('Test with three leading zero, no qualifier', () {
    expect(VaryingVisualRange('0001V2000FT').lowestDistance, 1);
  });

  test('Test with four leading zero, no qualifier', () {
    expect(VaryingVisualRange('0000V2000FT').lowestDistance, 0);
  });

  test('Test with no leading zero, with qualifier', () {
    expect(VaryingVisualRange('M2000V2000FT').lowestDistance, 2000);
  });

  test('Test with one leading zero, with qualifier', () {
    expect(VaryingVisualRange('M0200V2000FT').lowestDistance, 200);
  });

  test('Test with two leading zero, with qualifier', () {
    expect(VaryingVisualRange('M0020V2000FT').lowestDistance, 20);
  });

  test('Test with three leading zero, with qualifier', () {
    expect(VaryingVisualRange('M0002V2000FT').lowestDistance, 2);
  });

  test('Test with four leading zero, with qualifier', () {
    expect(VaryingVisualRange('M0000V2000FT').lowestDistance, 0);
  });

  test('Test with four leading zero, unexpected qualifier', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`P0000V2000FT`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(
        () => VaryingVisualRange('P0000V2000FT').lowestDistance, err);
  });
}

void varyingVisualRangeLowestQualifier() {
  test('Test no match', () {
    expect(VaryingVisualRange('2000V2000FT').lowestQualifier,
        DistanceQualifier.none);
  });

  test('Test MINUS qualifier', () {
    expect(VaryingVisualRange('M1000V3000FT').lowestQualifier,
        DistanceQualifier.less);
  });

  test('Test PLUS qualifier', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`P5000V5000FT`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(
        () => VaryingVisualRange('P5000V5000FT').lowestQualifier, err);
  });
}

void varyingVisualRangeHighestDistance() {
  test('Test with no leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V1000FT').highestDistance, 1000);
  });

  test('Test with one leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V0100FT').highestDistance, 100);
  });

  test('Test with two leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V0010FT').highestDistance, 10);
  });

  test('Test with three leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V0001FT').highestDistance, 1);
  });

  test('Test with four leading zero, no qualifier', () {
    expect(VaryingVisualRange('0010V0000FT').highestDistance, 0);
  });

  test('Test with no leading zero, with qualifier', () {
    expect(VaryingVisualRange('0010VP2000FT').highestDistance, 2000);
  });

  test('Test with one leading zero, with qualifier', () {
    expect(VaryingVisualRange('0010VP0200FT').highestDistance, 200);
  });

  test('Test with two leading zero, with qualifier', () {
    expect(VaryingVisualRange('0010VP0020FT').highestDistance, 20);
  });

  test('Test with three leading zero, with qualifier', () {
    expect(VaryingVisualRange('0010VP0002FT').highestDistance, 2);
  });

  test('Test with four leading zero, with qualifier', () {
    expect(VaryingVisualRange('0010VP0000FT').highestDistance, 0);
  });

  test('Test with four leading zero, unexpected qualifier', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`0010VM0000FT`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(
        () => VaryingVisualRange('0010VM0000FT').highestDistance, err);
  });
}

void varyingVisualRangeHighestQualifier() {
  test('Test no match', () {
    expect(VaryingVisualRange('0010V2000FT').highestQualifier,
        DistanceQualifier.none);
  });

  test('Test MINUS qualifier', () {
    var err = 'Expected to find one match of `VaryingVisualRange` format in '
        '`0010VM1000FT`, but found `0` using '
        '`RegExp: pattern=^(M?(\\d{4})VP?(\\d{4}))FT\$ flags=`';
    expectFormatException(
        () => VaryingVisualRange('0010VM1000FT').highestQualifier, err);
  });

  test('Test PLUS qualifier', () {
    expect(VaryingVisualRange('0010VP5000FT').highestQualifier,
        DistanceQualifier.more);
  });
}

void varyingVisualRangeToString() {
  test('Test no leading zeros', () {
    expect(VaryingVisualRange('1000V2000FT').toString(), '1000V2000FT');
  });

  test('Test one leading zeros', () {
    expect(VaryingVisualRange('0100V0200FT').toString(), '0100V0200FT');
  });

  test('Test two leading zeros', () {
    expect(VaryingVisualRange('0010V0020FT').toString(), '0010V0020FT');
  });

  test('Test three leading zeros', () {
    expect(VaryingVisualRange('0001V0002FT').toString(), '0001V0002FT');
  });

  test('Test four leading zeros', () {
    expect(VaryingVisualRange('0000V0000FT').toString(), '0000V0000FT');
  });

  test('Test four leading zeros with PLUS modifier', () {
    expect(VaryingVisualRange('0000VP0000FT').toString(), '0000VP0000FT');
  });

  test('Test no leading zeros with MINUS modifier', () {
    expect(VaryingVisualRange('M5555V6666FT').toString(), 'M5555V6666FT');
  });
}

void varyingVisualRangeEqualityOperator() {
  test('Test equality operator for non-equality, no qualifier', () {
    expect(
        VaryingVisualRange('0100V1000FT') == VaryingVisualRange('0200V1000FT'),
        false);
  });

  test('Test equality operator for non-equality, with qualifier', () {
    expect(
        VaryingVisualRange('M0100V1000FT') == VaryingVisualRange('0100V1000FT'),
        false);
  });

  test('Test equality operator for equality, no qualifier', () {
    expect(
        VaryingVisualRange('0100V1000FT') == VaryingVisualRange('0100V1000FT'),
        true);
  });

  test('Test equality operator for non-equality, no qualifier', () {
    expect(
        VaryingVisualRange('0010V0100FT') == VaryingVisualRange('0010V0200FT'),
        false);
  });

  test('Test equality operator for equality, no qualifier', () {
    expect(
        VaryingVisualRange('0010V0100FT') == VaryingVisualRange('0010V0100FT'),
        true);
  });

  test('Test equality operator for equality, with qualifier', () {
    expect(
        VaryingVisualRange('0010VP0200FT') ==
            VaryingVisualRange('0010VP0200FT'),
        true);
  });
}

void varyingVisualRangeHashCode() {
  test('Test hash generation for non-equality, no qualifier', () {
    expect(
        VaryingVisualRange('0010V0100FT').hashCode ==
            VaryingVisualRange('0010V0200FT').hashCode,
        false);
  });

  test('Test hash generation for equality, no qualifier', () {
    expect(
        VaryingVisualRange('0010V0100FT').hashCode ==
            VaryingVisualRange('0010V0100FT').hashCode,
        true);
  });

  test('Test hash generation for equality, with qualifier', () {
    expect(
        VaryingVisualRange('0010VP0200FT').hashCode ==
            VaryingVisualRange('0010VP0200FT').hashCode,
        true);
  });
  test('Test hash generation for non-equality, no qualifier', () {
    expect(
        VaryingVisualRange('0100V1000FT').hashCode ==
            VaryingVisualRange('0200V1000FT').hashCode,
        false);
  });

  test('Test hash generation for non-equality, with qualifier', () {
    expect(
        VaryingVisualRange('M0100V1000FT').hashCode ==
            VaryingVisualRange('0100V1000FT').hashCode,
        false);
  });

  test('Test hash generation for equality, no qualifier', () {
    expect(
        VaryingVisualRange('0100V1000FT').hashCode ==
            VaryingVisualRange('0100V1000FT').hashCode,
        true);
  });
}
