import 'package:metar/src/body/present_weather/qualifier/intensity.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('Intensity', () {
    group('factory', () {
      intensityFactory();
    });
    group('toString', () {
      intensityToString();
    });
  });
}

void intensityFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group intensity must have 1 non-space '
        'characters length if not empty, provided `+-`';
    expectFormatException(() => Intensity('+-'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Intensity(''), Intensity.moderate);
  });

  test('Test constructor with null string input', () {
    expect(Intensity(null), Intensity.moderate);
  });

  test('Test constructor with light string input', () {
    expect(Intensity('-'), Intensity.light);
  });

  test('Test constructor with heavy string input', () {
    expect(Intensity('+'), Intensity.heavy);
  });
}

void intensityToString() {
  test('Test string representation of non-present intensity', () {
    expect(Intensity.moderate.toString().isEmpty, true);
  });

  test('Test string representation of light intensity', () {
    expect(Intensity.light.toString(), '-');
  });

  test('Test string representation of heavy intensity', () {
    expect(Intensity.heavy.toString(), '+');
  });
}
