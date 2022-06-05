import 'package:metar/src/body/temperature_dew_point.dart';
import 'package:metar/src/common/temperature.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('TemperatureDewPoint', () {
    group('constructor', () {
      temperatureDewPointConstructor();
    });
    group('temperature', () {
      temperatureDewPointTemperature();
    });
    group('dewPoint', () {
      temperatureDewPointDewPoint();
    });
    group('toString', () {
      temperatureDewPointToString();
    });
    group('equalityOperator', () {
      temperatureDewPointEqualityOperator();
    });
    group('hashCode', () {
      temperatureDewPointHashCode();
    });
  });
}

void temperatureDewPointConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `TemperatureDewPoint` format '
        'in `10/1`, but found `0` using `RegExp: '
        'pattern=^(M?\\d{2}\\/(M?\\d{2})?)\$ flags=`';
    expectFormatException(() => TemperatureDewPoint('10/1'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `TemperatureDewPoint` format '
        'in `M10/10 01/`, but found `0` using `RegExp: '
        'pattern=^(M?\\d{2}\\/(M?\\d{2})?)\$ flags=`';
    expectFormatException(() => TemperatureDewPoint('M10/10 01/'), err);
  });

  test('Test compliance with format, positive short', () {
    expect(TemperatureDewPoint('M01/'), isA<TemperatureDewPoint>());
  });

  test('Test compliance with format, positive complete', () {
    expect(TemperatureDewPoint('M01/M10'), isA<TemperatureDewPoint>());
  });
}

void temperatureDewPointTemperature() {
  test('Test pure integer value', () {
    expect(TemperatureDewPoint('10/01').temperature, Temperature('10'));
  });

  test('Test with qualifier', () {
    expect(TemperatureDewPoint('M01/M05').temperature, Temperature('M01'));
  });
}

void temperatureDewPointDewPoint() {
  test('Test pure integer value', () {
    expect(TemperatureDewPoint('10/01').dewPoint, Temperature('01'));
  });

  test('Test with qualifier', () {
    expect(TemperatureDewPoint('M01/M05').dewPoint, Temperature('M05'));
  });

  test('Test no dew point', () {
    expect(TemperatureDewPoint('01/').dewPoint, null);
  });
}

void temperatureDewPointToString() {
  test('Test with leading zero', () {
    expect(TemperatureDewPoint('M01/M05').toString(), 'M01/M05');
  });

  test('Test with no leading zero', () {
    expect(TemperatureDewPoint('21/18').toString(), '21/18');
  });

  test('Test no dew point', () {
    expect(TemperatureDewPoint('05/').toString(), '05/');
  });
}

void temperatureDewPointEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(
        TemperatureDewPoint('01/M10') == TemperatureDewPoint('02/M10'), false);
  });

  test('Test equality operator for equality', () {
    expect(TemperatureDewPoint('01/00') == TemperatureDewPoint('01/00'), true);
  });
}

void temperatureDewPointHashCode() {
  test('Test hash generation for non-equality', () {
    expect(
        TemperatureDewPoint('05/01').hashCode ==
            TemperatureDewPoint('05/02').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        TemperatureDewPoint('05/01').hashCode ==
            TemperatureDewPoint('05/01').hashCode,
        true);
  });
}
