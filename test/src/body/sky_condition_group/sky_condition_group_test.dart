import 'package:metar/src/body/sky_condition_group/sky_condition_group.dart';
import 'package:metar/src/body/sky_condition_group/sky_cover.dart';
import 'package:metar/src/body/sky_condition_group/vertical_air_flow_activity.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('SkyConditionGroup', () {
    group('constructor', () {
      skyConditionGroupConstructor();
    });
    group('skyCover', () {
      skyConditionGroupSkyCover();
    });
    group('height', () {
      skyConditionGroupHeight();
    });
    group('verticalAirFlowActivity', () {
      skyConditionGroupVerticalAirFlowActivity();
    });
    group('toString', () {
      skyConditionGroupToString();
    });
    group('equalityOperator', () {
      skyConditionGroupEqualityOperator();
    });
    group('hashCode', () {
      skyConditionGroupHashCode();
    });
  });
}

void skyConditionGroupConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `SkyConditionGroup` format in '
        '`SK`, but found `0` using `RegExp: '
        'pattern=((VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?) flags=`';
    expectFormatException(() => SkyConditionGroup('SK'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `SkyConditionGroup` format in '
        '`SKC CLR`, but found `2` using `RegExp: '
        'pattern=((VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?) flags=`';
    expectFormatException(() => SkyConditionGroup('SKC CLR'), err);
  });

  test('Test compliance with format, positive', () {
    expect(SkyConditionGroup('FEW005'), isA<SkyConditionGroup>());
  });
}

void skyConditionGroupSkyCover() {
  test('Test clear cover', () {
    expect(SkyConditionGroup('CLR').skyCover, SkyCover('CLR'));
  });

  test('Test vertical visibility cover', () {
    expect(SkyConditionGroup('VV010').skyCover, SkyCover.verticalVisibility);
  });

  test('Test scattered with cumulonimbus', () {
    expect(SkyConditionGroup('SCT015CB').skyCover, SkyCover.scattered);
  });
}

void skyConditionGroupHeight() {
  test('Test no height', () {
    expect(SkyConditionGroup('CLR').height, null);
  });

  test('Test vertical visibility cover height', () {
    expect(SkyConditionGroup('VV010').height, 1000);
  });

  test('Test scattered with cumulonimbus height', () {
    expect(SkyConditionGroup('SCT015CB').height, 1500);
  });
}

void skyConditionGroupVerticalAirFlowActivity() {
  test('Test no vertical flow activity 1 combination', () {
    expect(SkyConditionGroup('CLR').verticalAirFlowActivity,
        VerticalAirFlowActivity.none);
  });

  test('Test no vertical flow activity 2 combination', () {
    expect(SkyConditionGroup('VV010').verticalAirFlowActivity,
        VerticalAirFlowActivity.none);
  });

  test('Test scattered with cumulonimbus towering cumulus activity', () {
    expect(SkyConditionGroup('SCT015TCU').verticalAirFlowActivity,
        VerticalAirFlowActivity.toweringCumulus);
  });
}

void skyConditionGroupToString() {
  test('Test combination 1', () {
    expect(SkyConditionGroup('SKC').toString(), 'SKC');
  });

  test('Test combination 2', () {
    expect(SkyConditionGroup('VV001').toString(), 'VV001');
  });

  test('Test combination 3', () {
    expect(SkyConditionGroup('SCT150TCU').toString(), 'SCT150TCU');
  });

  test('Test combination 4', () {
    expect(SkyConditionGroup('VV010CB').toString(), 'VV010CB');
  });
}

void skyConditionGroupEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(SkyConditionGroup('SCT150TCU') == SkyConditionGroup('FEW150TCU'),
        false);
  });

  test('Test equality operator for equality', () {
    expect(
        SkyConditionGroup('SCT150TCU') == SkyConditionGroup('SCT150TCU'), true);
  });
}

void skyConditionGroupHashCode() {
  test('Test hash generation for non-equality', () {
    expect(
        SkyConditionGroup('SCT150TCU').hashCode ==
            SkyConditionGroup('SCT150CB').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        SkyConditionGroup('SCT150TCU').hashCode ==
            SkyConditionGroup('SCT150TCU').hashCode,
        true);
  });
}
