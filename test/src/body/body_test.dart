import 'package:metar/src/body/body.dart';
import 'package:metar/src/body/date_time.dart';
import 'package:metar/src/body/modifier.dart';
import 'package:metar/src/body/present_weather_group/present_weather_group.dart';
import 'package:metar/src/body/runway_visual_range.dart';
import 'package:metar/src/body/sky_condition_group/sky_condition_group.dart';
import 'package:metar/src/body/type.dart';
import 'package:metar/src/body/visibility.dart';
import 'package:metar/src/body/wind.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

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
    group('runwayVisualRanges', () {
      bodyRunwayVisualRanges();
    });
    group('presentWeatherGroups', () {
      bodyPresentWeatherGroups();
    });
    group('skyConditionGroups', () {
      bodySkyConditionGroups();
    });
    group('toString', () {
      bodyToString();
    });
    group('equalityOperator', () {
      bodyEqualityOperator();
    });
    group('hashCode', () {
      bodyHashCode();
    });
  });
}

void bodyType() {
  test('Test undefined report type exception is not caught', () {
    final String body = 'UNDEF KJFK 190351Z 18004KT BR OVC002 08/08 A3002';
    expectFormatExceptionType(() => Body(body).type);
  });

  test('Test no report type body', () {
    final body = 'KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).type, Type.none);
  });

  test('Test metar report type body', () {
    final body = 'METAR KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).type, Type.metar);
  });

  test('Test speci report type speci', () {
    final body = 'SPECI KJFK 190351Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).type, Type.speci);
  });
}

void bodyStationId() {
  test('Test no station id', () {
    final body = '190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `station_id` format in '
        '`190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002`, '
        'but found `0` using '
        '`RegExp: pattern=^([^ ]{5} )?(?<station_id>[A-Za-z]{4} ) flags=`';

    expectFormatException(() => Body(body).stationId, err);
  });

  test('Test too short station id', () {
    final body = 'KJ 190351Z 18004KT 1/4SM OVC002 08/08 A3002';
    var err = 'Expected to find one match of `station_id` format in '
        '`KJ 190351Z 18004KT 1/4SM OVC002 08/08 A3002`, but found `0` using '
        '`RegExp: pattern=^([^ ]{5} )?(?<station_id>[A-Za-z]{4} ) flags=`';

    expectFormatException(() => Body(body).stationId, err);
  });

  test('Test too long station id', () {
    final body = 'KJFKK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `station_id` format in `KJFKK '
        '190351Z 18004KT 1/4SM BR OVC002 08/08 A3002`, but found `0` using '
        '`RegExp: pattern=^([^ ]{5} )?(?<station_id>[A-Za-z]{4} ) flags=`';

    expectFormatException(() => Body(body).stationId, err);
  });

  test('Test non-alphabetic station id', () {
    final body = 'K1JF 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `station_id` format in `K1JF '
        '190351Z 18004KT 1/4SM BR OVC002 08/08 A3002`, but found `0` using '
        '`RegExp: pattern=^([^ ]{5} )?(?<station_id>[A-Za-z]{4} ) flags=`';

    expectFormatException(() => Body(body).stationId, err);
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
    var err = 'Expected to find one match of `date_time` format in '
        '`KJFK 18004KT 1/4SM BR OVC002 08/08 A3002`, but found `0` using '
        '`RegExp: pattern=(?<date_time>\\d{6}Z) flags=`';

    expectFormatException(() => Body(body).dateTime, err);
  });

  test('Test more than one date and time specified', () {
    final body = 'KJFK 120354Z 211355Z 18004KT 1/4SM BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `date_time` format in `KJFK '
        '120354Z 211355Z 18004KT 1/4SM BR OVC002 08/08 A3002`, but found `2` '
        'using `RegExp: pattern=(?<date_time>\\d{6}Z) flags=`';

    expectFormatException(() => Body(body).dateTime, err);
  });

  test('Test correct date time specified', () {
    final body = 'KJFK 120354Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).dateTime, DateTime('120354Z'));
  });
}

void bodyModifier() {
  test('Test no report modifier', () {
    final body = 'KJFK 190351Z CCC 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).modifier, Modifier.none);
  });

  test('Test auto report modifier', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).modifier, Modifier.auto);
  });

  test('Test cor report modifier', () {
    final body = 'SPECI KJFK 190351Z COR 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).modifier, Modifier.cor);
  });

  test('Test more than one report modifier specified', () {
    final body = 'KJFK 120354Z COR 18004KT AUTO 1/4SM BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `modifier` format in '
        '`KJFK 120354Z COR 18004KT AUTO 1/4SM BR OVC002 08/08 A3002`, '
        'but found `2` using `RegExp: pattern= (?<modifier>AUTO|COR)  flags=`';

    expectFormatException(() => Body(body).modifier, err);
  });
}

void bodyWind() {
  test('Test no wind specified', () {
    final body = 'KJFK 101010Z 1/4SM BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `wind` format in '
        '`KJFK 101010Z 1/4SM BR OVC002 08/08 A3002`, but found `0` using '
        '`RegExp: pattern=(?<wind>(\\d{3}|VRB)\\d{2,3}(G\\d{2,3})?KT'
        '( \\d{3}V\\d{3})?) flags=`';

    expectFormatException(() => Body(body).wind, err);
  });

  test('Test more than one wind specified', () {
    final body = 'KJFK 120354Z 15010KT 18004KT 1/4SM BR OVC002 A3002';
    var err = 'Expected to find one match of `wind` format in '
        '`KJFK 120354Z 15010KT 18004KT 1/4SM BR OVC002 A3002`, but found `2` '
        'using `RegExp: pattern=(?<wind>(\\d{3}|VRB)\\d{2,3}(G\\d{2,3})?KT'
        '( \\d{3}V\\d{3})?) flags=`';

    expectFormatException(() => Body(body).wind, err);
  });

  test('Test calm wind', () {
    final body = 'KJFK 190351Z COR 00000KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('00000KT'));
  });

  test('Test one-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 10008KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10008KT'));
  });

  test('Test two-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 10088KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10088KT'));
  });

  test('Test three-symbol velocity wind', () {
    final body = 'KJFK 190351Z COR 100888KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('100888KT'));
  });

  test('Test one-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 00205KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('00205KT'));
  });

  test('Test two-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 02005KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('02005KT'));
  });

  test('Test three-symbol direction wind', () {
    final body = 'KJFK 190351Z COR 20005KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('20005KT'));
  });

  test('Test one-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G09KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10005G09KT'));
  });

  test('Test two-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G90KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10005G90KT'));
  });

  test('Test three-symbol gust wind', () {
    final body = 'KJFK 190351Z COR 10005G900KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10005G900KT'));
  });

  test('Test variable wind', () {
    final body = 'KJFK 190351Z COR 10005KT 070V130 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('10005KT 070V130'));
  });

  test('Test variable light wind', () {
    final body = 'KJFK 190351Z COR VRB06KT 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('VRB06KT'));
  });

  test('Test variable light wind, directions specified', () {
    final body = 'KJFK 190351Z COR VRB06KT 070V130 1/4SM BR OVC002 08/08 A3002';
    expect(Body(body).wind, Wind('VRB06KT 070V130'));
  });

  test('Test variable gust wind', () {
    final body = 'KJFK 190351Z COR 03015G25KT 000V060 1/4SM OVC002 08/08';
    expect(Body(body).wind, Wind('03015G25KT 000V060'));
  });
}

void bodyVisibility() {
  test('Test no visibility specified', () {
    final body = '190351Z COR 18004KT R04R/2000V3000FT BR OVC002 08/08 A3002';
    var err = 'Expected to find one match of `visibility` format in `190351Z '
        'COR 18004KT R04R/2000V3000FT BR OVC002 08/08 A3002`, but found `0` '
        'using `RegExp: pattern= (?<visibility>[0-9 /PM]{1,5}SM)  flags=`';
    expectFormatException(() => Body(body).visibility, err);
  });

  test('Test zero visibility', () {
    final body =
        'KJFK 190351Z CCC 18004KT 0SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, Visibility('0SM'));
  });

  test('Test fractional visibility', () {
    final body =
        'KJFK 190351Z 18004KT 1 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, Visibility('1 1/4SM'));
  });

  test('Test grand visibility', () {
    final body =
        'METAR KJFK 190351Z AUTO 18004KT 30SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, Visibility('30SM'));
  });

  test('Test plus visibility', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT P30SM BR OVC002 08/08 A3002';

    expect(Body(body).visibility, Visibility('P30SM'));
  });

  test('Test minus visibility', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT M30SM BR OVC002 08/08 A3002';

    expect(Body(body).visibility, Visibility('M30SM'));
  });
}

void bodyRunwayVisualRanges() {
  test('Test no runway visual range', () {
    final body = 'KJFK 190351Z 18004KT 10SM BR OVC002 08/08 A3002';

    expect(Body(body).runwayVisualRanges, List.empty());
  });

  test('Test standard runway visual range', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT BR OVC002 08/08 A3002';

    RunwayVisualRange range = RunwayVisualRange('R04/2000FT');
    List<RunwayVisualRange> ranges = [range];
    expect(Body(body).runwayVisualRanges, ranges);
  });

  test('Test standard runway visual range - left', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04L/2000FT BR OVC002 08/08 A3002';

    RunwayVisualRange range = RunwayVisualRange('R04L/2000FT');
    List<RunwayVisualRange> ranges = [range];
    expect(Body(body).runwayVisualRanges, ranges);
  });

  test('Test standard runway visual range - minus', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000FT BR OVC002 08/08 A3002';

    RunwayVisualRange range = RunwayVisualRange('R04/M2000FT');
    List<RunwayVisualRange> ranges = [range];
    expect(Body(body).runwayVisualRanges, ranges);
  });

  test('Test variable runway visual range', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000V3000FT '
        'BR OVC002 08/08 A3002';

    RunwayVisualRange range = RunwayVisualRange('R04/2000V3000FT');
    List<RunwayVisualRange> ranges = [range];
    expect(Body(body).runwayVisualRanges, ranges);
  });

  test('Test multiple runway visual ranges', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT BR OVC002 08/08 A3002';

    List<RunwayVisualRange> ranges = [
      RunwayVisualRange('R04/M2000VP3000FT'),
      RunwayVisualRange('R10/0200FT'),
      RunwayVisualRange('R17C/M0100FT'),
    ];
    expect(Body(body).runwayVisualRanges, ranges);
  });
}

void bodyPresentWeatherGroups() {
  test('Test no weather groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM OVC002 08/08 A3002';

    expect(Body(body).presentWeatherGroups, List.empty());
  });

  test('Test single weather group', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT BR OVC002 08/08 A3002';

    List<PresentWeatherGroup> groups = [PresentWeatherGroup('BR')];
    expect(Body(body).presentWeatherGroups, groups);
  });

  test('Test multiple weather groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT -RA VCIC +BLSS OVC002 08/08 A3002';

    List<PresentWeatherGroup> groups = [
      PresentWeatherGroup('-RA'),
      PresentWeatherGroup('VCIC'),
      PresentWeatherGroup('+BLSS'),
    ];
    expect(Body(body).presentWeatherGroups, groups);
  });
}

void bodySkyConditionGroups() {
  test('Test no sky condition groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM 08/08 A3002';

    expect(Body(body).skyConditionGroups, List.empty());
  });

  test('Test single sky condition group', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT BR OVC002 08/08 A3002';

    List<SkyConditionGroup> groups = [SkyConditionGroup('OVC002')];
    expect(Body(body).skyConditionGroups, groups);
  });

  test('Test multiple sky condition groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT -RA VCIC +BLSS OVC200 SCT010TCU FEW001 08/08 A3002';

    List<SkyConditionGroup> groups = [
      SkyConditionGroup('OVC200'),
      SkyConditionGroup('SCT010TCU'),
      SkyConditionGroup('FEW001'),
    ];
    expect(Body(body).skyConditionGroups, groups);
  });
}

void bodyToString() {
  test('Test basic string output format', () {
    final body = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT '
        'BR OVC002 08/08 A3002';

    expect(Body(body).toString(), body);
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
