/// [ReportDateTimeException] is thrown when there is a parsing error occurred
/// during the creation of [ReportDateTime] object.
class ReportDateTimeException implements Exception {
  final String message;

  const ReportDateTimeException(this.message);

  String errMsg() => this.message;
}

/// Actual time of a report.
class ReportDateTime {
  final String _dateTime;

  /// Constructor of [ReportDateTime] object, provided string is in YYGGggZ
  /// format, where YY is a day, GG is a hour, gg is a minute, Z is an
  /// identification of Zulu time (or UTC).
  const ReportDateTime(this._dateTime);

  /// Returns day of actual time when report is noted.
  int get day {
    _checkDateTimeFormat();
    int value = _integer('day', _dateTime.substring(0, 2));
    _checkBoundaries('day', value, 1, 31);
    return value;
  }

  /// Returns hour of actual time when report is noted.
  int get hour {
    _checkDateTimeFormat();
    int value = _integer('hour', _dateTime.substring(2, 4));
    _checkBoundaries('hour', value, 0, 23);
    return value;
  }

  /// Returns minute of actual time when report is noted.
  int get minute {
    _checkDateTimeFormat();
    int value = _integer('minute', _dateTime.substring(4, 6));
    _checkBoundaries('minute', value, 0, 59);
    return value;
  }

  @override
  bool operator ==(Object other) {
    return other is ReportDateTime && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _dateTime.hashCode;

  @override
  String toString() {
    return '${_format(day)}${_format(hour)}${_format(minute)}Z';
  }

  static String _format(int num) {
    return num.toString().padLeft(2, '0');
  }

  int _integer(String name, String value) {
    try {
      return int.parse(value);
    } on FormatException catch (e) {
      throw ReportDateTimeException('Could not parse report $name part '
          '`$value` of `$_dateTime`, error: `$e`');
    }
  }

  void _checkBoundaries(
      String name, int value, int minLimitInclusive, int maxLimitInclusive) {
    if (value < minLimitInclusive || value > maxLimitInclusive) {
      throw ReportDateTimeException('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_dateTime`');
    }
  }

  void _checkDateTimeFormat() {
    if (_dateTime.length != 7) {
      throw ReportDateTimeException('Report datetime must have length equal '
          'to 7, provided: `$_dateTime`');
    }
    if (_dateTime[6] != 'Z') {
      throw ReportDateTimeException('Report datetime must be in Zulu format '
          '(ends with `Z` symbol), provided: `$_dateTime`');
    }
  }
}
