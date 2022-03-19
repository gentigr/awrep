class BodySection {
  const BodySection(String body);
}

class RemarksSection {
  const RemarksSection(String remarks);
}

class AviationWeatherReport {
  final BodySection _body;
  final RemarksSection _remarks;
  AviationWeatherReport(String report)
      : _body = BodySection(report),
        _remarks = RemarksSection(report);

  bool get isParsed {
    return false;
  }
}
