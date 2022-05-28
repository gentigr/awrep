import 'regexp_decorator.dart';
import 'runway_approach_direction.dart';
import 'runway_number.dart';

/// The class represents runway identification used within [Report].
class Runway {
  final String _runway;

  /// Constructs a [Runway] from string representation.
  ///
  /// Provided string is in DDA format, where DD is a digital representation of
  /// runway number, and A is a [RunwayApproachDirection] if present.
  /// Throws [FormatException] if the provided value is not within described
  /// format.
  Runway(this._runway) {
    var regExp = RegExpDecorator('^\\d{2}[L|C|R]?\$');
    regExp.verifySingleMatch(_runway, this.runtimeType.toString());
  }

  /// Returns runway number.
  RunwayNumber get number {
    var regExp = RegExpDecorator('^(?<number>\\d{2})');
    var runway = regExp.getMatchByName(_runway, 'number');
    return RunwayNumber.fromString(runway);
  }

  /// Returns runway approach direction.
  RunwayApproachDirection get direction {
    var regExp = RegExpDecorator('(?<direction>[L|C|R])\$');
    var direction = regExp.getMatchByNameOptional(_runway, 'direction');
    return RunwayApproachDirection(direction);
  }

  @override
  String toString() {
    return '${number.toString()}${direction.toString()}';
  }

  @override
  bool operator ==(Object other) {
    return other is Runway && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _runway.hashCode;
}
