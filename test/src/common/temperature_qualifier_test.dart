import 'package:metar/src/common/temperature_qualifier.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('TemperatureQualifier', () {
    group('factory', () {
      temperatureQualifierFactory();
    });
    group('toString', () {
      temperatureQualifierToString();
    });
  });
}

void temperatureQualifierFactory() {
  test('Test constructor with empty string input', () {
    expect(TemperatureQualifier(''), TemperatureQualifier.none);
  });

  test('Test constructor with null string input', () {
    expect(TemperatureQualifier(null), TemperatureQualifier.none);
  });

  test('Test constructor with less string input', () {
    expect(TemperatureQualifier('M'), TemperatureQualifier.minus);
  });

  test('Test constructor with unexpected long input', () {
    var err = 'Temperature qualifier must consist only of 1 non-space character'
        ' if not empty, provided `UNEXPECTED`';
    expectFormatException(() => TemperatureQualifier('UNEXPECTED'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Unexpected temperature qualifier, must be `M` or empty, but '
        'provided: `U`';
    expectFormatException(() => TemperatureQualifier('U'), err);
  });
}

void temperatureQualifierToString() {
  test('Test string representation of non-present qualifier', () {
    expect(TemperatureQualifier.none.toString().isEmpty, true);
  });

  test('Test string representation of MINUS qualifier', () {
    expect(TemperatureQualifier.minus.toString(), 'M');
  });
}
