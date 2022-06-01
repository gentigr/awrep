/// [ReportWindException] is thrown when there is a parsing error occurred
/// during usage of getters of [ReportWind] object.
class ReportWindException implements Exception {
  final String message;

  const ReportWindException(this.message);

  String errMsg() => this.message;
}

/// This class holds wind characteristics description.
class ReportWind {
  final String _wind;

  /// Constructor of [ReportWind] object, provided string should be in the
  /// following dddff(f)Gff(f)KT_dddVddd format to be parsed properly.
  const ReportWind(this._wind);

  /// This is the primary direction of report wind.
  ///
  /// Returns 'null' value when the wind direction is variable and it's speed is
  /// 6 knots or less.
  int? get direction {
    var regExp = RegExp('^(?<primary_wind_direction>(\\d{3}|VRB))');
    var parsedValue = _regexMatch(regExp, 'primary_wind_direction')!;
    if (parsedValue == 'VRB') {
      return null;
    }
    int value = _integer('direction', parsedValue);
    _checkBoundaries('direction', value, 0, 359);
    return value;
  }

  /// This is the speed of reported wind.
  int get speed {
    var regExp = RegExp('^\\w{3}(?<speed>\\d{2,3})');
    return _integer('velocity', _regexMatch(regExp, 'speed')!);
  }

  /// This is the speed of reported gust.
  ///
  /// Returns 'null' value when there is no gust reported.
  int? get gust {
    var regExp = RegExp('G(?<gust>\\d{2,3})');
    var value = _regexMatchOptional(regExp, 'gust');
    if (value != null) {
      return _integer('gust', value);
    }
    return null;
  }

  /// This is a start of wind direction range for variable wind with speed
  /// greater than 6 knots.
  ///
  /// Returns 'null' value when there is no variable wind section.
  int? get directionVrbRangeStart {
    var regExp = RegExp('(?<vrb_range_start>\\d{3})V');
    var rangeStart = _regexMatchOptional(regExp, 'vrb_range_start');
    if (rangeStart == null) {
      return null;
    }

    int value = _integer('vrb_range_start', rangeStart);
    _checkBoundaries('vrb_range_start', value, 0, 359);
    return value;
  }

  /// This is a end of wind direction range for variable wind with speed
  /// greater than 6 knots.
  ///
  /// Returns 'null' value when there is no variable wind section.
  int? get directionVrbRangeEnd {
    var regExp = RegExp('V(?<vrb_range_end>\\d{3})');
    var rangeEnd = _regexMatchOptional(regExp, 'vrb_range_end');
    if (rangeEnd == null) {
      return null;
    }
    int value = _integer('vrb_range_end', rangeEnd);
    _checkBoundaries('vrb_range_end', value, 0, 359);
    return value;
  }

  @override
  bool operator ==(Object other) {
    return other is ReportWind && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _wind.hashCode;

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

  static String _format(int? num, int padLeft, {String defaultValue = ''}) {
    if (num == null) {
      return defaultValue;
    }
    return num.toString().padLeft(padLeft, '0');
  }

  void _checkBoundaries(
      String name, int value, int minLimitInclusive, int maxLimitInclusive) {
    if (value < minLimitInclusive || value > maxLimitInclusive) {
      throw ReportWindException('Report $name value must be within '
          '[$minLimitInclusive; $maxLimitInclusive] range, provided: `$value` '
          'from `$_wind`');
    }
  }

  int _integer(String name, String value) {
    try {
      return int.parse(value);
    } on FormatException catch (e) {
      throw ReportWindException('Could not parse report $name part '
          '`$value` of `$_wind`, error: `$e`');
    }
  }

  bool _checkRegexHasMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.hasMatch(_wind)) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Failed to find RegEx `$regExp` in report wind section `$_wind`';
    throw ReportWindException(err);
  }

  bool _checkRegexHasOnlyOneMatch(RegExp regExp, {bool noThrow = false}) {
    if (regExp.allMatches(_wind).length == 1) {
      return true;
    }
    if (noThrow) {
      return false;
    }
    var err = 'Too many matches were found by RegEx `$regExp` '
        'in report wind section `$_wind`';
    throw ReportWindException(err);
  }

  String? _regexMatch(RegExp regExp, String name) {
    _checkRegexHasMatch(regExp);
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_wind)!.namedGroup(name);
  }

  String? _regexMatchOptional(RegExp regExp, String name) {
    bool hasMatch = _checkRegexHasMatch(regExp, noThrow: true);
    if (!hasMatch) {
      return null;
    }
    _checkRegexHasOnlyOneMatch(regExp);
    return regExp.firstMatch(_wind)!.namedGroup(name);
  }
}
