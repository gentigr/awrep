import 'package:metar/src/body/present_weather/qualifier/proximity.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('Proximity', () {
    group('factory', () {
      proximityFactory();
    });
    group('toString', () {
      proximityToString();
    });
  });
}

void proximityFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group proximity must have 2 non-space characters'
        ' length if not empty, provided `SOME`';
    expectFormatException(() => Proximity('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Present weather group proximity must have 2 non-space characters'
        ' length if not empty, provided `V`';
    expectFormatException(() => Proximity('V'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Proximity(''), Proximity.point);
  });

  test('Test constructor with null string input', () {
    expect(Proximity(null), Proximity.point);
  });

  test('Test constructor for the vicinity', () {
    expect(Proximity('VC'), Proximity.vicinity);
  });
}

void proximityToString() {
  test('Test string representation of local or point proximity', () {
    expect(Proximity.point.toString().isEmpty, true);
  });

  test('Test string representation of the vicinity proximity', () {
    expect(Proximity.vicinity.toString(), 'VC');
  });
}
