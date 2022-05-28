import 'package:awrep/body/report_distance_modifier.dart';
import 'package:test/test.dart';

void main() {
  group('ReportDistanceModifier', () {
    group('string', () {
      reportDistanceModifierString();
    });
    group('stringAsReportDistanceModifier', () {
      reportDistanceModifierStringAsReportDistanceModifier();
    });
  });
}

void reportDistanceModifierString() {
  test('Test string representation of non-present report distance modifier',
      () {
    expect(ReportDistanceModifier.none.string.isEmpty, true);
  });
  test('Test string representation of MINUS report distance modifier', () {
    expect(ReportDistanceModifier.less.string, 'M');
  });
  test('Test string representation of PLUS report distance modifier', () {
    expect(ReportDistanceModifier.greater.string, 'P');
  });
}

void reportDistanceModifierStringAsReportDistanceModifier() {
  test('Test constructor with empty string input', () {
    expect(stringAsReportDistanceModifier(''), ReportDistanceModifier.none);
  });
  test('Test constructor with null string input', () {
    expect(stringAsReportDistanceModifier(null), ReportDistanceModifier.none);
  });
  test('Test constructor with auto string input', () {
    expect(stringAsReportDistanceModifier('m'), ReportDistanceModifier.less);
  });
  test('Test constructor with cor string input', () {
    expect(stringAsReportDistanceModifier('p'), ReportDistanceModifier.greater);
  });
  test('Test constructor with random case string input', () {
    expect(stringAsReportDistanceModifier('M'), ReportDistanceModifier.less);
  });
  test('Test constructor with leading space string input', () {
    expect(
        stringAsReportDistanceModifier(' P'), ReportDistanceModifier.greater);
  });
  test('Test constructor with trailing space string input', () {
    expect(
        stringAsReportDistanceModifier('P '), ReportDistanceModifier.greater);
  });
  test('Test constructor with leading and trailing spaces string input', () {
    expect(stringAsReportDistanceModifier(' m '), ReportDistanceModifier.less);
  });
  test('Test constructor with unexpected input', () {
    var err = 'Unexpected report distance modifier value: `UNEXPECTED`';
    expect(
        () => stringAsReportDistanceModifier('UNEXPECTED'),
        throwsA(predicate(
            (e) => e is ReportDistanceModifierException && e.message == err)));
  });
}
