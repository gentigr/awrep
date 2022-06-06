import 'package:metar/src/body/present_weather/phenomena/obscuration.dart';
import 'package:metar/src/body/present_weather/phenomena/other_phenomena.dart';
import 'package:metar/src/body/present_weather/phenomena/precipitation.dart';
import 'package:metar/src/body/present_weather/present_weather.dart';
import 'package:metar/src/body/present_weather/qualifier/descriptor.dart';
import 'package:metar/src/body/present_weather/qualifier/intensity.dart';
import 'package:metar/src/body/present_weather/qualifier/proximity.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('PresentWeather', () {
    group('constructor', () {
      presentWeatherConstructor();
    });
    group('intensity', () {
      presentWeatherIntensity();
    });
    group('proximity', () {
      presentWeatherProximity();
    });
    group('descriptor', () {
      presentWeatherDescriptor();
    });
    group('precipitation', () {
      presentWeatherPrecipitation();
    });
    group('obscuration', () {
      presentWeatherObscuration();
    });
    group('other', () {
      presentWeatherOtherPhenomena();
    });
    group('toString', () {
      presentWeatherToString();
    });
    group('equalityOperator', () {
      presentWeatherEqualityOperator();
    });
    group('hashCode', () {
      presentWeatherHashCode();
    });
  });
}

void presentWeatherConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `PresentWeather` format in '
        '`10010G1KT`, but found `0` using `RegExp: '
        'pattern=^(-|\\+|VC)?(MI|PR|BC|DR|BL|SH|TS|FZ)?'
        '((MI|PR|BC|DR|BL|SH|TS|FZ)|(DZ|RA|SN|SG|IC|PL|GR|GS|UP){1,2}|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|(PO|SQ|FC|SS|DS)){1}\$ flags=`';
    expectFormatException(() => PresentWeather('10010G1KT'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `PresentWeather` format in '
        '`RA BR`, but found `0` using `RegExp: pattern=^(-|\\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?((MI|PR|BC|DR|BL|SH|TS|FZ)|'
        '(DZ|RA|SN|SG|IC|PL|GR|GS|UP){1,2}|(BR|FG|FU|VA|DU|SA|HZ|PY)|'
        '(PO|SQ|FC|SS|DS)){1}\$ flags=`';
    expectFormatException(() => PresentWeather('RA BR'), err);
  });

  test('Test compliance with format, positive', () {
    expect(PresentWeather('VCBR'), isA<PresentWeather>());
  });
}

void presentWeatherIntensity() {
  test('Test light intensity', () {
    expect(PresentWeather('-BR').intensity, Intensity.light);
  });

  test('Test moderate intensity', () {
    expect(PresentWeather('BR').intensity, Intensity.moderate);
  });

  test('Test heavy intensity', () {
    expect(PresentWeather('+BR').intensity, Intensity.heavy);
  });
}

void presentWeatherProximity() {
  test('Test no proximity', () {
    expect(PresentWeather('FG').proximity, Proximity.point);
  });

  test('Test presence of proximity', () {
    expect(PresentWeather('VCFG').proximity, Proximity.vicinity);
  });

  test('Test presence of proximity, descriptor only', () {
    expect(PresentWeather('VCTS').proximity, Proximity.vicinity);
  });
}

void presentWeatherDescriptor() {
  test('Test no descriptor', () {
    expect(PresentWeather('-DZ').descriptor, Descriptor.none);
  });

  test('Test presence of descriptor', () {
    expect(PresentWeather('TSGR').descriptor, Descriptor.thunderstorm);
  });

  test('Test presence of descriptor in vicinity only', () {
    expect(PresentWeather('VCTS').descriptor, Descriptor.thunderstorm);
  });

  test('Test presence of descriptor only', () {
    expect(PresentWeather('TS').descriptor, Descriptor.thunderstorm);
  });
}

void presentWeatherPrecipitation() {
  test('Test no precipitation', () {
    expect(PresentWeather('+DU').precipitation, <Precipitation>[]);
  });

  test('Test presence of precipitation', () {
    expect(PresentWeather('DZ').precipitation, [Precipitation.drizzle]);
  });

  test('Test presence of multiple precipitations', () {
    expect(PresentWeather('-PLRA').precipitation, [
      Precipitation.icePellets,
      Precipitation.rain,
    ]);
  });
}

void presentWeatherObscuration() {
  test('Test no obscuration', () {
    expect(PresentWeather('RA').obscuration, Obscuration.none);
  });

  test('Test presence of obscuration', () {
    expect(PresentWeather('+MISA').obscuration, Obscuration.sand);
  });
}

void presentWeatherOtherPhenomena() {
  test('Test no other phenomena', () {
    expect(PresentWeather('FU').other, OtherPhenomena.none);
  });

  test('Test presence of other phenomena', () {
    expect(PresentWeather('SS').other, OtherPhenomena.sandstorm);
  });
}

void presentWeatherToString() {
  test('Test combination 1', () {
    expect(PresentWeather('-MIDZ').toString(), '-MIDZ');
  });

  test('Test combination 2', () {
    expect(PresentWeather('BCFG').toString(), 'BCFG');
  });

  test('Test combination 3', () {
    expect(PresentWeather('+TSSQ').toString(), '+TSSQ');
  });

  test('Test combination 4', () {
    expect(PresentWeather('VCSA').toString(), 'VCSA');
  });

  test('Test combination 5', () {
    expect(PresentWeather('GS').toString(), 'GS');
  });

  test('Test combination 6', () {
    expect(PresentWeather('VCTS').toString(), 'VCTS');
  });

  test('Test combination 7', () {
    expect(PresentWeather('TS').toString(), 'TS');
  });
}

void presentWeatherEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(PresentWeather('BCFG') == PresentWeather('BCDZ'), false);
  });

  test('Test equality operator for equality', () {
    expect(PresentWeather('BCFG') == PresentWeather('BCFG'), true);
  });
}

void presentWeatherHashCode() {
  test('Test hash generation for non-equality', () {
    expect(PresentWeather('BCDZ').hashCode == PresentWeather('FG').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(PresentWeather('BCDZ').hashCode == PresentWeather('BCDZ').hashCode,
        true);
  });
}
