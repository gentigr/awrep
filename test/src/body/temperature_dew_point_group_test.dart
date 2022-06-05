import 'package:metar/src/body/temperature_dew_point_group.dart';
import 'package:metar/src/common/temperature.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('TemperatureDewPointGroup', () {
    group('constructor', () {
      temperatureDewPointGroupConstructor();
    });
    group('temperature', () {
      temperatureDewPointGroupTemperature();
    });
    group('dewPoint', () {
      temperatureDewPointGroupDewPoint();
    });
    group('toString', () {
      temperatureDewPointGroupToString();
    });
    group('equalityOperator', () {
      temperatureDewPointGroupEqualityOperator();
    });
    group('hashCode', () {
      temperatureDewPointGroupHashCode();
    });
  });
}

void temperatureDewPointGroupConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `TemperatureDewPointGroup` format '
        'in `10/1`, but found `0` using `RegExp: '
        'pattern=^(M?\\d{2}\\/(M?\\d{2})?)\$ flags=`';
    expectFormatException(() => TemperatureDewPointGroup('10/1'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `TemperatureDewPointGroup` format '
        'in `M10/10 01/`, but found `0` using `RegExp: '
        'pattern=^(M?\\d{2}\\/(M?\\d{2})?)\$ flags=`';
    expectFormatException(() => TemperatureDewPointGroup('M10/10 01/'), err);
  });

  test('Test compliance with format, positive short', () {
    expect(TemperatureDewPointGroup('M01/'), isA<TemperatureDewPointGroup>());
  });

  test('Test compliance with format, positive complete', () {
    expect(
        TemperatureDewPointGroup('M01/M10'), isA<TemperatureDewPointGroup>());
  });
}

void temperatureDewPointGroupTemperature() {
  test('Test pure integer value', () {
    expect(TemperatureDewPointGroup('10/01').temperature, Temperature('10'));
  });

  test('Test with qualifier', () {
    expect(TemperatureDewPointGroup('M01/M05').temperature, Temperature('M01'));
  });
}

void temperatureDewPointGroupDewPoint() {
  test('Test pure integer value', () {
    expect(TemperatureDewPointGroup('10/01').dewPoint, Temperature('01'));
  });

  test('Test with qualifier', () {
    expect(TemperatureDewPointGroup('M01/M05').dewPoint, Temperature('M05'));
  });

  test('Test no dew point', () {
    expect(TemperatureDewPointGroup('01/').dewPoint, null);
  });
}

void temperatureDewPointGroupToString() {
  test('Test with leading zero', () {
    expect(TemperatureDewPointGroup('M01/M05').toString(), 'M01/M05');
  });

  test('Test with no leading zero', () {
    expect(TemperatureDewPointGroup('21/18').toString(), '21/18');
  });

  test('Test no dew point', () {
    expect(TemperatureDewPointGroup('05/').toString(), '05/');
  });
}

void temperatureDewPointGroupEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(
        TemperatureDewPointGroup('01/M10') ==
            TemperatureDewPointGroup('02/M10'),
        false);
  });

  test('Test equality operator for equality', () {
    expect(
        TemperatureDewPointGroup('01/00') == TemperatureDewPointGroup('01/00'),
        true);
  });
}

void temperatureDewPointGroupHashCode() {
  test('Test hash generation for non-equality', () {
    expect(
        TemperatureDewPointGroup('05/01').hashCode ==
            TemperatureDewPointGroup('05/02').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        TemperatureDewPointGroup('05/01').hashCode ==
            TemperatureDewPointGroup('05/01').hashCode,
        true);
  });
}
