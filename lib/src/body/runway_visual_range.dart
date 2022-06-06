import 'package:metar/src/common/regexp_decorator.dart';
import 'package:metar/src/common/runway.dart';
import 'package:metar/src/common/visual_range.dart';

// TODO: combine parsing of ReportVisibility and visual range
// Both are following similar RegExp, such as [M|P]\d{4}

/// The class represents runway visual range group within [Metar].
class RunwayVisualRange {
  final String _runwayVisualRange;

  /// Constructs a [RunwayVisualRange] from string representation.
  ///
  /// Provided string should be in RDrDr/VrVrVrVrFT or RDrDr/VnVnVnVnVVxVxVxVxFT
  /// format to be parsed properly, where DrDr is runway number, Vn/x is a
  /// digital representation of range.
  /// Throws [FormatException] if the provided value is not by format.
  RunwayVisualRange(this._runwayVisualRange) {
    var expr = RegExpDecorator(
        '^(R\\d{2}[LCR]?\\/[M|P]?\\d{4}(VP?\\d{4})?FT)|(RVRNO)\$');
    expr.verifySingleMatch(_runwayVisualRange, this.runtimeType.toString());
  }

  /// The runway for which the visual range group is reported.
  ///
  /// Returns null when runway visual range equipment is present, but
  /// information is not available (RVRNO code)
  Runway? get runway {
    var regExp = RegExpDecorator('^R(?<runway>(\\d{2}[LCR]?)|(VRNO))');
    var value = regExp.getMatchByName(_runwayVisualRange, 'runway');
    if (value == 'VRNO') {
      return null;
    }
    return Runway(value);
  }

  /// The runway visual range descriptor.
  ///
  /// Returns null when runway visual range equipment is present, but
  /// information is not available (RVRNO code)
  VisualRange? get visualRange {
    var regExp =
        RegExpDecorator('(?<range>([M|P]?\\d{4}(VP?\\d{4})?FT)|(RVRNO))\$');
    var value = regExp.getMatchByName(_runwayVisualRange, 'range');
    if (value == 'RVRNO') {
      return null;
    }
    return VisualRange(regExp.getMatchByName(_runwayVisualRange, 'range'));
  }

  @override
  String toString() {
    if (runway == null && visualRange == null) {
      return 'RVRNO';
    }
    return 'R$runway/$visualRange';
  }

  @override
  bool operator ==(Object other) {
    return other is RunwayVisualRange && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _runwayVisualRange.hashCode;
}
