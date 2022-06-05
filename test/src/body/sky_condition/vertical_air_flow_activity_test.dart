import 'package:metar/src/body/sky_condition/vertical_air_flow_activity.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('VerticalAirFlowActivity', () {
    group('factory', () {
      verticalAirFlowActivityFactory();
    });
    group('toString', () {
      verticalAirFlowActivityToString();
    });
  });
}

void verticalAirFlowActivityFactory() {
  test('Test constructor with unexpected long input', () {
    var err = 'Sky condition group vertical air flow activity must have 2 or 3 '
        'non-space characters length if present, provided `SOME`';
    expectFormatException(() => VerticalAirFlowActivity('SOME'), err);
  });

  test('Test constructor with unexpected short input', () {
    var err = 'Sky condition group vertical air flow activity must have 2 or 3 '
        'non-space characters length if present, provided `V`';
    expectFormatException(() => VerticalAirFlowActivity('V'), err);
  });

  test('Test constructor with unexpected input correct length', () {
    var err = 'Unexpected sky condition group vertical flow activity, '
        'provided: `VCC`, error: `Bad state: No element`';
    expectFormatException(() => VerticalAirFlowActivity('VCC'), err);
  });

  test('Test constructor with null vertical visibility string input', () {
    expect(VerticalAirFlowActivity(null), VerticalAirFlowActivity.none);
  });

  test('Test constructor with empty vertical visibility string input', () {
    expect(VerticalAirFlowActivity(''), VerticalAirFlowActivity.none);
  });

  test('Test constructor with cumulonimbus string input', () {
    expect(VerticalAirFlowActivity('CB'), VerticalAirFlowActivity.cumulonimbus);
  });

  test('Test constructor with towering cumulus string input', () {
    expect(VerticalAirFlowActivity('TCU'),
        VerticalAirFlowActivity.toweringCumulus);
  });
}

void verticalAirFlowActivityToString() {
  test('Test string representation of no vertical air flow', () {
    expect(VerticalAirFlowActivity.none.toString(), '');
  });

  test('Test string representation of cumulonimbus vertical air flow', () {
    expect(VerticalAirFlowActivity.cumulonimbus.toString(), 'CB');
  });

  test('Test string representation of towering cumulus vertical air flow', () {
    expect(VerticalAirFlowActivity.toweringCumulus.toString(), 'TCU');
  });
}
