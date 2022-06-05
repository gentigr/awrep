import 'package:metar/src/body/altimeter.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Altimeter', () {
    group('constructor', () {
      altimeterConstructor();
    });
    group('asInteger', () {
      altimeterAsInteger();
    });
    group('toString', () {
      altimeterToString();
    });
    group('equalityOperator', () {
      altimeterEqualityOperator();
    });
    group('hashCode', () {
      altimeterHashCode();
    });
  });
}

void altimeterConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `Altimeter` format in `1001`, but '
        'found `0` using `RegExp: pattern=^A\\d{4}\$ flags=`';
    expectFormatException(() => Altimeter('1001'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `Altimeter` format in `A2000 '
        'A3000`, but found `0` using `RegExp: pattern=^A\\d{4}\$ flags=`';
    expectFormatException(() => Altimeter('A2000 A3000'), err);
  });

  test('Test compliance with format, positive', () {
    expect(Altimeter('A3002'), isA<Altimeter>());
  });
}

void altimeterAsInteger() {
  test('Test pure integer value', () {
    expect(Altimeter('A3010').asInteger, 3010);
  });
}

void altimeterToString() {
  test('Test with no leading zero', () {
    expect(Altimeter('A3021').toString(), 'A3021');
  });
}

void altimeterEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(Altimeter('A3001') == Altimeter('A3002'), false);
  });

  test('Test equality operator for equality', () {
    expect(Altimeter('A3001') == Altimeter('A3001'), true);
  });
}

void altimeterHashCode() {
  test('Test hash generation for non-equality', () {
    expect(Altimeter('A3001').hashCode == Altimeter('A3002').hashCode, false);
  });

  test('Test hash generation for equality', () {
    expect(Altimeter('A3001').hashCode == Altimeter('A3001').hashCode, true);
  });
}
