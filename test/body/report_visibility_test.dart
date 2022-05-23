import 'package:awrep/body/report_distance_modifier.dart';
import 'package:awrep/body/report_visibility.dart';
import 'package:awrep/body/report_wind.dart';
import 'package:test/test.dart';

void main() {
  group('ReportVisibility', () {
    group('distance', () {
      reportVisibilityDistance();
    });
    group('modifier', () {
      reportVisibilityModifier();
    });
    group('equalityOperator', () {
      reportVisibilityEqualityOperator();
    });
    group('hashCode', () {
      reportVisibilityHashCode();
    });
    group('toString', () {
      reportVisibilityToString();
    });
  });
}

void reportVisibilityDistance() {
  test('Test no match', () {
    var err = 'Failed to find RegEx `RegExp: pattern=^([mMpP])?'
        '(?<whole>[0-9]{1,5})? ?((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM '
        'flags=` in report visibility section `S`';

    expect(
        () => ReportVisibility('S').distance,
        throwsA(predicate(
            (e) => e is ReportVisibilityException && e.message == err)));
  });

  test('Test at least whole or fraction is provided', () {
    var err = 'Either whole or fraction must be present in visibility section, '
        'neither field was found by RegEx `RegExp: '
        'pattern=^([mMpP])?(?<whole>[0-9]{1,5})? ?'
        '((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM '
        'flags=` in report visibility section `SM`';

    expect(
        () => ReportVisibility('SM').distance,
        throwsA(predicate(
            (e) => e is ReportVisibilityException && e.message == err)));
  });

  test('Test less than grand visibility', () {
    expect(ReportVisibility('M30000SM').distance, 30000);
  });

  test('Test grand visibility', () {
    expect(ReportVisibility('30000SM').distance, 30000);
  });

  test('Test greater than grand visibility', () {
    expect(ReportVisibility('P30000SM').distance, 30000);
  });

  test('Test less than common visibility', () {
    expect(ReportVisibility('M6SM').distance, 6);
  });

  test('Test common visibility', () {
    expect(ReportVisibility('6SM').distance, 6);
  });

  test('Test greater than common visibility', () {
    expect(ReportVisibility('P6SM').distance, 6);
  });

  test('Test less than common fraction visibility', () {
    expect(ReportVisibility('M1/2SM').distance, 1 / 2);
  });

  test('Test common fraction visibility', () {
    expect(ReportVisibility('1/2SM').distance, 1 / 2);
  });

  test('Test greater common fraction grand visibility', () {
    expect(ReportVisibility('P1/2SM').distance, 1 / 2);
  });

  test('Test less than small fraction visibility', () {
    expect(ReportVisibility('M1/16SM').distance, 1 / 16);
  });

  test('Test small fraction visibility', () {
    expect(ReportVisibility('1/16SM').distance, 1 / 16);
  });

  test('Test greater than small fraction visibility', () {
    expect(ReportVisibility('P1/16SM').distance, 1 / 16);
  });

  test('Test less than mixed fraction visibility', () {
    expect(ReportVisibility('M2 3/4SM').distance, 2 + 3 / 4);
  });

  test('Test mixed fraction visibility', () {
    expect(ReportVisibility('2 3/4SM').distance, 2 + 3 / 4);
  });

  test('Test greater than mixed fraction visibility', () {
    expect(ReportVisibility('P2 3/4SM').distance, 2 + 3 / 4);
  });
}

void reportVisibilityModifier() {
  test('Test no match', () {
    expect(ReportVisibility('S').modifier, ReportDistanceModifier.none);
  });

  test('Test less than grand visibility', () {
    expect(ReportVisibility('M30000SM').modifier, ReportDistanceModifier.less);
  });

  test('Test grand visibility', () {
    expect(ReportVisibility('30000SM').modifier, ReportDistanceModifier.none);
  });

  test('Test greater than grand visibility', () {
    expect(
        ReportVisibility('P30000SM').modifier, ReportDistanceModifier.greater);
  });

  test('Test less than common visibility', () {
    expect(ReportVisibility('M6SM').modifier, ReportDistanceModifier.less);
  });

  test('Test common visibility', () {
    expect(ReportVisibility('6SM').modifier, ReportDistanceModifier.none);
  });

  test('Test greater than common visibility', () {
    expect(ReportVisibility('P6SM').modifier, ReportDistanceModifier.greater);
  });

  test('Test less than common fraction visibility', () {
    expect(ReportVisibility('M1/2SM').modifier, ReportDistanceModifier.less);
  });

  test('Test common fraction visibility', () {
    expect(ReportVisibility('1/2SM').modifier, ReportDistanceModifier.none);
  });

  test('Test greater common fraction grand visibility', () {
    expect(ReportVisibility('P1/2SM').modifier, ReportDistanceModifier.greater);
  });

  test('Test less than small fraction visibility', () {
    expect(ReportVisibility('M1/16SM').modifier, ReportDistanceModifier.less);
  });

  test('Test small fraction visibility', () {
    expect(ReportVisibility('1/16SM').modifier, ReportDistanceModifier.none);
  });

  test('Test greater than small fraction visibility', () {
    expect(
        ReportVisibility('P1/16SM').modifier, ReportDistanceModifier.greater);
  });

  test('Test less than mixed fraction visibility', () {
    expect(ReportVisibility('M2 3/4SM').modifier, ReportDistanceModifier.less);
  });

  test('Test mixed fraction visibility', () {
    expect(ReportVisibility('2 3/4SM').modifier, ReportDistanceModifier.none);
  });

  test('Test greater than mixed fraction visibility', () {
    expect(
        ReportVisibility('P2 3/4SM').modifier, ReportDistanceModifier.greater);
  });
}

void reportVisibilityEqualityOperator() {
  test('Test equality operator for non-equality, no modifier', () {
    expect(ReportVisibility('6SM') == ReportVisibility('7SM'), false);
  });

  test('Test equality operator for non-equality, with modifier', () {
    expect(ReportVisibility('6SM') == ReportVisibility('P6SM'), false);
  });

  test('Test equality operator for equality, no modifier', () {
    expect(ReportVisibility('6SM') == ReportVisibility('6SM'), true);
  });

  test('Test equality operator for equality, with modifier', () {
    expect(ReportVisibility('M6SM') == ReportVisibility('M6SM'), true);
  });
}

void reportVisibilityHashCode() {
  test('Test hash generation for non-equality, no modifier', () {
    expect(ReportVisibility('6SM').hashCode == ReportVisibility('7SM').hashCode,
        false);
  });

  test('Test hash generation for non-equality, with modifier', () {
    expect(
        ReportVisibility('6SM').hashCode == ReportVisibility('P6SM').hashCode,
        false);
  });

  test('Test hash generation for equality, no modifier', () {
    expect(ReportVisibility('6SM').hashCode == ReportVisibility('6SM').hashCode,
        true);
  });

  test('Test hash generation for equality, with modifier', () {
    expect(
        ReportVisibility('M6SM').hashCode == ReportVisibility('M6SM').hashCode,
        true);
  });
}

void reportVisibilityToString() {
  test('Test less than grand visibility', () {
    expect(ReportVisibility('M30000SM').toString(), 'M30000SM');
  });

  test('Test grand visibility', () {
    expect(ReportVisibility('30000SM').toString(), '30000SM');
  });

  test('Test greater than grand visibility', () {
    expect(ReportVisibility('P30000SM').toString(), 'P30000SM');
  });

  test('Test less than common visibility', () {
    expect(ReportVisibility('M6SM').toString(), 'M6SM');
  });

  test('Test common visibility', () {
    expect(ReportVisibility('6SM').toString(), '6SM');
  });

  test('Test greater than common visibility', () {
    expect(ReportVisibility('P6SM').toString(), 'P6SM');
  });

  test('Test less than common fraction visibility', () {
    expect(ReportVisibility('M1/2SM').toString(), 'M1/2SM');
  });

  test('Test common fraction visibility', () {
    expect(ReportVisibility('1/2SM').toString(), '1/2SM');
  });

  test('Test greater common fraction grand visibility', () {
    expect(ReportVisibility('P1/2SM').toString(), 'P1/2SM');
  });

  test('Test less than small fraction visibility', () {
    expect(ReportVisibility('M1/16SM').toString(), 'M1/16SM');
  });

  test('Test small fraction visibility', () {
    expect(ReportVisibility('1/16SM').toString(), '1/16SM');
  });

  test('Test greater than small fraction visibility', () {
    expect(ReportVisibility('P1/16SM').toString(), 'P1/16SM');
  });

  test('Test less than mixed fraction visibility', () {
    expect(ReportVisibility('M2 3/4SM').toString(), 'M2 3/4SM');
  });

  test('Test mixed fraction visibility', () {
    expect(ReportVisibility('2 3/4SM').toString(), '2 3/4SM');
  });

  test('Test greater than mixed fraction visibility', () {
    expect(ReportVisibility('P2 3/4SM').toString(), 'P2 3/4SM');
  });
}
