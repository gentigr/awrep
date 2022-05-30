import 'package:fraction/fraction.dart';

import '../common/distance_qualifier.dart';
import '../common/regexp_decorator.dart';

/// The class represents visibility group description within [Report].
class Visibility {
  final String _visibility;

  /// Constructs a [Visibility] from string representation.
  ///
  /// Provided string should be in VVVVVSM format to be parsed properly, where
  /// VVVVV is a distance in fraction or whole.
  /// Throws [FormatException] if the provided value is not by format.
  Visibility(this._visibility) {
    var regExp = RegExpDecorator('^([MP])?([0-9 \\/]{1,5})SM\$');
    regExp.verifySingleMatch(_visibility, this.runtimeType.toString());
  }

  /// The reported visibility distance.
  double get distance {
    var regExp = RegExpDecorator('^([MP]{1})?(?<whole>[0-9]{1,5})? ?'
        '((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM');
    var whole = regExp.getMatchByNameOptional(_visibility, 'whole');
    var fraction = regExp.getMatchByNameOptional(_visibility, 'fraction');

    if (whole == null && fraction == null) {
      throw FormatException('Either whole or fraction must be present in '
          'visibility section, neither field was found by RegEx `$regExp` '
          'in report visibility section `$_visibility`');
    }

    return Fraction.fromString(whole ?? '0').toDouble() +
        Fraction.fromString(fraction ?? '0').toDouble();
  }

  /// The reported visibility distance qualifier.
  ///
  /// Returns values such as `less than`, `more than` or `none`.
  DistanceQualifier get qualifier {
    var regExp = RegExpDecorator('^(?<qualifier>[PM]{1})');
    var qualifier = regExp.getMatchByNameOptional(_visibility, 'qualifier');
    return DistanceQualifier(qualifier);
  }

  @override
  String toString() {
    var fraction = Fraction.fromDouble(distance).toMixedFraction();
    String distanceStr = fraction.toString();
    if (fraction.numerator == 0) {
      distanceStr = fraction.toFraction().toString();
    }
    return '${qualifier.toString()}${distanceStr}SM';
  }

  @override
  bool operator ==(Object other) {
    return other is Visibility && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _visibility.hashCode;
}
