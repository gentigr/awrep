import 'package:awrep/body/report_type.dart';
import 'package:test/test.dart';

void main() {
  group('ReportType', () {
    group('string', () {
      reportTypeString();
    });
    group('stringAsReportType', () {
      reportTypeStringAsReportType();
    });
  });
}

void reportTypeString() {
  test('Test string representation of non-present report type', () {
    expect(ReportType.none.string.isEmpty, true);
  });
  test('Test string representation of METAR report type', () {
    expect(ReportType.metar.string, 'METAR');
  });
  test('Test string representation of SPECI report type', () {
    expect(ReportType.speci.string, 'SPECI');
  });
}

void reportTypeStringAsReportType() {
  test('Test constructor with empty string input', () {
    expect(stringAsReportType(''), ReportType.none);
  });
  test('Test constructor with null string input', () {
    expect(stringAsReportType(null), ReportType.none);
  });
  test('Test constructor with metar string input', () {
    expect(stringAsReportType('metar'), ReportType.metar);
  });
  test('Test constructor with speci string input', () {
    expect(stringAsReportType('speci'), ReportType.speci);
  });
  test('Test constructor with random case string input', () {
    expect(stringAsReportType('SpeCi'), ReportType.speci);
  });
  test('Test constructor with unexpected input', () {
    String message = 'Unexpected report type value: `UNEXPECTED`';
    String error =
        'Invalid argument (name): No enum value with that name: "unexpected"';
    expect(
        () => stringAsReportType('UNEXPECTED'),
        throwsA(predicate((e) =>
            e is ReportTypeException &&
            e.message == '$message, error: `$error`')));
  });
}
