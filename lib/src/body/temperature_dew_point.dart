import 'package:metar/src/common/regexp_decorator.dart';
import 'package:metar/src/common/temperature.dart';

/// The class represents temperature/dew point group within [Metar].
class TemperatureDewPoint {
  final String _temperatureDewPoint;

  /// Constructs a [TemperatureDewPoint] from string representation.
  ///
  /// Provided string should be in QDD/QDD or QDD/ formats to be parsed
  /// properly, where Q is a temperature qualifier, DD is a temperature.
  /// Throws [FormatException] if the provided value is not by format.
  TemperatureDewPoint(this._temperatureDewPoint) {
    var regExp = RegExpDecorator('^(M?\\d{2}\\/(M?\\d{2})?)\$');
    regExp.verifySingleMatch(_temperatureDewPoint, this.runtimeType.toString());
  }

  /// The reported temperature.
  Temperature get temperature {
    var regExp = RegExpDecorator('^(?<temperature>M?\\d{2})');
    return Temperature(
        regExp.getMatchByName(_temperatureDewPoint, 'temperature'));
  }

  /// The reported dew point.
  Temperature? get dewPoint {
    var regExp = RegExpDecorator('(?<dew_point>M?\\d{2})\$');
    var value =
        regExp.getMatchByNameOptional(_temperatureDewPoint, 'dew_point');
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
    return other is TemperatureDewPoint && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _temperatureDewPoint.hashCode;
}
