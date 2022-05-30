import 'package:awrep/src/common/distance_qualifier.dart';
import 'package:awrep/src/body/visibility.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Visibility', () {
    group('constructor', () {
      visibilityConstructor();
    });
    group('distance', () {
      visibilityDistance();
    });
    group('qualifier', () {
      visibilityQualifier();
    });
    group('toString', () {
      visibilityToString();
    });
    group('equalityOperator', () {
      visibilityEqualityOperator();
    });
    group('hashCode', () {
      visibilityHashCode();
    });
  });
}

void visibilityConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `Visibility` format in `100000SM`,'
        ' but found `0` using `RegExp: '
        'pattern=^([MP])?([0-9 \\/]{1,5})SM\$ flags=`';
    expectFormatException(() => Visibility('100000SM'), err);
  });

  test('Test compliance with format, negative with qualifier', () {
    var err = 'Expected to find one match of `Visibility` format in `MM1000SM`,'
        ' but found `0` using `RegExp: '
        'pattern=^([MP])?([0-9 \\/]{1,5})SM\$ flags=`';
    expectFormatException(() => Visibility('MM1000SM'), err);
  });

  test('Test compliance with format, positive', () {
    expect(Visibility('M1000SM'), isA<Visibility>());
  });
}

void visibilityDistance() {
  test('Test no match', () {
    var err = 'Either whole or fraction must be present in visibility section, '
        'neither field was found by RegEx '
        '`RegExp: pattern=^([MP]{1})?(?<whole>[0-9]{1,5})? ?'
        '((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM '
        'flags=` in report visibility section `100 0SM`';

    expect(() => Visibility('100 0SM').distance,
        throwsA(predicate((e) => e is FormatException && e.message == err)));
  });

  test('Test at least whole or fraction is provided', () {
    var err = 'Either whole or fraction must be present in visibility section, '
        'neither field was found by RegEx '
        '`RegExp: pattern=^([MP]{1})?(?<whole>[0-9]{1,5})? ?'
        '((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM '
        'flags=` in report visibility section `1/1/1SM`';

    expect(() => Visibility('1/1/1SM').distance,
        throwsA(predicate((e) => e is FormatException && e.message == err)));
  });

  test('Test less than grand visibility', () {
    expect(Visibility('M30000SM').distance, 30000);
  });

  test('Test grand visibility', () {
    expect(Visibility('30000SM').distance, 30000);
  });

  test('Test greater than grand visibility', () {
    expect(Visibility('P30000SM').distance, 30000);
  });

  test('Test less than common visibility', () {
    expect(Visibility('M6SM').distance, 6);
  });

  test('Test common visibility', () {
    expect(Visibility('6SM').distance, 6);
  });

  test('Test greater than common visibility', () {
    expect(Visibility('P6SM').distance, 6);
  });

  test('Test less than common fraction visibility', () {
    expect(Visibility('M1/2SM').distance, 1 / 2);
  });

  test('Test common fraction visibility', () {
    expect(Visibility('1/2SM').distance, 1 / 2);
  });

  test('Test greater common fraction grand visibility', () {
    expect(Visibility('P1/2SM').distance, 1 / 2);
  });

  test('Test less than small fraction visibility', () {
    expect(Visibility('M1/16SM').distance, 1 / 16);
  });

  test('Test small fraction visibility', () {
    expect(Visibility('1/16SM').distance, 1 / 16);
  });

  test('Test greater than small fraction visibility', () {
    expect(Visibility('P1/16SM').distance, 1 / 16);
  });

  test('Test less than mixed fraction visibility', () {
    expect(Visibility('M2 3/4SM').distance, 2 + 3 / 4);
  });

  test('Test mixed fraction visibility', () {
    expect(Visibility('2 3/4SM').distance, 2 + 3 / 4);
  });

  test('Test greater than mixed fraction visibility', () {
    expect(Visibility('P2 3/4SM').distance, 2 + 3 / 4);
  });
}

void visibilityQualifier() {
  test('Test less than grand visibility', () {
    expect(Visibility('M30000SM').qualifier, DistanceQualifier.less);
  });

  test('Test grand visibility', () {
    expect(Visibility('30000SM').qualifier, DistanceQualifier.none);
  });

  test('Test greater than grand visibility', () {
    expect(Visibility('P30000SM').qualifier, DistanceQualifier.more);
  });

  test('Test less than common visibility', () {
    expect(Visibility('M6SM').qualifier, DistanceQualifier.less);
  });

  test('Test common visibility', () {
    expect(Visibility('6SM').qualifier, DistanceQualifier.none);
  });

  test('Test greater than common visibility', () {
    expect(Visibility('P6SM').qualifier, DistanceQualifier.more);
  });

  test('Test less than common fraction visibility', () {
    expect(Visibility('M1/2SM').qualifier, DistanceQualifier.less);
  });

  test('Test common fraction visibility', () {
    expect(Visibility('1/2SM').qualifier, DistanceQualifier.none);
  });

  test('Test greater common fraction grand visibility', () {
    expect(Visibility('P1/2SM').qualifier, DistanceQualifier.more);
  });

  test('Test less than small fraction visibility', () {
    expect(Visibility('M1/16SM').qualifier, DistanceQualifier.less);
  });

  test('Test small fraction visibility', () {
    expect(Visibility('1/16SM').qualifier, DistanceQualifier.none);
  });

  test('Test greater than small fraction visibility', () {
    expect(Visibility('P1/16SM').qualifier, DistanceQualifier.more);
  });

  test('Test less than mixed fraction visibility', () {
    expect(Visibility('M2 3/4SM').qualifier, DistanceQualifier.less);
  });

  test('Test mixed fraction visibility', () {
    expect(Visibility('2 3/4SM').qualifier, DistanceQualifier.none);
  });

  test('Test greater than mixed fraction visibility', () {
    expect(Visibility('P2 3/4SM').qualifier, DistanceQualifier.more);
  });
}

void visibilityToString() {
  test('Test less than grand visibility', () {
    expect(Visibility('M30000SM').toString(), 'M30000SM');
  });

  test('Test grand visibility', () {
    expect(Visibility('30000SM').toString(), '30000SM');
  });

  test('Test greater than grand visibility', () {
    expect(Visibility('P30000SM').toString(), 'P30000SM');
  });

  test('Test less than common visibility', () {
    expect(Visibility('M6SM').toString(), 'M6SM');
  });

  test('Test common visibility', () {
    expect(Visibility('6SM').toString(), '6SM');
  });

  test('Test zero visibility', () {
    expect(Visibility('0SM').toString(), '0SM');
  });

  test('Test greater than common visibility', () {
    expect(Visibility('P6SM').toString(), 'P6SM');
  });

  test('Test less than common fraction visibility', () {
    expect(Visibility('M1/2SM').toString(), 'M1/2SM');
  });

  test('Test common fraction visibility', () {
    expect(Visibility('1/2SM').toString(), '1/2SM');
  });

  test('Test greater common fraction grand visibility', () {
    expect(Visibility('P1/2SM').toString(), 'P1/2SM');
  });

  test('Test less than small fraction visibility', () {
    expect(Visibility('M1/16SM').toString(), 'M1/16SM');
  });

  test('Test small fraction visibility', () {
    expect(Visibility('1/16SM').toString(), '1/16SM');
  });

  test('Test greater than small fraction visibility', () {
    expect(Visibility('P1/16SM').toString(), 'P1/16SM');
  });

  test('Test less than mixed fraction visibility', () {
    expect(Visibility('M2 3/4SM').toString(), 'M2 3/4SM');
  });

  test('Test mixed fraction visibility', () {
    expect(Visibility('2 3/4SM').toString(), '2 3/4SM');
  });

  test('Test greater than mixed fraction visibility', () {
    expect(Visibility('P2 3/4SM').toString(), 'P2 3/4SM');
  });
}

void visibilityEqualityOperator() {
  test('Test equality operator for non-equality, no qualifier', () {
    expect(Visibility('6SM') == Visibility('7SM'), false);
  });

  test('Test equality operator for non-equality, with qualifier', () {
    expect(Visibility('6SM') == Visibility('P6SM'), false);
  });

  test('Test equality operator for equality, no qualifier', () {
    expect(Visibility('6SM') == Visibility('6SM'), true);
  });

  test('Test equality operator for equality, with qualifier', () {
    expect(Visibility('M6SM') == Visibility('M6SM'), true);
  });
}

void visibilityHashCode() {
  test('Test hash generation for non-equality, no qualifier', () {
    expect(Visibility('6SM').hashCode == Visibility('7SM').hashCode, false);
  });

  test('Test hash generation for non-equality, with qualifier', () {
    expect(Visibility('6SM').hashCode == Visibility('P6SM').hashCode, false);
  });

  test('Test hash generation for equality, no qualifier', () {
    expect(Visibility('6SM').hashCode == Visibility('6SM').hashCode, true);
  });

  test('Test hash generation for equality, with qualifier', () {
    expect(Visibility('M6SM').hashCode == Visibility('M6SM').hashCode, true);
  });
}
