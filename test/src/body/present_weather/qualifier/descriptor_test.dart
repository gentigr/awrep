import 'package:metar/src/body/present_weather/qualifier/descriptor.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('Descriptor', () {
    group('factory', () {
      descriptorFactory();
    });
    group('toString', () {
      descriptorToString();
    });
  });
}

void descriptorFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group descriptor must have 2 non-space '
        'characters length if not empty, provided `SOME`';
    expectFormatException(() => Descriptor('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Present weather group descriptor must have 2 non-space '
        'characters length if not empty, provided `V`';
    expectFormatException(() => Descriptor('V'), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected present weather group descriptor qualifier, '
        'provided: `VC`, error: `Bad state: No element`';
    expectFormatException(() => Descriptor('VC'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Descriptor(''), Descriptor.none);
  });

  test('Test constructor with null string input', () {
    expect(Descriptor(null), Descriptor.none);
  });

  test('Test constructor with shallow string input', () {
    expect(Descriptor('MI'), Descriptor.shallow);
  });

  test('Test constructor with partial string input', () {
    expect(Descriptor('PR'), Descriptor.partial);
  });

  test('Test constructor with patches string input', () {
    expect(Descriptor('BC'), Descriptor.patches);
  });

  test('Test constructor with low drifting string input', () {
    expect(Descriptor('DR'), Descriptor.lowDrifting);
  });

  test('Test constructor with blowing string input', () {
    expect(Descriptor('BL'), Descriptor.blowing);
  });

  test('Test constructor with shower string input', () {
    expect(Descriptor('SH'), Descriptor.shower);
  });

  test('Test constructor with thunderstorm string input', () {
    expect(Descriptor('TS'), Descriptor.thunderstorm);
  });

  test('Test constructor with freezing string input', () {
    expect(Descriptor('FZ'), Descriptor.freezing);
  });
}

void descriptorToString() {
  test('Test string representation of local or point descriptor', () {
    expect(Descriptor.none.toString().isEmpty, true);
  });

  test('Test string representation of shallow descriptor', () {
    expect(Descriptor.shallow.toString(), 'MI');
  });

  test('Test string representation of partial descriptor', () {
    expect(Descriptor.partial.toString(), 'PR');
  });

  test('Test string representation of patches descriptor', () {
    expect(Descriptor.patches.toString(), 'BC');
  });

  test('Test string representation of low drifting descriptor', () {
    expect(Descriptor.lowDrifting.toString(), 'DR');
  });

  test('Test string representation of blowing descriptor', () {
    expect(Descriptor.blowing.toString(), 'BL');
  });

  test('Test string representation of shower descriptor', () {
    expect(Descriptor.shower.toString(), 'SH');
  });

  test('Test string representation of thunderstorm descriptor', () {
    expect(Descriptor.thunderstorm.toString(), 'TS');
  });

  test('Test string representation of freezing descriptor', () {
    expect(Descriptor.freezing.toString(), 'FZ');
  });
}
