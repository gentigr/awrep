import 'package:awrep/src/body/modifier.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Modifier', () {
    group('factory', () {
      modifierFactory();
    });
    group('toString', () {
      modifierToString();
    });
  });
}

void modifierFactory() {
  test('Test constructor with unexpected input', () {
    var err = 'Unexpected report modifier, provided: `UNEXPECTED`';
    expectFormatException(() => Modifier('UNEXPECTED'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Modifier(''), Modifier.none);
  });

  test('Test constructor with null string input', () {
    expect(Modifier(null), Modifier.none);
  });

  test('Test constructor with AUTO string input', () {
    expect(Modifier('AUTO'), Modifier.auto);
  });

  test('Test constructor with COR string input', () {
    expect(Modifier('COR'), Modifier.cor);
  });
}

void modifierToString() {
  test('Test string representation of non-present modifier', () {
    expect(Modifier.none.toString().isEmpty, true);
  });

  test('Test string representation of AUTO', () {
    expect(Modifier.auto.toString(), 'AUTO');
  });

  test('Test string representation of COR', () {
    expect(Modifier.cor.toString(), 'COR');
  });
}
