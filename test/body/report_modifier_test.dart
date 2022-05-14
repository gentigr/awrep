import 'package:awrep/body/report_modifier.dart';
import 'package:test/test.dart';

void main() {
  group('ReportModifier', () {
    group('string', () {
      reportModifierString();
    });
    group('stringAsReportModifier', () {
      reportModifierStringAsReportModifier();
    });
  });
}

void reportModifierString() {
  test('Test string representation of non-present report modifier', () {
    expect(ReportModifier.none.string.isEmpty, true);
  });
  test('Test string representation of AUTO report modifier', () {
    expect(ReportModifier.auto.string, 'AUTO');
  });
  test('Test string representation of COR report modifier', () {
    expect(ReportModifier.cor.string, 'COR');
  });
}

void reportModifierStringAsReportModifier() {
  test('Test constructor with empty string input', () {
    expect(stringAsReportModifier(''), ReportModifier.none);
  });
  test('Test constructor with null string input', () {
    expect(stringAsReportModifier(null), ReportModifier.none);
  });
  test('Test constructor with auto string input', () {
    expect(stringAsReportModifier('auto'), ReportModifier.auto);
  });
  test('Test constructor with cor string input', () {
    expect(stringAsReportModifier('cor'), ReportModifier.cor);
  });
  test('Test constructor with random case string input', () {
    expect(stringAsReportModifier('CoR'), ReportModifier.cor);
  });
  test('Test constructor with leading space string input', () {
    expect(stringAsReportModifier(' cor'), ReportModifier.cor);
  });
  test('Test constructor with trailing space string input', () {
    expect(stringAsReportModifier('cor '), ReportModifier.cor);
  });
  test('Test constructor with leading and trailing spaces string input', () {
    expect(stringAsReportModifier(' auto '), ReportModifier.auto);
  });
  test('Test constructor with unexpected input', () {
    var err = 'Unexpected report modifier value: `UNEXPECTED`, error: '
        '`Invalid argument (name): No enum value with that name: "unexpected"`';
    expect(
        () => stringAsReportModifier('UNEXPECTED'),
        throwsA(predicate(
            (e) => e is ReportModifierException && e.message == err)));
  });
}
