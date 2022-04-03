class BodySection {
  ReportType _type;

  BodySection(String body) : _type = BodySectionParser.getReportType(body) {}

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

class BodySectionParser {
  static ReportType getReportType(String body) {
    if (body.startsWith("METAR ")) {
      return ReportType.metar;
    }
    if (body.startsWith("SPECI ")) {
      return ReportType.speci;
    }
    return ReportType.none;
  }
}

class RemarksSection {
  final String remarks;

  const RemarksSection(this.remarks);
}

enum ReportType {
  none,
  metar,
  speci,
}

class ReportParsingUtils {
  static getBodySectionFromReport(String report) {
    return report.split(" RMK ")[0].trim();
  }

  static getRemarksSectionFromReport(String report) {
    return report.split(" RMK ")[1].trim();
  }
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
    return report.split(" RMK ")[0].trim();
  }

  static getRemarksSectionFromReport(String report) {
    return report.split(" RMK ")[1].trim();
  }
}
