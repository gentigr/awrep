import 'package:metar/src/body/present_weather_group/phenomena/precipitation.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('Precipitation', () {
    group('factory', () {
      precipitationFactory();
    });
    group('toString', () {
      precipitationToString();
    });
  });
}

void precipitationFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group precipitation must have 2 non-space '
        'characters length if not empty, provided `SOME`';
    expectFormatException(() => Precipitation('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Present weather group precipitation must have 2 non-space '
        'characters length if not empty, provided `V`';
    expectFormatException(() => Precipitation('V'), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected present weather group precipitation weather '
        'phenomena, provided: `VC`, error: `Bad state: No element`';
    expectFormatException(() => Precipitation('VC'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Precipitation(''), Precipitation.none);
  });

  test('Test constructor with null string input', () {
    expect(Precipitation(null), Precipitation.none);
  });

  test('Test constructor with drizzle string input', () {
    expect(Precipitation('DZ'), Precipitation.drizzle);
  });

  test('Test constructor with rain string input', () {
    expect(Precipitation('RA'), Precipitation.rain);
  });

  test('Test constructor with snow string input', () {
    expect(Precipitation('SN'), Precipitation.snow);
  });

  test('Test constructor with snow grains string input', () {
    expect(Precipitation('SG'), Precipitation.snowGrains);
  });

  test('Test constructor with ice crystals string input', () {
    expect(Precipitation('IC'), Precipitation.iceCrystals);
  });

  test('Test constructor with ice pellets string input', () {
    expect(Precipitation('PL'), Precipitation.icePellets);
  });

  test('Test constructor with hail string input', () {
    expect(Precipitation('GR'), Precipitation.hail);
  });

  test('Test constructor with snow pellets string input', () {
    expect(Precipitation('GS'), Precipitation.snowPellets);
  });

  test('Test constructor with unknown string input', () {
    expect(Precipitation('UP'), Precipitation.unknown);
  });
}

void precipitationToString() {
  test('Test string representation of local or point precipitation', () {
    expect(Precipitation.none.toString().isEmpty, true);
  });

  test('Test string representation of drizzle precipitation', () {
    expect(Precipitation.drizzle.toString(), 'DZ');
  });

  test('Test string representation of rain precipitation', () {
    expect(Precipitation.rain.toString(), 'RA');
  });

  test('Test string representation of snow precipitation', () {
    expect(Precipitation.snow.toString(), 'SN');
  });

  test('Test string representation of snow grains precipitation', () {
    expect(Precipitation.snowGrains.toString(), 'SG');
  });

  test('Test string representation of ice crystals precipitation', () {
    expect(Precipitation.iceCrystals.toString(), 'IC');
  });

  test('Test string representation of ice pellets precipitation', () {
    expect(Precipitation.icePellets.toString(), 'PL');
  });

  test('Test string representation of hail precipitation', () {
    expect(Precipitation.hail.toString(), 'GR');
  });

  test('Test string representation of snow pellets precipitation', () {
    expect(Precipitation.snowPellets.toString(), 'GS');
  });

  test('Test string representation of unknown precipitation', () {
    expect(Precipitation.unknown.toString(), 'UP');
  });
}
