import 'package:metar/src/body/present_weather_group/phenomena/obscuration.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('Obscuration', () {
    group('factory', () {
      obscurationFactory();
    });
    group('toString', () {
      obscurationToString();
    });
  });
}

void obscurationFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group obscuration must have 2 non-space '
        'characters length if not empty, provided `SOME`';
    expectFormatException(() => Obscuration('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Present weather group obscuration must have 2 non-space '
        'characters length if not empty, provided `V`';
    expectFormatException(() => Obscuration('V'), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected present weather group obscuration weather '
        'phenomena, provided: `VC`, error: `Bad state: No element`';
    expectFormatException(() => Obscuration('VC'), err);
  });

  test('Test constructor with empty string input', () {
    expect(Obscuration(''), Obscuration.none);
  });

  test('Test constructor with null string input', () {
    expect(Obscuration(null), Obscuration.none);
  });

  test('Test constructor with mist string input', () {
    expect(Obscuration('BR'), Obscuration.mist);
  });

  test('Test constructor with fog string input', () {
    expect(Obscuration('FG'), Obscuration.fog);
  });

  test('Test constructor with smoke string input', () {
    expect(Obscuration('FU'), Obscuration.smoke);
  });

  test('Test constructor with volcanic ash string input', () {
    expect(Obscuration('VA'), Obscuration.volcanicAsh);
  });

  test('Test constructor with widespread dust string input', () {
    expect(Obscuration('DU'), Obscuration.widespreadDust);
  });

  test('Test constructor with sand string input', () {
    expect(Obscuration('SA'), Obscuration.sand);
  });

  test('Test constructor with haze string input', () {
    expect(Obscuration('HZ'), Obscuration.haze);
  });

  test('Test constructor with spray string input', () {
    expect(Obscuration('PY'), Obscuration.spray);
  });
}

void obscurationToString() {
  test('Test string representation of local or point obscuration', () {
    expect(Obscuration.none.toString().isEmpty, true);
  });

  test('Test string representation of mist obscuration', () {
    expect(Obscuration.mist.toString(), 'BR');
  });

  test('Test string representation of fog obscuration', () {
    expect(Obscuration.fog.toString(), 'FG');
  });

  test('Test string representation of smoke obscuration', () {
    expect(Obscuration.smoke.toString(), 'FU');
  });

  test('Test string representation of volcanic ash obscuration', () {
    expect(Obscuration.volcanicAsh.toString(), 'VA');
  });

  test('Test string representation of widespread dust obscuration', () {
    expect(Obscuration.widespreadDust.toString(), 'DU');
  });

  test('Test string representation of sand obscuration', () {
    expect(Obscuration.sand.toString(), 'SA');
  });

  test('Test string representation of haze obscuration', () {
    expect(Obscuration.haze.toString(), 'HZ');
  });

  test('Test string representation of spray obscuration', () {
    expect(Obscuration.spray.toString(), 'PY');
  });
}
