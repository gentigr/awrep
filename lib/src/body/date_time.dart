import 'package:metar/src/common/regexp_decorator.dart';

/// The class represents actual time of a [Metar].
class DateTime {
  final String _dateTime;

  /// Constructs a [DateTime] object from string representation.
  ///
  /// Provided string is in YYGGggZ format, where YY is a day, GG is a hour,
  /// gg is a minute, Z is an identification of Zulu time (or UTC).
  /// Throws [FormatException] if the provided value is not within described
  /// format.
  DateTime(this._dateTime) {
    var regExp = RegExpDecorator('^\\d{6}Z\$');
    regExp.verifySingleMatch(_dateTime, this.runtimeType.toString());
  }

  /// The day of actual time when report is noted.
  int get day {
    int value = int.parse(_dateTime.substring(0, 2));
    _checkBoundaries('day', value, 1, 31);
    return value;
  }

  /// The hour of actual time when report is noted.
  int get hour {
    int value = int.parse(_dateTime.substring(2, 4));
    _checkBoundaries('hour', value, 0, 23);
    return value;
  }

  /// The minute of actual time when report is noted.
  int get minute {
    int value = int.parse(_dateTime.substring(4, 6));
    _checkBoundaries('minute', value, 0, 59);
    return value;
  }

  @override
  String toString() {
    return '${_format(day)}${_format(hour)}${_format(minute)}Z';
  }

  @override
  bool operator ==(Object other) {
    return other is DateTime && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _dateTime.hashCode;

  static String _format(int num) {
    return num.toString().padLeft(2, '0');
  }

  void _checkBoundaries(
      String name, int value, int minLimitInclusive, int maxLimitInclusive) {
    if (value < minLimitInclusive || value > maxLimitInclusive) {
      throw FormatException('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_dateTime`');
    }
  }
}
