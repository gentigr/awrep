import 'package:awrep/body/report_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('ReportDateTime', () {
    group('day', () {
      reportDateTimeDay();
    });
    group('hour', () {
      reportDateTimeHour();
    });
    group('minute', () {
      reportDateTimeMinute();
    });
    group('equalityOperator', () {
      reportDateTimeEqualityOperator();
    });
    group('hashCode', () {
      reportDateTimeHashCode();
    });
    group('toString', () {
      reportDateTimeToString();
    });
  });
}

void reportDateTimeDay() {
  test('Test longer date and time provided', () {
    var err = 'Report datetime must have length equal to 7, '
        'provided: `010101Za`';
    expect(
        () => ReportDateTime('010101Za').day,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test wrongly formatted date and time', () {
    var err = 'Report datetime must be in Zulu format (ends with `Z` symbol), '
        'provided: `010101R`';
    expect(
        () => ReportDateTime('010101R').day,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test non-digit symbol instead of digit provided', () {
    var err = 'Could not parse report day part `0r` of `0r0101Z`, '
        'error: `FormatException: Invalid radix-10 number '
        '(at character 1)\n0r\n^\n`';
    expect(
        () => ReportDateTime('0r0101Z').day,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test lower boundary', () {
    var err = 'Report day value must be within [1; 31] range, provided: `0` '
        'from `000101Z`';
    expect(
        () => ReportDateTime('000101Z').day,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test upper boundary', () {
    var err = 'Report day value must be within [1; 31] range, provided: `32` '
        'from `320101Z`';
    expect(
        () => ReportDateTime('320101Z').day,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test successful case', () {
    expect(ReportDateTime('110101Z').day, 11);
  });
}

void reportDateTimeHour() {
  test('Test longer date and time provided', () {
    var err = 'Report datetime must have length equal to 7, '
        'provided: `010101Za`';
    expect(
        () => ReportDateTime('010101Za').hour,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test wrongly formatted date and time', () {
    var err = 'Report datetime must be in Zulu format (ends with `Z` symbol), '
        'provided: `010101R`';
    expect(
        () => ReportDateTime('010101R').hour,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test non-digit symbol instead of digit provided', () {
    var err = 'Could not parse report hour part `0r` of `010r01Z`, '
        'error: `FormatException: Invalid radix-10 number '
        '(at character 1)\n0r\n^\n`';
    expect(
        () => ReportDateTime('010r01Z').hour,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test upper boundary', () {
    var err = 'Report hour value must be within [0; 23] range, provided: `24` '
        'from `312401Z`';
    expect(
        () => ReportDateTime('312401Z').hour,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test successful case', () {
    expect(ReportDateTime('101101Z').hour, 11);
  });
}

void reportDateTimeMinute() {
  test('Test longer date and time provided', () {
    var err = 'Report datetime must have length equal to 7, '
        'provided: `010101Za`';
    expect(
        () => ReportDateTime('010101Za').minute,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test wrongly formatted date and time', () {
    var err = 'Report datetime must be in Zulu format (ends with `Z` symbol), '
        'provided: `010101R`';
    expect(
        () => ReportDateTime('010101R').minute,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test non-digit symbol instead of digit provided', () {
    var err = 'Could not parse report minute part `0r` of `01010rZ`, '
        'error: `FormatException: Invalid radix-10 number '
        '(at character 1)\n0r\n^\n`';
    expect(
        () => ReportDateTime('01010rZ').minute,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test upper boundary', () {
    var err = 'Report minute value must be within [0; 59] range, provided: `60`'
        ' from `310160Z`';
    expect(
        () => ReportDateTime('310160Z').minute,
        throwsA(predicate(
            (e) => e is ReportDateTimeException && e.message == err)));
  });

  test('Test successful case', () {
    expect(ReportDateTime('100111Z').minute, 11);
  });
}

void reportDateTimeEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final td1 = '010203Z';
    final td2 = '010204Z';

    expect(ReportDateTime(td1) == ReportDateTime(td2), false);
  });
  test('Test equality operator for equality', () {
    final td1 = '020304Z';
    final td2 = '020304Z';

    expect(ReportDateTime(td1) == ReportDateTime(td2), true);
  });
}

void reportDateTimeHashCode() {
  test('Test hash generation for non-equality', () {
    final td1 = '010203Z';
    final td2 = '010204Z';

    expect(ReportDateTime(td1).hashCode == ReportDateTime(td2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final td1 = '020304Z';
    final td2 = '020304Z';

    expect(ReportDateTime(td1).hashCode == ReportDateTime(td2).hashCode, true);
  });
}

void reportDateTimeToString() {
  test('Test basic string output format, day leading zeros', () {
    final timedate = '011213Z';

    expect(ReportDateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, hour leading zeros', () {
    final timedate = '110213Z';

    expect(ReportDateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, minute leading zeros', () {
    final timedate = '111203Z';

    expect(ReportDateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, all leading zeros', () {
    final timedate = '010203Z';

    expect(ReportDateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, no leading zeros', () {
    final timedate = '112233Z';

    expect(ReportDateTime(timedate).toString(), timedate);
  });
}
