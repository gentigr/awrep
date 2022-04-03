class BodySection {
  late ReportType _type;

  BodySection(String body) : _type = BodySectionParser.getReportType(body);

  @override
  String toString() {
    return "${_getReportTypeStr(_type)}";
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

class BodySectionParser {
  static final _typeOfReport = "(?<type>[^ ]{5} )?";
  static final _stationIdentifier = "(?<station_id>[a-zA-Z^ ]{4} )";
  static final bodyRegex = RegExp('^$_typeOfReport$_stationIdentifier(?<all>.*)\$');

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
      switch (type!.trim()) {
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
  static String getStationIdentifier(String body) {
    checkFormat(body);
    return bodyRegex.firstMatch(body)!.namedGroup("station_id")!.trim();
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
