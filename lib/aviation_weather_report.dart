class BodySection {
  final String body;
  const BodySection(this.body);
}

class RemarksSection {
  final String remarks;
  const RemarksSection(this.remarks);
}

enum ReportType {
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
  final String _report;

  AviationWeatherReport(String report)
      : _body = BodySection(ReportParsingUtils.getBodySectionFromReport(report)),
        _remarks =
            RemarksSection(ReportParsingUtils.getRemarksSectionFromReport(report)),
        _report = report;

  bool get isParsed {
    return false;
  }
}
