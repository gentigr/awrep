import 'package:awrep/body/report_distance_modifier.dart';
import 'package:fraction/fraction.dart';

/// [ReportVisibilityException] is thrown when there is a parsing error occurred
/// during usage of getters of [ReportVisibility] object.
class ReportVisibilityException implements Exception {
  final String message;

  const ReportVisibilityException(this.message);

  String errMsg() => this.message;
}

/// This class holds report visibility group description.
class ReportVisibility {
  final String _visibility;

  /// Constructor of [ReportVisibility] object, provided string should be in the
  /// following VVVVVSM format to be parsed properly.
  const ReportVisibility(this._visibility);

  /// This is the reported visibility distance.
  double get distance {
    var regExp = RegExp(
        '^([mMpP])?(?<whole>[0-9]{1,5})? ?((?<fraction>[0-9]{1,5}\\/[0-9]{1,5}))?SM');
    var whole = _regexMatch(regExp, 'whole');
    var fraction = _regexMatch(regExp, 'fraction');
    _checkRegexHasWholeOrFraction(regExp, whole, fraction);
    return Fraction.fromString(whole ?? '0').toDouble() +
        Fraction.fromString(fraction ?? '0').toDouble();
  }

  /// This is the reported visibility distance modifier.
  ///
  /// It returns values such as `less than`, `greater than` or `none`.
  ReportDistanceModifier get modifier {
    var regExp = RegExp('^(?<modifier>[pPmM]{1})');
    var modifier = _regexMatchOptional(regExp, 'modifier');
    return stringAsReportDistanceModifier(modifier);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportVisibility && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _visibility.hashCode;

  @override
  String toString() {
    var fraction = Fraction.fromDouble(distance).toMixedFraction();
    String distanceStr = fraction.toString();
    if (fraction.numerator == 0) {
      distanceStr = fraction.toFraction().toString();
    }
    return '${modifier.string}${distanceStr}SM';
  }

  bool _checkRegexHasMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.hasMatch(_visibility)) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err =
        'Failed to find RegEx `$regExp` in report visibility section `$_visibility`';
    print(err);
    throw ReportVisibilityException(err);
  }

  void _checkRegexHasWholeOrFraction(
      RegExp regExp, String? whole, String? fraction) {
    if (whole != null || fraction != null) {
      return;
    }
    var err = 'Either whole or fraction must be present in visibility section, '
        'neither field was found by RegEx `$regExp` '
        'in report visibility section `$_visibility`';
    print(err);
    throw ReportVisibilityException(err);
  }

  bool _checkRegexHasOnlyOneMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.allMatches(_visibility).length == 1) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Too many matches were found by RegEx `$regExp` '
        'in report visibility section `$_visibility`';
    print(err);
    throw ReportVisibilityException(err);
  }

  String? _regexMatch(RegExp regExp, String name) {
    _checkRegexHasMatch(regExp);
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_visibility)!.namedGroup(name);
  }

  String? _regexMatchOptional(RegExp regExp, String name) {
    bool hasMatch = _checkRegexHasMatch(regExp, noThrow: true);
    if (!hasMatch) {
      return null;
    }
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_visibility)!.namedGroup(name);
  }
}
