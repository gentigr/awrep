import 'package:metar/src/body/runway_visual_range.dart';
import 'package:metar/src/common/runway.dart';
import 'package:metar/src/common/visual_range.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('RunwayVisualRange', () {
    group('constructor', () {
      runwayVisualRangeConstructor();
    });
    group('runway', () {
      runwayVisualRangeRunway();
    });
    group('visualRange', () {
      runwayVisualRangeVisualRange();
    });
    group('toString', () {
      runwayVisualRangeToString();
    });
    group('equalityOperator', () {
      runwayVisualRangeEqualityOperator();
    });
    group('hashCode', () {
      runwayVisualRangeHashCode();
    });
  });
}

void runwayVisualRangeConstructor() {
  test('Test compliance with format, negative (no visual range)', () {
    var err = 'Expected to find one match of `RunwayVisualRange` format in '
        '`R01/`, but found `0` using `RegExp: '
        'pattern=^R\\d{2}[LCR]?\\/[M|P]?\\d{4}(VP?\\d{4})?FT\$ flags=`';
    expectFormatException(() => RunwayVisualRange('R01/'), err);
  });

  test('Test compliance with format, negative (no runway)', () {
    var err = 'Expected to find one match of `RunwayVisualRange` format in '
        '`1000FT`, but found `0` using `RegExp: '
        'pattern=^R\\d{2}[LCR]?\\/[M|P]?\\d{4}(VP?\\d{4})?FT\$ flags=`';
    expectFormatException(() => RunwayVisualRange('1000FT'), err);
  });

  test('Test compliance with format, positive (stable)', () {
    expect(RunwayVisualRange('R10/M1000FT'), isA<RunwayVisualRange>());
  });

  test('Test compliance with format, positive (varying)', () {
    expect(RunwayVisualRange('R10/M1000V5000FT'), isA<RunwayVisualRange>());
  });
}

void runwayVisualRangeRunway() {
  test('Test without approach, stable range', () {
    expect(RunwayVisualRange('R04/1000FT').runway, Runway('04'));
  });

  test('Test with approach, stable range', () {
    expect(RunwayVisualRange('R10L/0100FT').runway, Runway('10L'));
  });

  test('Test without approach, varying range', () {
    expect(RunwayVisualRange('R04/1000V2000FT').runway, Runway('04'));
  });

  test('Test with approach, varying range', () {
    expect(RunwayVisualRange('R10L/0100V0200FT').runway, Runway('10L'));
  });
}

void runwayVisualRangeVisualRange() {
  test('Test stable with no qualifier', () {
    expect(RunwayVisualRange('R01/2000FT').visualRange, VisualRange('2000FT'));
  });

  test('Test stable with qualifier', () {
    expect(
        RunwayVisualRange('R01/M2000FT').visualRange, VisualRange('M2000FT'));
  });

  test('Test varying with no qualifier', () {
    expect(RunwayVisualRange('R01/2000V5000FT').visualRange,
        VisualRange('2000V5000FT'));
  });

  test('Test varying with qualifier less', () {
    expect(RunwayVisualRange('R01/M2000V3000FT').visualRange,
        VisualRange('M2000V3000FT'));
  });

  test('Test varying with qualifier more', () {
    expect(RunwayVisualRange('R01/2000VP3000FT').visualRange,
        VisualRange('2000VP3000FT'));
  });
}

void runwayVisualRangeToString() {
  test('Test stable with no approach and no qualifier', () {
    expect(RunwayVisualRange('R10/1000FT').toString(), 'R10/1000FT');
  });

  test('Test stable with with approach, qualifier, leading zeros', () {
    expect(RunwayVisualRange('R10C/M0100FT').toString(), 'R10C/M0100FT');
  });

  test('Test varying with with approach, qualifier, leading zeros', () {
    expect(
        RunwayVisualRange('R01L/0100VP0500FT').toString(), 'R01L/0100VP0500FT');
  });
}

void runwayVisualRangeEqualityOperator() {
  test('Test equality operator for non-equality, wrong range', () {
    expect(RunwayVisualRange('R10/0100FT') == RunwayVisualRange('R10/0200FT'),
        false);
  });

  test('Test equality operator for non-equality, wrong runway', () {
    expect(RunwayVisualRange('R10/0100FT') == RunwayVisualRange('R04/0100FT'),
        false);
  });

  test('Test equality operator for equality', () {
    expect(RunwayVisualRange('R10/0100FT') == RunwayVisualRange('R10/0100FT'),
        true);
  });
}

void runwayVisualRangeHashCode() {
  test('Test hash generation for non-equality, wrong range', () {
    expect(
        RunwayVisualRange('R10/0100FT').hashCode ==
            RunwayVisualRange('R10/0200FT').hashCode,
        false);
  });

  test('Test hash generation for non-equality, wrong runway', () {
    expect(
        RunwayVisualRange('R10/0100FT').hashCode ==
            RunwayVisualRange('R04/0100FT').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        RunwayVisualRange('R10/0100FT').hashCode ==
            RunwayVisualRange('R10/0100FT').hashCode,
        true);
  });
}

// R04R/2000V3000FT
// R04/2000FT
// R04L/2000FT
// R04C/2000FT
// R04R/2000FT
// R04/M2000FT
// R04/P2000FT
// R04/2000V3000FT
// R04/M2000V3000FT
// R04/M2000VP3000FT
// R10/0200FT
// R17C/M0100FT
//
//
// R04/0002FT
// R04/0020FT
// R04/0200FT
// R04/2000FT
// R04/5555FT
// R04/M0002FT
// R04/M0020FT
// R04/M0200FT
// R04/M2000FT
// R04/M5555FT
// R04/P0002FT
// R04/P0020FT
// R04/P0200FT
// R04/P2000FT
// R04/P5555FT
// R04/0002V0003FT
// R04/0020V0030FT
// R04/0200V0300FT
// R04/2000V3000FT
// R04/2222V3333FT
// R04/M0002V0003FT
// R04/M0020V0030FT
// R04/M0200V0300FT
// R04/M2000V3000FT
// R04/M2222V3333FT
// R04/0002VP0003FT
// R04/0020VP0030FT
// R04/0200VP0300FT
// R04/2000VP3000FT
// R04/2222VP3333FT
// R04/M0002VP0003FT
// R04/M0020VP0030FT
// R04/M0200VP0300FT
// R04/M2000VP3000FT
// R04/M2222VP3333FT
//
// R04L/0002FT
// R04L/0020FT
// R04L/0200FT
// R04L/2000FT
// R04L/5555FT
// R04L/M0002FT
// R04L/M0020FT
// R04L/M0200FT
// R04L/M2000FT
// R04L/M5555FT
// R04L/P0002FT
// R04L/P0020FT
// R04L/P0200FT
// R04L/P2000FT
// R04L/P5555FT
// R04L/0002V0003FT
// R04L/0020V0030FT
// R04L/0200V0300FT
// R04L/2000V3000FT
// R04L/2222V3333FT
// R04L/M0002V0003FT
// R04L/M0020V0030FT
// R04L/M0200V0300FT
// R04L/M2000V3000FT
// R04L/M2222V3333FT
// R04L/0002VP0003FT
// R04L/0020VP0030FT
// R04L/0200VP0300FT
// R04L/2000VP3000FT
// R04L/2222VP3333FT
// R04L/M0002VP0003FT
// R04L/M0020VP0030FT
// R04L/M0200VP0300FT
// R04L/M2000VP3000FT
// R04L/M2222VP3333FT
//
// R04C/0002FT
// R04C/0020FT
// R04C/0200FT
// R04C/2000FT
// R04C/5555FT
// R04C/M0002FT
// R04C/M0020FT
// R04C/M0200FT
// R04C/M2000FT
// R04C/M5555FT
// R04C/P0002FT
// R04C/P0020FT
// R04C/P0200FT
// R04C/P2000FT
// R04C/P5555FT
// R04C/0002V0003FT
// R04C/0020V0030FT
// R04C/0200V0300FT
// R04C/2000V3000FT
// R04C/2222V3333FT
// R04C/M0002V0003FT
// R04C/M0020V0030FT
// R04C/M0200V0300FT
// R04C/M2000V3000FT
// R04C/M2222V3333FT
// R04C/0002VP0003FT
// R04C/0020VP0030FT
// R04C/0200VP0300FT
// R04C/2000VP3000FT
// R04C/2222VP3333FT
// R04C/M0002VP0003FT
// R04C/M0020VP0030FT
// R04C/M0200VP0300FT
// R04C/M2000VP3000FT
// R04C/M2222VP3333FT
//
// R04R/0002FT
// R04R/0020FT
// R04R/0200FT
// R04R/2000FT
// R04R/5555FT
// R04R/M0002FT
// R04R/M0020FT
// R04R/M0200FT
// R04R/M2000FT
// R04R/M5555FT
// R04R/P0002FT
// R04R/P0020FT
// R04R/P0200FT
// R04R/P2000FT
// R04R/P5555FT
// R04R/0002V0003FT
// R04R/0020V0030FT
// R04R/0200V0300FT
// R04R/2000V3000FT
// R04R/2222V3333FT
// R04R/M0002V0003FT
// R04R/M0020V0030FT
// R04R/M0200V0300FT
// R04R/M2000V3000FT
// R04R/M2222V3333FT
// R04R/0002VP0003FT
// R04R/0020VP0030FT
// R04R/0200VP0300FT
// R04R/2000VP3000FT
// R04R/2222VP3333FT
// R04R/M0002VP0003FT
// R04R/M0020VP0030FT
// R04R/M0200VP0300FT
// R04R/M2000VP3000FT
// R04R/M2222VP3333FT
//
//
// R10/0002FT
// R10/0020FT
// R10/0200FT
// R10/2000FT
// R10/5555FT
// R10/M0002FT
// R10/M0020FT
// R10/M0200FT
// R04/M2000FT
// R04/M5555FT
// R04/P0002FT
// R04/P0020FT
// R04/P0200FT
// R04/P2000FT
// R04/P5555FT
// R04/0002V0003FT
// R04/0020V0030FT
// R04/0200V0300FT
// R04/2000V3000FT
// R04/2222V3333FT
// R04/M0002V0003FT
// R04/M0020V0030FT
// R04/M0200V0300FT
// R04/M2000V3000FT
// R04/M2222V3333FT
// R04/0002VP0003FT
// R04/0020VP0030FT
// R04/0200VP0300FT
// R04/2000VP3000FT
// R04/2222VP3333FT
// R04/M0002VP0003FT
// R04/M0020VP0030FT
// R04/M0200VP0300FT
// R04/M2000VP3000FT
// R04/M2222VP3333FT
