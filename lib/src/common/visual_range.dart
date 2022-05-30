import 'distance_qualifier.dart';
import 'regexp_decorator.dart';

/// The class represents visual range used within [Report].
class VisualRange {
  final String _visualRange;

  /// Constructs a [VisualRange] from string representation.
  ///
  /// Provided string is in DDDDFT format, where DDDD is a digital
  /// representation of visual range distance.
  /// Throws [FormatException] if the provided value is not by format.
  VisualRange(this._visualRange) {
    var regExp = RegExpDecorator('^[M|P]?\\d{4}FT\$');
    regExp.verifySingleMatch(_visualRange, this.runtimeType.toString());
  }

  /// The visual range distance.
  int get distance {
    var regExp = RegExpDecorator('(?<distance>\\d{4})FT\$');
    var range = regExp.getMatchByName(_visualRange, 'distance');
    return int.parse(range);
  }

  /// The visual range qualifier.
  DistanceQualifier get qualifier {
    var regExp = RegExpDecorator('^(?<qualifier>[M|P])');
    var qualifier = regExp.getMatchByNameOptional(_visualRange, 'qualifier');
    return DistanceQualifier(qualifier);
  }

  @override
  String toString() {
    return '${qualifier.toString()}${distance.toString().padLeft(4, '0')}FT';
  }

  @override
  bool operator ==(Object other) {
    return other is VisualRange && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _visualRange.hashCode;
}
