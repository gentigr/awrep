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
    var regExp = RegExpDecorator('(?<height>\\d{3})');
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
      heightStr = (height! ~/ 100).toString().padLeft(3, '0');
    }
    return '$skyCover$heightStr$verticalAirFlowActivity';
  }

  @override
  bool operator ==(Object other) {
    return other is SkyCondition && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _skyCondition.hashCode;
}
