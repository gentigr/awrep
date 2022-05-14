import 'package:awrep/body/report_date_time.dart';
import 'package:awrep/body/report_modifier.dart';

import 'report_type.dart';

/// [BodyException] is thrown when there is a report parsing issue.
class BodyException implements Exception {
  final String message;

  const BodyException(this.message);

  String errMsg() => this.message;
}

/// Body section of METAR/SPECI report.
class Body {
  String _body;

  Body(this._body);

  /// Returns type of report in [ReportType] format.
  ReportType get reportType {
    var regExp = RegExp('^(?<report_type>[^ ]{5} )?(.*)\$');
    return stringAsReportType(_regexMatch(regExp, 'report_type'));
  }

  /// Returns station identifier from report.
  String get stationId {
    var regExp = RegExp('^([^ ]{5} )?(?<station_id>[A-Za-z]{4} )(.*)\$');
    return _regexMatch(regExp, 'station_id')!.trim();
  }

  /// Returns date and time of the report.
  ReportDateTime get dateTime {
    var regExp = RegExp('(?<date_time>\\d{6}Z)');
    return ReportDateTime(_regexMatch(regExp, 'date_time')!);
  }

  /// Returns modifier of report in [ReportModifier] format.
  ReportModifier get modifier {
    var regExp = RegExp(' (?<modifier>AUTO|COR) ');
    return stringAsReportModifier(_regexMatchOptional(regExp, 'modifier'));
  }

  @override
  bool operator ==(Object other) {
    return other is Body && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _body.hashCode;

  @override
  String toString() {
    return this._body;
  }

  bool _checkRegexHasMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.hasMatch(_body)) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Failed to find RegEx `$regExp` in report body `$_body`';
    print(err);
    throw BodyException(err);
  }

  bool _checkRegexHasOnlyOneMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.allMatches(_body).length == 1) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Too many matches were found by RegEx `$regExp` '
        'in report body `$_body`';
    print(err);
    throw BodyException(err);
  }

  String? _regexMatch(RegExp regExp, String name) {
    _checkRegexHasMatch(regExp);
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_body)!.namedGroup(name);
  }

  String? _regexMatchOptional(RegExp regExp, String name) {
    bool hasMatch = _checkRegexHasMatch(regExp, noThrow: true);
    if (!hasMatch) {
      return null;
    }
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_body)!.namedGroup(name);
  }
}
