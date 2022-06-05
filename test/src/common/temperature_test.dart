import 'package:metar/src/common/temperature.dart';
import 'package:metar/src/common/temperature_qualifier.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Temperature', () {
    group('constructor', () {
      temperatureConstructor();
    });
    group('asInteger', () {
      temperatureAsInteger();
    });
    group('qualifier', () {
      temperatureQualifier();
    });
    group('toString', () {
      temperatureToString();
    });
    group('equalityOperator', () {
      temperatureEqualityOperator();
    });
    group('hashCode', () {
      temperatureHashCode();
    });
  });
}

void temperatureConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `Temperature` format in `1`, but '
        'found `0` using `RegExp: pattern=^M?\\d{2}\$ flags=`';
    expectFormatException(() => Temperature('1'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `Temperature` format in `M10 01`, '
        'but found `0` using `RegExp: pattern=^M?\\d{2}\$ flags=`';
    expectFormatException(() => Temperature('M10 01'), err);
  });

  test('Test compliance with format, positive', () {
    expect(Temperature('M01'), isA<Temperature>());
  });
}

void temperatureAsInteger() {
  test('Test pure integer value', () {
    expect(Temperature('10').asInteger, 10);
  });

  test('Test with qualifier', () {
    expect(Temperature('M00').asInteger, 0);
  });
}

void temperatureQualifier() {
  test('Test no qualifier', () {
    expect(Temperature('10').qualifier, TemperatureQualifier.none);
  });

  test('Test with qualifier', () {
    expect(Temperature('M05').qualifier, TemperatureQualifier.minus);
  });
}

void temperatureToString() {
  test('Test with leading zero', () {
    expect(Temperature('M01').toString(), 'M01');
  });

  test('Test with no leading zero', () {
    expect(Temperature('21').toString(), '21');
  });
}

void temperatureEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(Temperature('01') == Temperature('02'), false);
  });

  test('Test equality operator for equality', () {
    expect(Temperature('01') == Temperature('01'), true);
  });
}

void temperatureHashCode() {
  test('Test hash generation for non-equality', () {
    expect(Temperature('01').hashCode == Temperature('02').hashCode, false);
  });

  test('Test hash generation for equality', () {
    expect(Temperature('01').hashCode == Temperature('01').hashCode, true);
  });
}
