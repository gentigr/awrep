class BodySection {
  ReportType _type;
  String _stationId;

  BodySection(String body)
      : _type = BodySectionParser.getReportType(body),
        _stationId = BodySectionParser.getStationId(body);

  @override
  String toString() {
    return "${_getReportTypeStr(_type)}"
        " $_stationId";
  }

  static String _getReportTypeStr(ReportType reportType) {
    if (reportType == ReportType.none) {
      return "";
    }
    return reportType.name.toUpperCase();
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
}

enum ReportModifier {
  undefined,
  none,
  auto,
  cor,
}

class BodySectionParser {
  static final _typeOfReport = "(?<type>[^ ]{5} )?";
  static final _stationIdentifier = "(?<station_id>[a-zA-Z^ ]{4} )";
  static final _dateAndTime = "(?<date_and_time>[0-9^ ]{6}Z )";
  static final _modifier = "(?<modifier>[^ ]{3,4} )?";
  static final bodyRegex = RegExp('^$_typeOfReport'
      '$_stationIdentifier'
      '$_dateAndTime'
      '$_modifier'
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
