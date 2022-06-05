import 'package:metar/src/common/regexp_decorator.dart';
import 'package:metar/src/common/temperature.dart';

/// The class represents temperature/dew point group within [Metar].
class TemperatureDewPointGroup {
  final String _temperatureDewPointGroup;

  /// Constructs a [TemperatureDewPointGroup] from string representation.
  ///
  /// Provided string should be in QDD/QDD or QDD/ formats to be parsed
  /// properly, where Q is a temperature qualifier, DD is a temperature.
  /// Throws [FormatException] if the provided value is not by format.
  TemperatureDewPointGroup(this._temperatureDewPointGroup) {
    var regExp = RegExpDecorator('^(M?\\d{2}\\/(M?\\d{2})?)\$');
    regExp.verifySingleMatch(
        _temperatureDewPointGroup, this.runtimeType.toString());
  }

  /// The reported temperature.
  Temperature get temperature {
    var regExp = RegExpDecorator('^(?<temperature>M?\\d{2})');
    return Temperature(
        regExp.getMatchByName(_temperatureDewPointGroup, 'temperature'));
  }

  /// The reported dew point.
  Temperature? get dewPoint {
    var regExp = RegExpDecorator('(?<dew_point>M?\\d{2})\$');
    var value =
        regExp.getMatchByNameOptional(_temperatureDewPointGroup, 'dew_point');
    if (value == null) {
      return null;
    }
    return Temperature(value);
  }

  @override
  String toString() {
    return '$temperature/${dewPoint?.toString() ?? ''}';
  }

  @override
  bool operator ==(Object other) {
    return other is TemperatureDewPointGroup && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _temperatureDewPointGroup.hashCode;
}
