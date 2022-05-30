import 'distance_qualifier.dart';
import 'regexp_decorator.dart';

/// The class represents varying visual range used within [Report].
class VaryingVisualRange {
  final String _varyingVisualRange;

  /// Constructs a [VaryingVisualRange] from string representation.
  ///
  /// Provided string is in QnDnDnDnDnVQxDxDxDxDxFT format, where
  /// DDDD is a digital representation of visual range distance,
  /// Q is a qualifier,
  /// V separates lowest and highest visual range values.
  /// Throws [FormatException] if the provided value is not by format.
  VaryingVisualRange(this._varyingVisualRange) {
    var regExp = RegExpDecorator('^(M?(\\d{4})VP?(\\d{4}))FT\$');
    regExp.verifySingleMatch(_varyingVisualRange, this.runtimeType.toString());
  }

  /// The lowest visual range distance.
  int get lowestDistance {
    var regExp = RegExpDecorator('^M?(?<distance>\\d{4})');
    var range = regExp.getMatchByName(_varyingVisualRange, 'distance');
    return int.parse(range);
  }

  /// The lowest visual range qualifier.
  DistanceQualifier get lowestQualifier {
    var regExp = RegExpDecorator('^(?<qualifier>M)');
    var qualifier =
        regExp.getMatchByNameOptional(_varyingVisualRange, 'qualifier');
    return DistanceQualifier(qualifier);
  }

  /// The highest visual range distance.
  int get highestDistance {
    var regExp = RegExpDecorator('VP?(?<distance>\\d{4})FT\$');
    var range = regExp.getMatchByName(_varyingVisualRange, 'distance');
    return int.parse(range);
  }

  /// The highest visual range qualifier.
  DistanceQualifier get highestQualifier {
    var regExp = RegExpDecorator('V(?<qualifier>P)?(\\d{4})FT\$');
    var qualifier =
        regExp.getMatchByNameOptional(_varyingVisualRange, 'qualifier');
    return DistanceQualifier(qualifier);
  }

  @override
  String toString() {
    String lowestStr = _format(lowestQualifier, lowestDistance);
    String highestStr = _format(highestQualifier, highestDistance);
    return '${lowestStr}V${highestStr}FT';
  }

  @override
  bool operator ==(Object other) {
    return other is VaryingVisualRange && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _varyingVisualRange.hashCode;

  static String _format(DistanceQualifier qualifier, int distance) {
    return '${qualifier.toString()}${distance.toString().padLeft(4, '0')}';
  }
}
