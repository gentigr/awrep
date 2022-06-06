import 'package:metar/src/body/sky_condition/sky_cover.dart';
import 'package:metar/src/body/sky_condition/vertical_air_flow_activity.dart';
import 'package:metar/src/common/regexp_decorator.dart';

/// The class represents sky condition group of a [Metar].
class SkyCondition {
  final String _skyCondition;

  /// Constructs a [SkyCondition] object from string representation.
  ///
  /// Provided string is in NsNsNsHsHsHs or VVHsHsHs or SKC/CLR format, where
  /// NsNsNs is the amount of sky cover,
  /// HsHsHs is the height of the layer,
  /// VV is the vertical visibility.
  /// WARN: special case NsNsNsHs is covered here, but not with specification.
  /// Throws [FormatException] if the provided value is not comply with format.
  SkyCondition(this._skyCondition) {
    var regExp =
        RegExpDecorator('((VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?)');
    regExp.verifySingleMatch(_skyCondition, this.runtimeType.toString());
  }

  /// The sky cover of a sky condition group.
  SkyCover get skyCover {
    var regExp = RegExpDecorator('^(?<sky_cover>VV|SKC|CLR|FEW|SCT|BKN|OVC)');
    return SkyCover(regExp.getMatchByName(_skyCondition, 'sky_cover'));
  }

  /// The height of sky cover of a sky condition group.
  int? get height {
    var regExp = RegExpDecorator('(?<height>\\d{1,3})');
    var value = regExp.getMatchByNameOptional(_skyCondition, 'height');
    if (value == null) {
      return null;
    }
    return int.parse(value) * 100;
  }

  /// The vertical air flow activity of a sky condition group.
  VerticalAirFlowActivity get verticalAirFlowActivity {
    var regExp = RegExpDecorator('(?<vertical_flow>CB|TCU)\$');
    return VerticalAirFlowActivity(
        regExp.getMatchByNameOptional(_skyCondition, 'vertical_flow'));
  }

  @override
  String toString() {
    String heightStr = '';
    if (height != null) {
      heightStr = (height! ~/ 100).toString().padLeft(_heightGroupWidth, '0');
    }
    return '$skyCover$heightStr$verticalAirFlowActivity';
  }

  @override
  bool operator ==(Object other) {
    return other is SkyCondition && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _skyCondition.hashCode;

  /// The width of height group of sky condition group.
  ///
  /// METAR can be reported with one digit which determines height, such as 0,
  /// however in other scenario it is reported with 000, so the possible cases
  /// are FEW0 and FEW000, in order to reproduce the same METAR that it used to
  /// be during the creation (primarily to verify that everything is parsed
  /// properly in integration test) it is necessary to handle both cases and
  /// reproduce METAR record accordingly.
  /// WARN: this is special case not covered by specification, the proper format
  /// is considered to be NsNsNsHsHsHs
  int get _heightGroupWidth {
    return _skyCondition.length -
        skyCover.toString().length -
        verticalAirFlowActivity.toString().length;
  }
}
