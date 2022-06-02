import 'package:metar/src/body/date_time.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('DateTime', () {
    group('constructor', () {
      dateTimeConstructor();
    });
    group('day', () {
      dateTimeDay();
    });
    group('hour', () {
      dateTimeHour();
    });
    group('minute', () {
      dateTimeMinute();
    });
    group('toString', () {
      dateTimeToString();
    });
    group('equalityOperator', () {
      dateTimeEqualityOperator();
    });
    group('hashCode', () {
      dateTimeHashCode();
    });
  });
}

void dateTimeConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `DateTime` format in `010115`, '
        'but found `0` using `RegExp: pattern=^\\d{6}Z\$ flags=`';
    expectFormatException(() => DateTime('010115'), err);
  });

  test('Test compliance with format, negative with direction', () {
    var err = 'Expected to find one match of `DateTime` format in `0101RRZ`, '
        'but found `0` using `RegExp: pattern=^\\d{6}Z\$ flags=`';
    expectFormatException(() => DateTime('0101RRZ'), err);
  });

  test('Test compliance with format, positive', () {
    expect(DateTime('020202Z'), isA<DateTime>());
  });
}

void dateTimeDay() {
  test('Test lower boundary', () {
    var err = 'Report day value must be within [1; 31] range, provided: `0` '
        'from `000101Z`';
    expectFormatException(() => DateTime('000101Z').day, err);
  });

  test('Test upper boundary', () {
    var err = 'Report day value must be within [1; 31] range, provided: `32` '
        'from `320101Z`';
    expectFormatException(() => DateTime('320101Z').day, err);
  });

  test('Test successful case', () {
    expect(DateTime('110101Z').day, 11);
  });
}

void dateTimeHour() {
  test('Test upper boundary', () {
    var err = 'Report hour value must be within [0; 23] range, provided: `24` '
        'from `312401Z`';
    expectFormatException(() => DateTime('312401Z').hour, err);
  });

  test('Test successful case', () {
    expect(DateTime('101101Z').hour, 11);
  });
}

void dateTimeMinute() {
  test('Test upper boundary', () {
    var err = 'Report minute value must be within [0; 59] range, provided: `60`'
        ' from `310160Z`';
    expectFormatException(() => DateTime('310160Z').minute, err);
  });

  test('Test successful case', () {
    expect(DateTime('100111Z').minute, 11);
  });
}

void dateTimeEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final td1 = '010203Z';
    final td2 = '010204Z';

    expect(DateTime(td1) == DateTime(td2), false);
  });
  test('Test equality operator for equality', () {
    final td1 = '020304Z';
    final td2 = '020304Z';

    expect(DateTime(td1) == DateTime(td2), true);
  });
}

void dateTimeHashCode() {
  test('Test hash generation for non-equality', () {
    final td1 = '010203Z';
    final td2 = '010204Z';

    expect(DateTime(td1).hashCode == DateTime(td2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final td1 = '020304Z';
    final td2 = '020304Z';

    expect(DateTime(td1).hashCode == DateTime(td2).hashCode, true);
  });
}

void dateTimeToString() {
  test('Test basic string output format, day leading zeros', () {
    final timedate = '011213Z';

    expect(DateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, hour leading zeros', () {
    final timedate = '110213Z';

    expect(DateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, minute leading zeros', () {
    final timedate = '111203Z';

    expect(DateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, all leading zeros', () {
    final timedate = '010203Z';

    expect(DateTime(timedate).toString(), timedate);
  });

  test('Test basic string output format, no leading zeros', () {
    final timedate = '112233Z';

    expect(DateTime(timedate).toString(), timedate);
  });
}
