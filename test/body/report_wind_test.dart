import 'package:awrep/body/report_wind.dart';
import 'package:test/test.dart';

void main() {
  group('ReportWind', () {
    group('direction', () {
      reportWindDirection();
    });
    group('speed', () {
      reportWindSpeed();
    });
    group('gust', () {
      reportWindGust();
    });
    group('directionVrbRangeStart', () {
      reportWindDirectionVrbRangeStart();
    });
    group('directionVrbRangeEnd', () {
      reportWindDirectionVrbRangeEnd();
    });
    group('equalityOperator', () {
      reportWindEqualityOperator();
    });
    group('hashCode', () {
      reportWindHashCode();
    });
    group('toString', () {
      reportWindToString();
    });
  });
}

void reportWindDirection() {
  test('Test correct light and variable wind direction recognition', () {
    expect(ReportWind('VRB03KT').direction, null);
  });

  test('Test correct wind direction recognition', () {
    expect(ReportWind('12315KT').direction, 123);
  });

  test('Test upper limit of direction', () {
    var err = 'Report direction value must be within [0; 359] range, '
        'provided: `360` from `360010KT`';

    expect(
        () => ReportWind('360010KT').direction,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });

  test('Test no match', () {
    var err = 'Failed to find RegEx `RegExp: '
        'pattern=^(?<primary_wind_direction>(\\d{3}|VRB)) '
        'flags=` in report wind section `KT`';

    expect(
        () => ReportWind('KT').direction,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });
}

void reportWindSpeed() {
  test('Test correct wind speed recognition', () {
    expect(ReportWind('12315KT').speed, 15);
  });

  test('Test no match', () {
    var err = 'Failed to find RegEx `RegExp: '
        'pattern=^\\w{3}(?<speed>\\d{2,3}) '
        'flags=` in report wind section `KT`';

    expect(
        () => ReportWind('KT').speed,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });
}

void reportWindGust() {
  test('Test correct wind no gust recognition', () {
    expect(ReportWind('12315KT').gust, null);
  });

  test('Test correct wind gust recognition', () {
    expect(ReportWind('12315G54KT').gust, 54);
  });

  test('Test too many matches', () {
    var err = 'Too many matches were found by RegEx `RegExp: '
        'pattern=G(?<gust>\\d{2,3}) flags=` in report wind section `G16 G15`';

    expect(
        () => ReportWind('G16 G15').gust,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });
}

void reportWindDirectionVrbRangeStart() {
  test('Test correct wind no variable range recognition', () {
    expect(ReportWind('12315KT').directionVrbRangeStart, null);
  });

  test('Test correct wind variable range recognition, three zeros', () {
    expect(ReportWind('12315G54KT 000V060').directionVrbRangeStart, 0);
  });

  test('Test correct wind variable range recognition, two zeros', () {
    expect(ReportWind('12315G54KT 005V065').directionVrbRangeStart, 5);
  });

  test('Test correct wind variable range recognition, one zero', () {
    expect(ReportWind('12315G54KT 015V075').directionVrbRangeStart, 15);
  });

  test('Test correct wind variable range recognition, no zeros', () {
    expect(ReportWind('12315G54KT 115V175').directionVrbRangeStart, 115);
  });

  test('Test too many matches', () {
    var err = 'Too many matches were found by RegEx `RegExp: '
        'pattern=(?<vrb_range_start>\\d{3})V flags=` in report wind section'
        ' `010V070 120V180`';

    expect(
        () => ReportWind('010V070 120V180').directionVrbRangeStart,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });

  test('Test upper limit of vrb direction', () {
    var err = 'Report vrb_range_start value must be within [0; 359] range, '
        'provided: `400` from `360010KT 400V460`';

    expect(
        () => ReportWind('360010KT 400V460').directionVrbRangeStart,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });
}

void reportWindDirectionVrbRangeEnd() {
  test('Test correct wind no variable range recognition', () {
    expect(ReportWind('12315KT').directionVrbRangeEnd, null);
  });

  test('Test correct wind variable range recognition, three zeros', () {
    expect(ReportWind('12315G54KT 300V000').directionVrbRangeEnd, 0);
  });

  test('Test correct wind variable range recognition, two zeros', () {
    expect(ReportWind('12315G54KT 305V005').directionVrbRangeEnd, 5);
  });

  test('Test correct wind variable range recognition, one zero', () {
    expect(ReportWind('12315G54KT 315V015').directionVrbRangeEnd, 15);
  });

  test('Test correct wind variable range recognition, no zeros', () {
    expect(ReportWind('12315G54KT 115V175').directionVrbRangeEnd, 175);
  });

  test('Test too many matches', () {
    var err = 'Too many matches were found by RegEx `RegExp: '
        'pattern=V(?<vrb_range_end>\\d{3}) flags=` in report wind section'
        ' `010V070 120V180`';

    expect(
        () => ReportWind('010V070 120V180').directionVrbRangeEnd,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });

  test('Test upper limit of vrb direction', () {
    var err = 'Report vrb_range_end value must be within [0; 359] range, '
        'provided: `460` from `360010KT 400V460`';

    expect(
        () => ReportWind('360010KT 400V460').directionVrbRangeEnd,
        throwsA(
            predicate((e) => e is ReportWindException && e.message == err)));
  });
}

void reportWindEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final wind1 = '00000KT';
    final wind2 = '00010KT';

    expect(ReportWind(wind1) == ReportWind(wind2), false);
  });

  test('Test equality operator for equality', () {
    final wind1 = '10010KT';
    final wind2 = '10010KT';

    expect(ReportWind(wind1) == ReportWind(wind2), true);
  });
}

void reportWindHashCode() {
  test('Test hash generation for non-equality', () {
    final wind1 = '00000KT';
    final wind2 = '00010KT';

    expect(ReportWind(wind1).hashCode == ReportWind(wind2).hashCode, false);
  });

  test('Test hash generation for equality', () {
    final wind1 = '10010KT';
    final wind2 = '10010KT';

    expect(ReportWind(wind1).hashCode == ReportWind(wind2).hashCode, true);
  });
}

void reportWindToString() {
  test('Test calm wind', () {
    expect(ReportWind('00000KT').toString(), '00000KT');
  });
  test('Test one-symbol velocity wind', () {
    expect(ReportWind('10008KT').toString(), '10008KT');
  });
  test('Test two-symbol velocity wind', () {
    expect(ReportWind('10088KT').toString(), '10088KT');
  });
  test('Test three-symbol velocity wind', () {
    expect(ReportWind('100888KT').toString(), '100888KT');
  });
  test('Test one-symbol direction wind', () {
    expect(ReportWind('00205KT').toString(), '00205KT');
  });
  test('Test two-symbol direction wind', () {
    expect(ReportWind('02005KT').toString(), '02005KT');
  });
  test('Test three-symbol direction wind', () {
    expect(ReportWind('20005KT').toString(), '20005KT');
  });
  test('Test one-symbol gust wind', () {
    expect(ReportWind('10005G09KT').toString(), '10005G09KT');
  });
  test('Test two-symbol gust wind', () {
    expect(ReportWind('10005G90KT').toString(), '10005G90KT');
  });
  test('Test three-symbol gust wind', () {
    expect(ReportWind('10005G900KT').toString(), '10005G900KT');
  });
  test('Test variable wind', () {
    expect(ReportWind('10005KT 070V130').toString(), '10005KT 070V130');
  });
  test('Test variable light wind', () {
    expect(ReportWind('VRB06KT').toString(), 'VRB06KT');
  });
  test('Test variable gust wind', () {
    expect(ReportWind('03015G25KT 000V060').toString(), '03015G25KT 000V060');
  });
}
