import 'package:awrep/src/body/wind.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {
  group('Wind', () {
    group('constructor', () {
      windConstructor();
    });
    group('direction', () {
      windDirection();
    });
    group('speed', () {
      windSpeed();
    });
    group('gust', () {
      windGust();
    });
    group('directionVrbRangeStart', () {
      windDirectionVrbRangeStart();
    });
    group('directionVrbRangeEnd', () {
      windDirectionVrbRangeEnd();
    });
    group('toString', () {
      windToString();
    });
    group('equalityOperator', () {
      windEqualityOperator();
    });
    group('hashCode', () {
      windHashCode();
    });
  });
}

void windConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `Wind` format in `10010G1KT`, but '
        'found `0` using `RegExp: pattern=^(VRB|\\d{3})\\d{2,3}(G\\d{2,3})?KT'
        '( \\d{3}V\\d{3})?\$ flags=`';
    expectFormatException(() => Wind('10010G1KT'), err);
  });

  test('Test compliance with format, negative with variable range', () {
    var err = 'Expected to find one match of `Wind` format in `10010KT 160V22`,'
        ' but found `0` using `RegExp: pattern=^(VRB|\\d{3})\\d{2,3}'
        '(G\\d{2,3})?KT( \\d{3}V\\d{3})?\$ flags=`';
    expectFormatException(() => Wind('10010KT 160V22'), err);
  });

  test('Test compliance with format, positive', () {
    expect(Wind('12315G54KT 005V065'), isA<Wind>());
  });
}

void windDirection() {
  test('Test correct light and variable wind direction recognition', () {
    expect(Wind('VRB03KT').direction, null);
  });

  test('Test correct wind direction recognition', () {
    expect(Wind('12315KT').direction, 123);
  });

  test('Test upper limit of direction', () {
    var err = 'Report direction value must be within [0; 359] range, '
        'provided: `360` from `360010KT`';

    expectFormatException(() => Wind('360010KT').direction, err);
  });
}

void windSpeed() {
  test('Test correct wind speed recognition', () {
    expect(Wind('12315KT').speed, 15);
  });
}

void windGust() {
  test('Test correct wind no gust recognition', () {
    expect(Wind('12315KT').gust, null);
  });

  test('Test correct wind gust recognition', () {
    expect(Wind('12315G54KT').gust, 54);
  });
}

void windDirectionVrbRangeStart() {
  test('Test correct wind no variable range recognition', () {
    expect(Wind('12315KT').directionVrbRangeStart, null);
  });

  test('Test correct wind variable range recognition, three zeros', () {
    expect(Wind('12315G54KT 000V060').directionVrbRangeStart, 0);
  });

  test('Test correct wind variable range recognition, two zeros', () {
    expect(Wind('12315G54KT 005V065').directionVrbRangeStart, 5);
  });

  test('Test correct wind variable range recognition, one zero', () {
    expect(Wind('12315G54KT 015V075').directionVrbRangeStart, 15);
  });

  test('Test correct wind variable range recognition, no zeros', () {
    expect(Wind('12315G54KT 115V175').directionVrbRangeStart, 115);
  });

  test('Test upper limit of vrb direction', () {
    var err = 'Report vrb_range_start value must be within [0; 359] range, '
        'provided: `400` from `360010KT 400V460`';

    expectFormatException(
        () => Wind('360010KT 400V460').directionVrbRangeStart, err);
  });
}

void windDirectionVrbRangeEnd() {
  test('Test correct wind no variable range recognition', () {
    expect(Wind('12315KT').directionVrbRangeEnd, null);
  });

  test('Test correct wind variable range recognition, three zeros', () {
    expect(Wind('12315G54KT 300V000').directionVrbRangeEnd, 0);
  });

  test('Test correct wind variable range recognition, two zeros', () {
    expect(Wind('12315G54KT 305V005').directionVrbRangeEnd, 5);
  });

  test('Test correct wind variable range recognition, one zero', () {
    expect(Wind('12315G54KT 315V015').directionVrbRangeEnd, 15);
  });

  test('Test correct wind variable range recognition, no zeros', () {
    expect(Wind('12315G54KT 115V175').directionVrbRangeEnd, 175);
  });

  test('Test upper limit of vrb direction', () {
    var err = 'Report vrb_range_end value must be within [0; 359] range, '
        'provided: `460` from `360010KT 400V460`';

    expectFormatException(
        () => Wind('360010KT 400V460').directionVrbRangeEnd, err);
  });
}

void windToString() {
  test('Test calm wind', () {
    expect(Wind('00000KT').toString(), '00000KT');
  });

  test('Test one-symbol velocity wind', () {
    expect(Wind('10008KT').toString(), '10008KT');
  });

  test('Test two-symbol velocity wind', () {
    expect(Wind('10088KT').toString(), '10088KT');
  });

  test('Test three-symbol velocity wind', () {
    expect(Wind('100888KT').toString(), '100888KT');
  });

  test('Test one-symbol direction wind', () {
    expect(Wind('00205KT').toString(), '00205KT');
  });

  test('Test two-symbol direction wind', () {
    expect(Wind('02005KT').toString(), '02005KT');
  });

  test('Test three-symbol direction wind', () {
    expect(Wind('20005KT').toString(), '20005KT');
  });

  test('Test one-symbol gust wind', () {
    expect(Wind('10005G09KT').toString(), '10005G09KT');
  });

  test('Test two-symbol gust wind', () {
    expect(Wind('10005G90KT').toString(), '10005G90KT');
  });

  test('Test three-symbol gust wind', () {
    expect(Wind('10005G900KT').toString(), '10005G900KT');
  });

  test('Test variable wind', () {
    expect(Wind('10005KT 070V130').toString(), '10005KT 070V130');
  });

  test('Test variable light wind', () {
    expect(Wind('VRB06KT').toString(), 'VRB06KT');
  });

  test('Test variable light wind with directions', () {
    expect(Wind('VRB06KT 100V160').toString(), 'VRB06KT');
  });

  test('Test variable gust wind', () {
    expect(Wind('03015G25KT 000V060').toString(), '03015G25KT 000V060');
  });
}

void windEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final wind1 = '00000KT';
    final wind2 = '00010KT';

    expect(Wind(wind1) == Wind(wind2), false);
  });

  test('Test equality operator for equality', () {
    final wind1 = '10010KT';
    final wind2 = '10010KT';

    expect(Wind(wind1) == Wind(wind2), true);
  });
}

void windHashCode() {
  test('Test hash generation for non-equality', () {
    final wind1 = '00000KT';
    final wind2 = '00010KT';

    expect(Wind(wind1).hashCode == Wind(wind2).hashCode, false);
  });

  test('Test hash generation for equality', () {
    final wind1 = '10010KT';
    final wind2 = '10010KT';

    expect(Wind(wind1).hashCode == Wind(wind2).hashCode, true);
  });
}
