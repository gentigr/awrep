import 'package:awrep/src/body/type.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Type', () {
    group('factory', () {
      typeFactory();
    });
    group('toString', () {
      typeToString();
    });
  });
}

void typeFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Report type must have 5 non-space characters length if not '
        'empty, provided `UNEXPECTED`';
    expectFormatException(() => Type('UNEXPECTED'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Unexpected report type, provided: `LIVER`';
    expectFormatException(() => Type('LIVER'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Type(''), Type.none);
  });

  test('Test constructor with null string input', () {
    expect(Type(null), Type.none);
  });

  test('Test constructor with METAR string input', () {
    expect(Type('METAR'), Type.metar);
  });

  test('Test constructor with SPECI string input', () {
    expect(Type('SPECI'), Type.speci);
  });
}

void typeToString() {
  test('Test string representation of non-present type', () {
    expect(Type.none.toString().isEmpty, true);
  });

  test('Test string representation of METAR', () {
    expect(Type.metar.toString(), 'METAR');
  });

  test('Test string representation of SPECI', () {
    expect(Type.speci.toString(), 'SPECI');
  });
}