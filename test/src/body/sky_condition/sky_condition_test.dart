import 'package:metar/src/body/sky_condition/sky_condition.dart';
import 'package:metar/src/body/sky_condition/sky_cover.dart';
import 'package:metar/src/body/sky_condition/vertical_air_flow_activity.dart';
import 'package:test/test.dart';

import '../../../test_utils.dart';

void main() {
  group('SkyCondition', () {
    group('constructor', () {
      skyConditionConstructor();
    });
    group('skyCover', () {
      skyConditionSkyCover();
    });
    group('height', () {
      skyConditionHeight();
    });
    group('verticalAirFlowActivity', () {
      skyConditionVerticalAirFlowActivity();
    });
    group('toString', () {
      skyConditionToString();
    });
    group('equalityOperator', () {
      skyConditionEqualityOperator();
    });
    group('hashCode', () {
      skyConditionHashCode();
    });
  });
}

void skyConditionConstructor() {
  test('Test compliance with format, negative', () {
    var err = 'Expected to find one match of `SkyCondition` format in '
        '`SK`, but found `0` using `RegExp: '
        'pattern=((VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?) flags=`';
    expectFormatException(() => SkyCondition('SK'), err);
  });

  test('Test compliance with format, negative with multiple', () {
    var err = 'Expected to find one match of `SkyCondition` format in '
        '`SKC CLR`, but found `2` using `RegExp: '
        'pattern=((VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?) flags=`';
    expectFormatException(() => SkyCondition('SKC CLR'), err);
  });

  test('Test compliance with format, positive', () {
    expect(SkyCondition('FEW005'), isA<SkyCondition>());
  });
}

void skyConditionSkyCover() {
  test('Test clear cover', () {
    expect(SkyCondition('CLR').skyCover, SkyCover('CLR'));
  });

  test('Test vertical visibility cover', () {
    expect(SkyCondition('VV010').skyCover, SkyCover.verticalVisibility);
  });

  test('Test scattered with cumulonimbus', () {
    expect(SkyCondition('SCT015CB').skyCover, SkyCover.scattered);
  });
}

void skyConditionHeight() {
  test('Test no height', () {
    expect(SkyCondition('CLR').height, null);
  });

  test('Test vertical visibility cover height', () {
    expect(SkyCondition('VV010').height, 1000);
  });

  test('Test scattered with cumulonimbus height', () {
    expect(SkyCondition('SCT015CB').height, 1500);
  });
}

void skyConditionVerticalAirFlowActivity() {
  test('Test no vertical flow activity 1 combination', () {
    expect(SkyCondition('CLR').verticalAirFlowActivity,
        VerticalAirFlowActivity.none);
  });

  test('Test no vertical flow activity 2 combination', () {
    expect(SkyCondition('VV010').verticalAirFlowActivity,
        VerticalAirFlowActivity.none);
  });

  test('Test scattered with cumulonimbus towering cumulus activity', () {
    expect(SkyCondition('SCT015TCU').verticalAirFlowActivity,
        VerticalAirFlowActivity.toweringCumulus);
  });
}

void skyConditionToString() {
  test('Test combination 1', () {
    expect(SkyCondition('SKC').toString(), 'SKC');
  });

  test('Test combination 2', () {
    expect(SkyCondition('VV001').toString(), 'VV001');
  });

  test('Test combination 3', () {
    expect(SkyCondition('SCT150TCU').toString(), 'SCT150TCU');
  });

  test('Test combination 4', () {
    expect(SkyCondition('VV010CB').toString(), 'VV010CB');
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test combination 5', () {
    expect(SkyCondition('BKN0').toString(), 'BKN0');
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test combination 6', () {
    expect(SkyCondition('FEW000').toString(), 'FEW000');
  });

  // WARN: special case not covered by specification, but reported in reality
  test('Test combination 7', () {
    expect(SkyCondition('VV0').toString(), 'VV0');
  });
}

void skyConditionEqualityOperator() {
  test('Test equality operator for non-equality', () {
    expect(SkyCondition('SCT150TCU') == SkyCondition('FEW150TCU'), false);
  });

  test('Test equality operator for equality', () {
    expect(SkyCondition('SCT150TCU') == SkyCondition('SCT150TCU'), true);
  });
}

void skyConditionHashCode() {
  test('Test hash generation for non-equality', () {
    expect(
        SkyCondition('SCT150TCU').hashCode == SkyCondition('SCT150CB').hashCode,
        false);
  });

  test('Test hash generation for equality', () {
    expect(
        SkyCondition('SCT150TCU').hashCode ==
            SkyCondition('SCT150TCU').hashCode,
        true);
  });
}
