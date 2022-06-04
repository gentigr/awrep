import 'package:metar/src/body/present_weather_group/phenomena/obscuration.dart';
import 'package:metar/src/body/present_weather_group/phenomena/other_phenomena.dart';
import 'package:metar/src/body/present_weather_group/phenomena/precipitation.dart';
import 'package:metar/src/body/present_weather_group/present_weather_group.dart';
import 'package:metar/src/body/present_weather_group/qualifier/descriptor.dart';
import 'package:metar/src/body/present_weather_group/qualifier/intensity.dart';
import 'package:metar/src/body/present_weather_group/qualifier/proximity.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('PresentWeatherGroup', () {
    group('constructor', () {
      presentWeatherGroupConstructor();
    });
    group('intensity', () {
      presentWeatherGroupIntensity();
    });
    group('proximity', () {
      presentWeatherGroupProximity();
    });
    group('descriptor', () {
      presentWeatherGroupDescriptor();
    });
    group('precipitation', () {
      presentWeatherGroupPrecipitation();
    });
    group('obscuration', () {
      presentWeatherGroupObscuration();
    });
    group('other', () {
      presentWeatherGroupOtherPhenomena();
    });
    group('toString', () {
      presentWeatherGroupToString();
    });
    group('equalityOperator', () {
      presentWeatherGroupEqualityOperator();
    });
    group('hashCode', () {
      presentWeatherGroupHashCode();
    });
  });
}

void presentWeatherGroupConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `PresentWeatherGroup` format '
        'in `10010G1KT`, but found `0` using `RegExp: pattern=^(-|\\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?((DZ|RA|SN|SG|IC|PL|GR|GS|UP)|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|(PO|SQ|FC|SS|DS)){1}\$ flags=`';
    expectFormatException(() => PresentWeatherGroup('10010G1KT'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `PresentWeatherGroup` format in '
        '`RA BR`, but found `0` using `RegExp: pattern=^(-|\\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?((DZ|RA|SN|SG|IC|PL|GR|GS|UP)|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|(PO|SQ|FC|SS|DS)){1}\$ flags=`';
    expectFormatException(() => PresentWeatherGroup('RA BR'), err);
  });

  test('Test compliance with format, positive', () {
    expect(PresentWeatherGroup('VCBR'), isA<PresentWeatherGroup>());
  });
}

void presentWeatherGroupIntensity() {
  test('Test light intensity', () {
    expect(PresentWeatherGroup('-BR').intensity, Intensity.light);
  });

  test('Test moderate intensity', () {
    expect(PresentWeatherGroup('BR').intensity, Intensity.moderate);
  });

  test('Test heavy intensity', () {
    expect(PresentWeatherGroup('+BR').intensity, Intensity.heavy);
  });
}

void presentWeatherGroupProximity() {
  test('Test no proximity', () {
    expect(PresentWeatherGroup('FG').proximity, Proximity.point);
  });

  test('Test presence of proximity', () {
    expect(PresentWeatherGroup('VCFG').proximity, Proximity.vicinity);
  });
}

void presentWeatherGroupDescriptor() {
  test('Test no descriptor', () {
    expect(PresentWeatherGroup('-DZ').descriptor, Descriptor.none);
  });

  test('Test presence of descriptor', () {
    expect(PresentWeatherGroup('TSGR').descriptor, Descriptor.thunderstorm);
  });
}

void presentWeatherGroupPrecipitation() {
  test('Test no precipitation', () {
    expect(PresentWeatherGroup('+DU').precipitation, Precipitation.none);
  });

  test('Test presence of precipitation', () {
    expect(PresentWeatherGroup('DZ').precipitation, Precipitation.drizzle);
  });
}

void presentWeatherGroupObscuration() {
  test('Test no obscuration', () {
    expect(PresentWeatherGroup('RA').obscuration, Obscuration.none);
  });

  test('Test presence of obscuration', () {
    expect(PresentWeatherGroup('+MISA').obscuration, Obscuration.sand);
  });
}

void presentWeatherGroupOtherPhenomena() {
  test('Test no other phenomena', () {
    expect(PresentWeatherGroup('FU').other, OtherPhenomena.none);
  });

  test('Test presence of other phenomena', () {
    expect(PresentWeatherGroup('SS').other, OtherPhenomena.sandstorm);
  });
}

void presentWeatherGroupToString() {
  test('Test combination 1', () {
    expect(PresentWeatherGroup('-MIDZ').toString(), '-MIDZ');
  });

  test('Test combination 2', () {
    expect(PresentWeatherGroup('BCFG').toString(), 'BCFG');
  });

  test('Test combination 3', () {
    expect(PresentWeatherGroup('+TSSQ').toString(), '+TSSQ');
  });

  test('Test combination 4', () {
    expect(PresentWeatherGroup('VCSA').toString(), 'VCSA');
  });

  test('Test combination 5', () {
    expect(PresentWeatherGroup('GS').toString(), 'GS');
  });
}

void presentWeatherGroupEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(PresentWeatherGroup('BCFG') == PresentWeatherGroup('BCDZ'), false);
  });

  test('Test equality operator for equality', () {
    expect(PresentWeatherGroup('BCFG') == PresentWeatherGroup('BCFG'), true);
  });
}

void presentWeatherGroupHashCode() {
  test('Test hash generation for non-equality', () {
    expect(
        PresentWeatherGroup('BCDZ').hashCode ==
            PresentWeatherGroup('FG').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        PresentWeatherGroup('BCDZ').hashCode ==
            PresentWeatherGroup('BCDZ').hashCode,
        true);
  });
}
