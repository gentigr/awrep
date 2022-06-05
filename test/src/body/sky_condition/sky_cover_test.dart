import 'package:metar/src/body/sky_condition/sky_cover.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('SkyCover', () {
    group('factory', () {
      skyCoverFactory();
    });
    group('toString', () {
      skyCoverToString();
    });
  });
}

void skyCoverFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Sky condition group sky cover must have 2 or 3'
        ' non-space characters length, provided `SOME`';
    expectFormatException(() => SkyCover('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Sky condition group sky cover must have 2 or 3'
        ' non-space characters length, provided `V`';
    expectFormatException(() => SkyCover('V'), err);
  });

  test('Test constructor with unexpected empty input', () {
    var err = 'Sky condition group sky cover must have 2 or 3'
        ' non-space characters length, provided ``';
    expectFormatException(() => SkyCover(''), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected sky condition group sky cover, provided:'
        ' `VCC`, error: `Bad state: No element`';
    expectFormatException(() => SkyCover('VCC'), err);
  });

  test('Test constructor with vertical visibility string input', () {
    expect(SkyCover('VV'), SkyCover.verticalVisibility);
  });

  test('Test constructor with sky clear string input', () {
    expect(SkyCover('SKC'), SkyCover.skyClear);
  });

  test('Test constructor with clear string input', () {
    expect(SkyCover('CLR'), SkyCover.clear);
  });

  test('Test constructor with few string input', () {
    expect(SkyCover('FEW'), SkyCover.few);
  });

  test('Test constructor with scattered string input', () {
    expect(SkyCover('SCT'), SkyCover.scattered);
  });

  test('Test constructor with broken string input', () {
    expect(SkyCover('BKN'), SkyCover.broken);
  });

  test('Test constructor with overcast string input', () {
    expect(SkyCover('OVC'), SkyCover.overcast);
  });
}

void skyCoverToString() {
  test('Test string representation of sky vertical visibility', () {
    expect(SkyCover.verticalVisibility.toString(), 'VV');
  });

  test('Test string representation of sky clear sky cover', () {
    expect(SkyCover.skyClear.toString(), 'SKC');
  });

  test('Test string representation of clear sky cover', () {
    expect(SkyCover.clear.toString(), 'CLR');
  });

  test('Test string representation of few sky cover', () {
    expect(SkyCover.few.toString(), 'FEW');
  });

  test('Test string representation of scattered sky cover', () {
    expect(SkyCover.scattered.toString(), 'SCT');
  });

  test('Test string representation of broken sky cover', () {
    expect(SkyCover.broken.toString(), 'BKN');
  });

  test('Test string representation of overcast sky cover', () {
    expect(SkyCover.overcast.toString(), 'OVC');
  });
}
