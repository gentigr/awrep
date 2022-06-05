import 'package:metar/src/common/regexp_decorator.dart';
import 'package:metar/src/common/temperature_qualifier.dart';

/// The class represents temperature.
class Temperature {
  final String _temperature;

  /// Constructs [Temperature] object from string representation.
  ///
  /// Throws [FormatException] if the provided value is not within described
  /// format.
  Temperature(this._temperature) {
    var regExp = RegExpDecorator('^M?\\d{2}\$');
    regExp.verifySingleMatch(_temperature, this.runtimeType.toString());
  }

  /// The temperature representation using integer type.
  int get asInteger {
    var regExp = RegExpDecorator('^M?(?<temperature>\\d{2})\$');
    int value = int.parse(regExp.getMatchByName(_temperature, 'temperature'));
    if (qualifier == TemperatureQualifier.minus) {
      value *= -1;
    }
    return value;
  }

  TemperatureQualifier get qualifier {
    var regExp = RegExpDecorator('^(?<qualifier>M)');
    return TemperatureQualifier(
        regExp.getMatchByNameOptional(_temperature, 'qualifier'));
  }

  @override
  String toString() {
    return '$qualifier${asInteger.abs().toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) {
    return other is Temperature && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _temperature.hashCode;
}
