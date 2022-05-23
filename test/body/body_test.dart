import 'package:awrep/body/body.dart';
import 'package:awrep/body/report_date_time.dart';
import 'package:awrep/body/report_modifier.dart';
import 'package:awrep/body/report_type.dart';
import 'package:awrep/body/report_visibility.dart';
import 'package:awrep/body/report_wind.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    group('type', () {
      bodyType();
    });
    group('stationId', () {
      bodyStationId();
    });
    group('dateTime', () {
      bodyDateTime();
    });
    group('modifier', () {
      bodyModifier();
    });
    group('wind', () {
      bodyWind();
    });
    group('visibility', () {
      bodyVisibility();
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

void bodyType() {
  test('Test undefined report type exception is not caught', () {
    final String body = 'UNDEF KJFK 190351Z 18004KT BR OVC002 08/08 A3002';
    var msg = 'Unexpected report type value: `UNDEF `';
    var err = 'Invalid argument (name): No enum value with that name: "undef"';

    expect(
        () => Body(body).type,
        throwsA(predicate((e) =>
            e is ReportTypeException && e.message == '$msg, error: `$err`')));
  });

  test('Test no report type body', () {
    final body = 'KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).type, ReportType.none);
  });

  test('Test metar report type body', () {
    final body = 'METAR KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).type, ReportType.metar);
  });

  test('Test speci report type speci', () {
    final body = 'SPECI KJFK 190351Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).type, ReportType.speci);
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

void bodyModifier() {
  test('Test no report modifier', () {
    final body = 'KJFK 190351Z CCC 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).modifier, ReportModifier.none);
  });

  test('Test auto report modifier', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).modifier, ReportModifier.auto);
  });

  test('Test cor report modifier', () {
    final body = 'SPECI KJFK 190351Z COR 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).modifier, ReportModifier.cor);
  });

  test('Test more than one report modifier specified', () {
    final body = 'KJFK 120354Z COR 18004KT AUTO 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Too many matches were found by RegEx `RegExp: pattern= '
        '(?<modifier>AUTO|COR)  flags=` in report body `KJFK 120354Z COR '
        '18004KT AUTO 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).modifier,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });
}

void bodyWind() {
  test('Test no wind specified', () {
    final body = 'KJFK 101010Z 1/4SM BR OVC002 08/08 A3002';
    var msg = 'Failed to find RegEx `RegExp: pattern=(?<wind>(\\d{3}|VRB)'
        '\\d{2,3}(G\\d{2,3})?KT( \\d{3}V\\d{3})?) flags=` in report body '
        '`KJFK 101010Z 1/4SM BR OVC002 08/08 A3002`';

    expect(() => Body(body).wind,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test more than one wind specified', () {
    final body = 'KJFK 120354Z 15010KT 18004KT 1/4SM BR OVC002 A3002';
    var msg = 'Too many matches were found by RegEx `RegExp: pattern=(?<wind>'
        '(\\d{3}|VRB)\\d{2,3}(G\\d{2,3})?KT( \\d{3}V\\d{3})?) flags=` in '
        'report body `KJFK 120354Z 15010KT 18004KT 1/4SM BR OVC002 A3002`';

    expect(() => Body(body).wind,
        throwsA(predicate((e) => e is BodyException && e.message == msg)));
  });

  test('Test calm wind', () {
    final body = 'KJFK 190351Z COR 00000KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('00000KT'));
  });

  test('Test one-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 10008KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10008KT'));
  });

  test('Test two-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 10088KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10088KT'));
  });

  test('Test three-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 100888KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('100888KT'));
  });

  test('Test one-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 00205KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('00205KT'));
  });

  test('Test two-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 02005KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('02005KT'));
  });

  test('Test three-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 20005KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('20005KT'));
  });

  test('Test one-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G09KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10005G09KT'));
  });

  test('Test two-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G90KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10005G90KT'));
  });

  test('Test three-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G900KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10005G900KT'));
  });

  test('Test variable wind', () {
    final body = 'KJFK 190351Z COR 10005KT 070V130 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('10005KT 070V130'));
  });

  test('Test variable light wind', () {
    final body = 'KJFK 190351Z COR VRB06KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('VRB06KT'));
  });

  test('Test variable light wind, directions specified', () {
    final body = 'KJFK 190351Z COR VRB06KT 070V130 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, ReportWind('VRB06KT 070V130'));
  });

  test('Test variable gust wind', () {
    final body = 'KJFK 190351Z COR 03015G25KT 000V060 1/4SM OVC002 08/08';
    expect(Body(body).wind, ReportWind('03015G25KT 000V060'));
  });
}

void bodyVisibility() {
  test('Test no visibility specified', () {
    final body = '190351Z COR 18004KT R04R/2000V3000FT BR OVC002 08/08 A3002';
    var err = 'Failed to find RegEx `RegExp: pattern= '
        '(?<visibility>[0-9 /pPmM]{1,5}SM)  flags=` in report body '
        '`190351Z COR 18004KT R04R/2000V3000FT BR OVC002 08/08 A3002`';
    expect(() => Body(body).visibility,
        throwsA(predicate((e) => e is BodyException && e.message == err)));
  });

  test('Test zero visibility', () {
    final body =
        'KJFK 190351Z CCC 18004KT 0SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, ReportVisibility('0SM'));
  });

  test('Test fractional visibility', () {
    final body =
        'KJFK 190351Z 18004KT 1 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, ReportVisibility('1 1/4SM'));
  });

  test('Test grand visibility', () {
    final body =
        'METAR KJFK 190351Z AUTO 18004KT 30SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, ReportVisibility('30SM'));
  });

  test('Test plus visibility', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT P30SM BR OVC002 08/08 A3002';

    expect(Body(body).visibility, ReportVisibility('P30SM'));
  });

  test('Test minus visibility', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT M30SM BR OVC002 08/08 A3002';

    expect(Body(body).visibility, ReportVisibility('M30SM'));
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
