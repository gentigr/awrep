/* switch off this API until Runway Approach class is settled
import 'package:awrep/src/common/report_runway_approach_direction.dart';
*/

/// [ReportRunwayException] is thrown when there is a parsing error occurred
/// during the creation of [ReportRunway] object.
class ReportRunwayException implements Exception {
  final String message;

  const ReportRunwayException(this.message);

  String errMsg() => this.message;
}

/// Runway identification used within [Report].
class ReportRunway {
  final String _runway;

  /// Constructor of [ReportRunway] object, provided string is in DDA format,
  /// where DD -> digital representation of runway number, and
  /// A -> [ReportRunwayApproachDirection] if present.
  const ReportRunway(this._runway);

  /// Returns runway number.
  int get number {
    var regExp = RegExp('^(?<number>\\d{2})');
    var runway = _regexMatch(regExp, 'number')!;
    int value = _integer('runway', runway);
    _checkBoundaries('runway', value, 1, 36);
    return value;
  }
  /* switch off this API until Runway Approach class is settled
  /// Returns runway approach direction.
  ReportRunwayApproachDirection get direction {
    var regExp = RegExp('(?<direction>[L|l|C|c|R|r])\$');
    var direction = _regexMatchOptional(regExp, 'direction');
    return stringAsReportRunwayApproachDirection(direction);
  }
   */

  @override
  bool operator ==(Object other) {
    return other is ReportRunway && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _runway.hashCode;

  /* switch off this API until Runway Approach class is settled
  @override
  String toString() {
    return '${_format(number)}${direction.string}';
  }
   */

  int _integer(String name, String value) {
    try {
      return int.parse(value);
    } on FormatException catch (e) {
      throw ReportRunwayException('Could not parse report $name part '
          '`$value` of `$_runway`, error: `$e`');
    }
  }

  void _checkBoundaries(
      String name, int value, int minLimitInclusive, int maxLimitInclusive) {
    if (value < minLimitInclusive || value > maxLimitInclusive) {
      print('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_runway`');
      throw ReportRunwayException('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_runway`');
    }
  }

  static String _format(int num) {
    return num.toString().padLeft(2, '0');
  }

  bool _checkRegexHasMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.hasMatch(_runway)) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Failed to find RegEx `$regExp` in runway coding `$_runway`';
    print(err);
    throw ReportRunwayException(err);
  }

  bool _checkRegexHasOnlyOneMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.allMatches(_runway).length == 1) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    print(regExp.allMatches(_runway).toList()[0].groupNames);
    print(regExp.allMatches(_runway).toList()[1].groupNames);
    var err = 'Too many matches were found by RegEx `$regExp` '
        'in runway coding `$_runway`';
    print(err);
    throw ReportRunwayException(err);
  }

  String? _regexMatch(RegExp regExp, String name) {
    _checkRegexHasMatch(regExp);
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_runway.trim())!.namedGroup(name);
  }

  String? _regexMatchOptional(RegExp regExp, String name) {
    bool hasMatch = _checkRegexHasMatch(regExp, noThrow: true);
    if (!hasMatch) {
      return null;
    }
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_runway.trim())!.namedGroup(name);
  }
}
