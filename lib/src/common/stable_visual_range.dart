import 'package:metar/src/common/distance_qualifier.dart';
import 'package:metar/src/common/regexp_decorator.dart';
import 'package:metar/src/common/visual_range.dart';

/// The class represents stable visual range used within [Metar].
class StableVisualRange implements VisualRange {
  final String _stableVisualRange;

  /// Constructs a [StableVisualRange] from string representation.
  ///
  /// Provided string is in DDDDFT format, where DDDD is a digital
  /// representation of visual range distance.
  /// Throws [FormatException] if the provided value is not by format.
  StableVisualRange(this._stableVisualRange) {
    var regExp = RegExpDecorator('^[M|P]?\\d{4}FT\$');
    regExp.verifySingleMatch(_stableVisualRange, this.runtimeType.toString());
  }

  /// The visual range distance.
  int get distance {
    var regExp = RegExpDecorator('(?<distance>\\d{4})FT\$');
    var range = regExp.getMatchByName(_stableVisualRange, 'distance');
    return int.parse(range);
  }

  /// The visual range qualifier.
  DistanceQualifier get qualifier {
    var regExp = RegExpDecorator('^(?<qualifier>[M|P])');
    var qualifier =
        regExp.getMatchByNameOptional(_stableVisualRange, 'qualifier');
    return DistanceQualifier(qualifier);
  }

  @override
  int get highestDistance => distance;

  @override
  DistanceQualifier get highestQualifier => qualifier;

  @override
  int get lowestDistance => distance;

  @override
  DistanceQualifier get lowestQualifier => qualifier;

  @override
  String toString() {
    return '$qualifier${distance.toString().padLeft(4, '0')}FT';
  }

  @override
  bool operator ==(Object other) {
    return other is StableVisualRange && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _stableVisualRange.hashCode;
}
