class BodySection {
  ReportType _type;
  String _stationId;
  ReportDateTime _dateTime;
  ReportModifier _modifier;
  ReportWind _wind;

  BodySection(String body)
      : _type = BodySectionParser.getReportType(body),
        _stationId = BodySectionParser.getStationId(body),
        _dateTime = BodySectionParser.getDateTime(body),
        _modifier = BodySectionParser.getReportModifier(body),
        _wind = BodySectionParser.getWind(body);

  @override
  String toString() {
    return "${_getReportTypeStr(_type)}"
        " $_stationId"
        " $_dateTime"
        " ${_getReportModifierStr(_modifier)}"
        " $_wind";
  }

  static String _getReportTypeStr(ReportType reportType) {
    if (reportType == ReportType.none) {
      return "";
    }
    return reportType.name.toUpperCase();
  }

  static String _getReportModifierStr(ReportModifier modifier) {
    if (modifier == ReportModifier.none) {
      return "";
    }
    return modifier.name.toUpperCase();
  }
}

class BodySectionParserException implements Exception {
  final String message;

  const BodySectionParserException(this.message);

  String errMsg() => this.message;
}

class ReportDateTime {
  final int day;
  final int hour;
  final int minute;

  const ReportDateTime(this.day, this.hour, this.minute);

  @override
  String toString() {
    return "${_format(day)}${_format(hour)}${_format(minute)}Z";
  }

  static String _format(int num) {
    return num.toString().padLeft(2, '0');
  }
}

enum ReportModifier {
  undefined,
  none,
  auto,
  cor,
}

class ReportWind {
  final int direction;
  final int velocity;
  final int gust;
  final int vrbFrom;
  final int vrbTo;

  const ReportWind.clm()
      : direction = 0,
        velocity = 0,
        gust = 0,
        vrbFrom = 0,
        vrbTo = 0;
  const ReportWind.std(this.direction, this.velocity)
      : gust = 0,
        vrbFrom = 0,
        vrbTo = 0;
  const ReportWind.gst(this.direction, this.velocity, this.gust)
      : vrbFrom = 0,
        vrbTo = 0;
  const ReportWind.vrb(this.direction, this.velocity, this.vrbFrom, this.vrbTo)
      : gust = 0;
  const ReportWind.all(
      this.direction, this.velocity, this.gust, this.vrbFrom, this.vrbTo);

  @override
  String toString() {
    String directionStr = direction.toString().padLeft(3, '0');
    String velocityStr = velocity.toString().padLeft(2, '0');
    String gustStr = (gust == 0 ? "" : "G${gust.toString().padLeft(2, '0')}");
    String vrbStr = "";
    if (vrbFrom > 0 || vrbTo > 0) {
      String vrbFromStr = vrbFrom.toString().padLeft(3, '0');
      String vrbToStr = vrbTo.toString().padLeft(3, '0');
      vrbStr = " $vrbFromStr\V$vrbToStr";
    }
    return "$directionStr$velocityStr$gustStr\KT$vrbStr";
  }
}

class BodySectionParser {
  static final _typeOfReport = "(?<type>[^ ]{5} )?";
  static final _stationIdentifier = "(?<station_id>[a-zA-Z^ ]{4} )";
  static final _dateAndTime = "(?<date_and_time>[0-9^ ]{6}Z )";
  static final _modifier = "(?<modifier>[^ ]{3,4} )?";
  static final _windStd =
      "(?<wind_direction>[0-9]{3})(?<wind_velocity>[0-9]{2,3})";
  static final _windGst = "(([G]{1})(?<wind_gust>[0-9]{2,3}))?";
  static final _windVrb =
      "( (?<wind_vrb_from>[0-9]{3})V(?<wind_vrb_to>[0-9]{3}))?";
  static final _wind = '$_windStd$_windGst\KT$_windVrb';
  static final bodyRegex = RegExp('^$_typeOfReport'
      '$_stationIdentifier'
      '$_dateAndTime'
      '$_modifier'
      '$_wind'
      '(?<all>.*)\$');

  static void checkFormat(String body) {
    if (!bodyRegex.hasMatch(body)) {
      throw new BodySectionParserException(
          "Failed to parse body section of weather report");
    }
    if (bodyRegex.allMatches(body).length > 1) {
      throw new BodySectionParserException(
          "Too many matches were found in body section of weather report");
    }
  }

  static ReportType getReportType(String body) {
    checkFormat(body);
    String? type = bodyRegex.firstMatch(body)!.namedGroup("type");
    if (type != null) {
      switch (type.trim()) {
        case "METAR":
          return ReportType.metar;
        case "SPECI":
          return ReportType.speci;
        default:
          return ReportType.undefined;
      }
    }
    return ReportType.none;
  }

  static String getStationId(String body) {
    return _getNamedGroup(body, "station_id");
  }

  static ReportDateTime getDateTime(String body) {
    String dateTime = _getNamedGroup(body, "date_and_time");
    return ReportDateTime(
        int.parse(dateTime.substring(0, 2)),
        int.parse(dateTime.substring(2, 4)),
        int.parse(dateTime.substring(4, 6)));
  }

  static ReportModifier getReportModifier(String body) {
    checkFormat(body);
    String? modifier = bodyRegex.firstMatch(body)!.namedGroup("modifier");
    if (modifier == null) {
      return ReportModifier.none;
    }
    switch (modifier.trim()) {
      case "AUTO":
        return ReportModifier.auto;
      case "COR":
        return ReportModifier.cor;
      default:
        return ReportModifier.undefined;
    }
  }

  static ReportWind getWind(String body) {
    String direction = _getNamedGroup(body, "wind_direction");
    String velocity = _getNamedGroup(body, "wind_velocity");
    String gust = bodyRegex.firstMatch(body)!.namedGroup("wind_gust") ?? "0";
    String vrbFrom =
        bodyRegex.firstMatch(body)!.namedGroup("wind_vrb_from") ?? "0";
    String vrbTo = bodyRegex.firstMatch(body)!.namedGroup("wind_vrb_to") ?? "0";
    return ReportWind.all(int.parse(direction), int.parse(velocity),
        int.parse(gust), int.parse(vrbFrom), int.parse(vrbTo));
  }

  static String _getNamedGroup(String body, String name) {
    checkFormat(body);
    return bodyRegex.firstMatch(body)!.namedGroup(name)!.trim();
  }
}

class RemarksSection {
  final String remarks;

  const RemarksSection(this.remarks);
}

enum ReportType {
  undefined,
  none,
  metar,
  speci,
}

class AviationWeatherReport {
  final BodySection _body;
  final RemarksSection _remarks;

  AviationWeatherReport(String report)
      : _body = BodySection(
            AviationWeatherReportParser.getBodySectionFromReport(report)),
        _remarks = RemarksSection(
            AviationWeatherReportParser.getRemarksSectionFromReport(report)) {}

  @override
  String toString() {
    return "$_body RMK $_remarks";
  }
}

class AviationWeatherReportParser {
  static getBodySectionFromReport(String report) {
    if (report.contains(" RMK ")) {
      return report.split(" RMK ")[0].trim();
    }
    return report;
  }

  static getRemarksSectionFromReport(String report) {
    if (report.contains(" RMK ")) {
      return report.split(" RMK ")[1].trim();
    }
    return "";
  }
}
