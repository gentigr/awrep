class BodySection {
  final String body;
  const BodySection(this.body);
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

  const AviationWeatherReport(this._body, this._remarks);
}

class AviationWeatherReportParser {
  final BodySection _body;
  final RemarksSection _remarks;
  final String _report;

  AviationWeatherReportParser(String report)
      : _body = BodySection(getBodySectionFromReport(report)),
        _remarks = RemarksSection(getRemarksSectionFromReport(report)),
        _report = report;

  bool get isParsed {
    return this.toString() == _report;
  }

  @override
  String toString() {
    return "$_body RMK $_remarks";
  }

  static getBodySectionFromReport(String report) {
    return report.split(" RMK ")[0].trim();
  }

  static getRemarksSectionFromReport(String report) {
    return report.split(" RMK ")[1].trim();
  }
}