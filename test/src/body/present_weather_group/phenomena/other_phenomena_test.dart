import 'package:metar/src/body/present_weather_group/phenomena/other_phenomena.dart';
import 'package:test/test.dart';

import '../../../../test_utils.dart';

void main() {
  group('OtherPhenomena', () {
    group('factory', () {
      otherPhenomenaFactory();
    });
    group('toString', () {
      otherPhenomenaToString();
    });
  });
}

void otherPhenomenaFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Present weather group other phenomena must have 2 non-space '
        'characters length if not empty, provided `SOME`';
    expectFormatException(() => OtherPhenomena('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Present weather group other phenomena must have 2 non-space '
        'characters length if not empty, provided `V`';
    expectFormatException(() => OtherPhenomena('V'), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected present weather group other phenomena weather '
        'phenomena, provided: `VC`, error: `Bad state: No element`';
    expectFormatException(() => OtherPhenomena('VC'), err);
  });

  test('Test constructor with empty string input', () {
    expect(OtherPhenomena(''), OtherPhenomena.none);
  });

  test('Test constructor with null string input', () {
    expect(OtherPhenomena(null), OtherPhenomena.none);
  });

  test('Test constructor with whirls string input', () {
    expect(OtherPhenomena('PO'), OtherPhenomena.whirls);
  });

  test('Test constructor with squalls string input', () {
    expect(OtherPhenomena('SQ'), OtherPhenomena.squalls);
  });

  test('Test constructor with funnel cloud string input', () {
    expect(OtherPhenomena('FC'), OtherPhenomena.funnelCloud);
  });

  test('Test constructor with sandstorm string input', () {
    expect(OtherPhenomena('SS'), OtherPhenomena.sandstorm);
  });

  test('Test constructor with duststorm string input', () {
    expect(OtherPhenomena('DS'), OtherPhenomena.duststorm);
  });
}

void otherPhenomenaToString() {
  test('Test string representation of local or point other phenomena', () {
    expect(OtherPhenomena.none.toString().isEmpty, true);
  });

  test('Test string representation of whirls other phenomena', () {
    expect(OtherPhenomena.whirls.toString(), 'PO');
  });

  test('Test string representation of squalls other phenomena', () {
    expect(OtherPhenomena.squalls.toString(), 'SQ');
  });

  test('Test string representation of funnelCloud other phenomena', () {
    expect(OtherPhenomena.funnelCloud.toString(), 'FC');
  });

  test('Test string representation of sandstorm grains other phenomena', () {
    expect(OtherPhenomena.sandstorm.toString(), 'SS');
  });

  test('Test string representation of duststorm other phenomena', () {
    expect(OtherPhenomena.duststorm.toString(), 'DS');
  });
}
