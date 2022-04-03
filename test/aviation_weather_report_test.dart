import 'package:test/test.dart';
import 'package:awrep/aviation_weather_report.dart';

void main() {
  aviationWeatherReportParser();
  parsingUtils();
}

void aviationWeatherReportParser() {
  test('Check if aviation weather report was parsed completely', () {
    final report = AviationWeatherReportParser(
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 "
            "RMK AO2 SFC VIS 3/4 SLP164 T00830083");

    expect(report.isParsed, false);
  });
  test('Test separation for body and remarks', () {
    final body = "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body RMK $remarks";

    expect(AviationWeatherReportParser.getBodySectionFromReport(report), body);
    expect(AviationWeatherReportParser.getRemarksSectionFromReport(report), remarks);
  });
}

void parsingUtils() {
  test('Test separation for body and remarks', () {
    final body = "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body RMK $remarks";

    expect(ReportParsingUtils.getBodySectionFromReport(report), body);
    expect(ReportParsingUtils.getRemarksSectionFromReport(report), remarks);
  });
}
