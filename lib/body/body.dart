import 'package:awrep/body/report_date_time.dart';

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

  void _checkRegexMatch(RegExp regExp) {
    if (!regExp.hasMatch(_body)) {
      print('Failed to find RegEx `$regExp` in report body `$_body`');
      throw BodyException(
          'Failed to find RegEx `$regExp` in report body `$_body`');
    }
    if (regExp.allMatches(_body).length > 1) {
      print('Too many matches were found by RegEx `$regExp` '
          'in report body `$_body`');
      throw BodyException('Too many matches were found by RegEx `$regExp` '
          'in report body `$_body`');
    }
  }

  String? _regexMatch(RegExp regExp, String name) {
    _checkRegexMatch(regExp);
    return regExp.firstMatch(_body)!.namedGroup(name);
  }
}
