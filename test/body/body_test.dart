import 'package:awrep/body/body.dart';
import 'package:awrep/body/report_date_time.dart';
import 'package:awrep/body/report_type.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    group('reportType', () {
      bodyReportType();
    });
    group('stationId', () {
      bodyStationId();
    });
    group('dateTime', () {
      bodyDateTime();
    });
    group('equalityOperator', () {
      bodyEqualityOperator();
    });
    group('hashCode', () {
      bodyHashCode();
    });
    group('toString', () {
      bodyToString();
    });
  });
}

void bodyReportType() {
  test('Test undefined report type exception is not caught', () {
    final String body = 'UNDEF KJFK 190351Z 18004KT BR OVC002 08/08 A3002';
    var msg = 'Unexpected report type value: `UNDEF `';
    var err = 'Invalid argument (name): No enum value with that name: "undef"';

    expect(
        () => Body(body).reportType,
        throwsA(predicate((e) =>
            e is ReportTypeException && e.message == '$msg, error: `$err`')));
  });

  test('Test no report type body', () {
    final body = 'KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.none);
  });

  test('Test metar report type body', () {
    final body = 'METAR KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.metar);
  });

  test('Test speci report type speci', () {
    final body = 'SPECI KJFK 190351Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.speci);
  });
}

void bodyStationId() {
  test('Test no station id', () {
    final body = '190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=^([^ ]{5} )?'
        '(?<station_id>[A-Za-z]{4} )(.*)\$ flags=` in report body '
        '`190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002`';

    expect(() => Body(body).stationId,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test too short station id', () {
    final body = 'KJ 190351Z 18004KT 1/4SM OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=^([^ ]{5} )?'
        '(?<station_id>[A-Za-z]{4} )(.*)\$ flags=` in report body '
        '`KJ 190351Z 18004KT 1/4SM OVC002 08/08 A3002`';

    expect(() => Body(body).stationId,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test too long station id', () {
    final body = 'KJFKK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=^([^ ]{5} )?'
        '(?<station_id>[A-Za-z]{4} )(.*)\$ flags=` in report body '
        '`KJFKK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).stationId,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test non-alphabetic station id', () {
    final body = 'K1JF 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=^([^ ]{5} )?'
        '(?<station_id>[A-Za-z]{4} )(.*)\$ flags=` in report body '
        '`K1JF 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).stationId,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test correct station id with report type', () {
    final body = 'SPECI KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).stationId, 'KJFK');
  });

  test('Test correct station id without report type', () {
    final body = 'KTEB 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).stationId, 'KTEB');
  });
}

void bodyDateTime() {
  test('Test no date and time specified', () {
    final body = 'KJFK 18004KT 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=(?<date_time>\\d{6}Z) '
        'flags=` in report body `KJFK 18004KT 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).dateTime,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test more than one date and time specified', () {
    final body = 'KJFK 120354Z 211355Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Too many matches were found by RegEx `RegExp: '
        'pattern=(?<date_time>\\d{6}Z) flags=` in report body '
        '`KJFK 120354Z 211355Z 18004KT 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).dateTime,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test correct date time specified', () {
    final body = 'KJFK 120354Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).dateTime, ReportDateTime('120354Z'));
  });
}

void bodyEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final body1 = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1) == Body(body2), false);
  });
  test('Test equality operator for equality', () {
    final body1 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1) == Body(body2), true);
  });
}

void bodyHashCode() {
  test('Test hash generation for non-equality', () {
    final body1 = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1).hashCode == Body(body2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final body1 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1).hashCode == Body(body2).hashCode, true);
  });
}

void bodyToString() {
  test('Test basic string output format', () {
    final body = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT '
        'BR OVC002 08/08 A3002';

    expect(Body(body).toString(), body);
  });
}
