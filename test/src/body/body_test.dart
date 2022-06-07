import 'package:metar/src/body/altimeter.dart';
import 'package:metar/src/body/body.dart';
import 'package:metar/src/body/date_time.dart';
import 'package:metar/src/body/modifier.dart';
import 'package:metar/src/body/present_weather/present_weather.dart';
import 'package:metar/src/body/runway_visual_range.dart';
import 'package:metar/src/body/sky_condition/sky_condition.dart';
import 'package:metar/src/body/temperature_dew_point.dart';
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
    group('presentWeather', () {
      bodyPresentWeather();
    });
    group('skyCondition', () {
      bodySkyCondition();
    });
    group('temperatureDewPoint', () {
      bodyTemperatureDewPoint();
    });
    group('altimeter', () {
      bodyAltimeter();
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
    final body = 'SPECI KATL 221447Z KT 10SM SCT012 SCT026 26/23 A2999';
    expect(Body(body).wind, null);
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

  // WARN: special case not covered by specification, but reported in reality
  test('Test no visibility', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT BR OVC002 08/08 A3002';

    expect(Body(body).visibility, null);
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

  test('Test no runway visual range information', () {
    final body = 'KJFK 190351Z 18004KT 10SM RVRNO BR OVC002 08/08 A3002';

    RunwayVisualRange range = RunwayVisualRange('RVRNO');
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

void bodyPresentWeather() {
  test('Test no weather groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM OVC002 08/08 A3002';

    expect(Body(body).presentWeather, List.empty());
  });

  test('Test single weather group', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT BR OVC002 08/08 A3002';

    List<PresentWeather> groups = [PresentWeather('BR')];
    expect(Body(body).presentWeather, groups);
  });

  test('Test single weather group without phenomena', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT VCTS OVC002 08/08 A3002';

    List<PresentWeather> groups = [PresentWeather('VCTS')];
    expect(Body(body).presentWeather, groups);
  });

  test('Test single weather group collocated', () {
    final body = 'KJFK 012101Z 08003KT 10SM -PLRA FEW030 OVC090 04/M02 A3038';

    List<PresentWeather> groups = [PresentWeather('-PLRA')];
    expect(Body(body).presentWeather, groups);
  });

  test('Test single weather group trio', () {
    final body = 'KATL 062213Z 06012KT 8SM -RASNPL FEW014 OVC065 04/02 A3002';

    List<PresentWeather> groups = [PresentWeather('-RASNPL')];
    expect(Body(body).presentWeather, groups);
  });

  test('Test multiple weather groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT -RA VCIC +BLSS OVC002 08/08 A3002';

    List<PresentWeather> groups = [
      PresentWeather('-RA'),
      PresentWeather('VCIC'),
      PresentWeather('+BLSS'),
    ];
    expect(Body(body).presentWeather, groups);
  });
}

void bodySkyCondition() {
  test('Test no sky condition groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM 08/08 A3002';

    expect(Body(body).skyCondition, List.empty());
  });

  test('Test single sky condition group', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/2000FT BR OVC002 08/08 A3002';

    List<SkyCondition> groups = [SkyCondition('OVC002')];
    expect(Body(body).skyCondition, groups);
  });

  test('Test multiple sky condition groups with zero height', () {
    final body = 'KJFK 211439Z 18017KT 10SM FEW018 FEW030CB BKN 12/09 A2968';

    List<SkyCondition> groups = [
      SkyCondition('FEW018'),
      SkyCondition('FEW030CB'),
      SkyCondition('BKN'),
    ];
    expect(Body(body).skyCondition, groups);
  });

  test('Test multiple sky condition groups', () {
    final body = 'KJFK 190351Z 18004KT 10SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT -RA VCIC +BLSS OVC200 SCT010TCU FEW001 08/08 A3002';

    List<SkyCondition> groups = [
      SkyCondition('OVC200'),
      SkyCondition('SCT010TCU'),
      SkyCondition('FEW001'),
    ];
    expect(Body(body).skyCondition, groups);
  });
}

void bodyTemperatureDewPoint() {
  test('Test positive temperature dew point group', () {
    final body = 'KJFK 190351Z 18004KT 0SM R04R/2000V3000FT BR 08/08 A3002';

    expect(Body(body).temperatureDewPoint, TemperatureDewPoint('08/08'));
  });

  test('Test negative temperature dew point group', () {
    final body = 'KJFK 190351Z 18004KT 1 1/4SM R04R/2000FT M08/M08 A3002';

    expect(Body(body).temperatureDewPoint, TemperatureDewPoint('M08/M08'));
  });

  test('Test partial temperature dew point group', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT 30SM BR OVC002 08/ A3002';

    expect(Body(body).temperatureDewPoint, TemperatureDewPoint('08/'));
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test no temperature dew point group', () {
    final body = 'METAR KJFK 190351Z AUTO 18004KT 30SM BR OVC002 A3002';

    expect(Body(body).temperatureDewPoint, null);
  });
}

void bodyAltimeter() {
  test('Test altimeter parsed as expected', () {
    final body = 'KJFK 190351Z 18004KT 0SM R04R/2000V3000FT BR 08/08 A3002';

    expect(Body(body).altimeter, Altimeter('A3002'));
  });

  test('Test altimeter is not specified', () {
    final body = 'KJFK 190351Z 18004KT 0SM R04R/2000V3000FT BR 08/08';

    expect(Body(body).altimeter, null);
  });
}

void bodyToString() {
  test('Test basic string output format, option 1', () {
    final body = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT '
        'BR OVC002 08/08 A3002';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 2', () {
    final body = 'KJFK 142009Z 00000KT 2SM R04R/3000VP6000FT -RA BR FEW004 '
        'BKN075 OVC095 16/16 A3003';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 3', () {
    final body = 'KJFK 141951Z 17004KT 2SM BR BKN004 BKN031 OVC050 16/16 A3004';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 4', () {
    final body = 'KJFK 141937Z 15007KT 1/2SM R04R/P6000FT +RA BR '
        'BKN004 OVC034 16/16 A3006';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 5', () {
    final body = 'KJFK 141913Z 13014G18KT 1/2SM R04R/P6000FT -RA OVC006 '
        '18/16 A3006';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 6', () {
    final body = 'KJFK 141851Z 12008KT 10SM OVC006 19/17 A3006';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 7', () {
    final body = 'KJFK 190351Z 18004KT 1 1/4SM R04/M2000VP3000FT R10/0200FT '
        'R17C/M0100FT BR OVC002 08/08 A3002';

    expect(Body(body).toString(), body);
  });

  test('Test basic string output format, option 8', () {
    final body = 'KJFK 211439Z 18017KT 10SM FEW018 FEW030CB BKN0 12/09 A2968';

    expect(Body(body).toString(), body);
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test basic string output format, option 10', () {
    final body = 'METAR KJFK 061851Z 10004KT FEW024 BKN033 22/14 A3035';

    expect(Body(body).toString(), body);
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test basic string output format, option 11', () {
    final body = 'METAR KJFK 061851Z 10004KT FEW024 BKN033 A3035';

    expect(Body(body).toString(), body);
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test basic string output format, option 12', () {
    final body = 'KJFK 211439Z 18017KT 10SM FEW018 FEW030CB BKN0 12/09';

    expect(Body(body).toString(), body);
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test basic string output format, option 13', () {
    final body = 'METAR KJFK 270451Z 33009KT RVRNO';

    expect(Body(body).toString(), body);
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test basic string output format, option 14', () {
    final body = 'SPECI KATL 221447Z 10SM SCT012 SCT026 26/23 A2999';

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
