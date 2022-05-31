import 'package:awrep/src/common/distance_qualifier.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('DistanceQualifier', () {
    group('factory', () {
      distanceQualifierFactory();
    });
    group('toString', () {
      distanceQualifierToString();
    });
  });
}

void distanceQualifierFactory() {
  test('Test constructor with empty string input', () {
    expect(DistanceQualifier(''), DistanceQualifier.none);
  });

  test('Test constructor with null string input', () {
    expect(DistanceQualifier(null), DistanceQualifier.none);
  });

  test('Test constructor with less string input', () {
    expect(DistanceQualifier('M'), DistanceQualifier.less);
  });

  test('Test constructor with more string input', () {
    expect(DistanceQualifier('P'), DistanceQualifier.more);
  });

  test('Test constructor with leading space string input', () {
    expect(DistanceQualifier(' P'), DistanceQualifier.more);
  });

  test('Test constructor with trailing space string input', () {
    expect(DistanceQualifier('P '), DistanceQualifier.more);
  });

  test('Test constructor with leading and trailing spaces string input', () {
    expect(DistanceQualifier(' M '), DistanceQualifier.less);
  });

  test('Test constructor with unexpected input', () {
    var err = 'Distance qualifier must consist only of 1 non-space character, '
        'provided `UNEXPECTED`';
    expectFormatException(() => DistanceQualifier('UNEXPECTED'), err);
  });
}

void distanceQualifierToString() {
  test('Test string representation of non-present qualifier', () {
    expect(DistanceQualifier.none.toString().isEmpty, true);
  });

  test('Test string representation of MINUS qualifier', () {
    expect(DistanceQualifier.less.toString(), 'M');
  });

  test('Test string representation of PLUS qualifier', () {
    expect(DistanceQualifier.more.toString(), 'P');
  });
}
