import '../common/regexp_decorator.dart';

/// The class represents wind group within [Report].
class Wind {
  final String _wind;

  /// Constructs a [Wind] object from string representation.
  ///
  /// Provided string should be in dddff(f)Gff(f)KT_dddVddd format to be parsed.
  /// Throws [FormatException] if the provided value is not by format.
  Wind(this._wind) {
    var regExp = RegExpDecorator(
        '^(VRB|\\d{3})\\d{2,3}(G\\d{2,3})?KT( \\d{3}V\\d{3})?\$');
    regExp.verifySingleMatch(_wind, this.runtimeType.toString());
  }

  /// The primary direction of report wind.
  ///
  /// Returns 'null' value when the wind direction is variable and it's speed is
  /// 6 knots or less.
  int? get direction {
    var regExp = RegExpDecorator('^(?<primary_wind_direction>(\\d{3}|VRB))');
    var parsedValue = regExp.getMatchByName(_wind, 'primary_wind_direction');
    if (parsedValue == 'VRB') {
      return null;
    }
    int value = int.parse(parsedValue);
    _checkBoundaries('direction', value, 0, 359);
    return value;
  }

  /// The speed of reported wind.
  int get speed {
    var regExp = RegExpDecorator('^\\w{3}(?<speed>\\d{2,3})');
    return int.parse(regExp.getMatchByName(_wind, 'speed'));
  }

  /// The speed of reported gust.
  ///
  /// Returns 'null' value when there is no gust reported.
  int? get gust {
    var regExp = RegExpDecorator('G(?<gust>\\d{2,3})');
    var value = regExp.getMatchByNameOptional(_wind, 'gust');
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }

  /// The start of wind direction range for variable wind with speed greater
  /// than 6 knots.
  ///
  /// Returns 'null' value when there is no variable wind section.
  int? get directionVrbRangeStart {
    var regExp = RegExpDecorator('(?<vrb_range_start>\\d{3})V');
    var rangeStart = regExp.getMatchByNameOptional(_wind, 'vrb_range_start');
    if (rangeStart == null) {
      return null;
    }

    int value = int.parse(rangeStart);
    _checkBoundaries('vrb_range_start', value, 0, 359);
    return value;
  }

  /// The end of wind direction range for variable wind with speed greater than
  /// 6 knots.
  ///
  /// Returns 'null' value when there is no variable wind section.
  int? get directionVrbRangeEnd {
    var regExp = RegExpDecorator('V(?<vrb_range_end>\\d{3})');
    var rangeEnd = regExp.getMatchByNameOptional(_wind, 'vrb_range_end');
    if (rangeEnd == null) {
      return null;
    }
    int value = int.parse(rangeEnd);
    _checkBoundaries('vrb_range_end', value, 0, 359);
    return value;
  }

  @override
  String toString() {
    String directionStr = _format(direction, 3, defaultValue: 'VRB');
    String speedStr = _format(speed, 2);
    String gustStr = (gust == null) ? '' : 'G${_format(gust!, 2)}';
    String vrbStr = '';
    if (direction != null &&
        directionVrbRangeStart != null &&
        directionVrbRangeEnd != null) {
      String vrbStartStr = _format(directionVrbRangeStart!, 3);
      String vrbEndStr = _format(directionVrbRangeEnd!, 3);
      vrbStr = ' $vrbStartStr\V$vrbEndStr';
    }
    return '$directionStr$speedStr$gustStr\KT$vrbStr';
  }

  @override
  bool operator ==(Object other) {
    return other is Wind && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _wind.hashCode;

  static String _format(int? num, int padLeft, {String defaultValue = ''}) {
    if (num == null) {
      return defaultValue;
    }
    return num.toString().padLeft(padLeft, '0');
  }

  void _checkBoundaries(
      String name, int value, int minLimitInclusive, int maxLimitInclusive) {
    if (value < minLimitInclusive || value > maxLimitInclusive) {
      throw FormatException('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_wind`');
    }
  }
}
