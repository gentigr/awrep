import 'package:test/test.dart';
import 'package:awrep/aviation_weather_report.dart';

void main() {
  aviationWeatherReport();
  aviationWeatherReportParser();
  bodySectionParser();
}

void aviationWeatherReport() {
  test('Check if aviation weather report was parsed completely', () {
    String report =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 "
        "RMK AO2 SFC VIS 3/4 SLP164 T00830083";
    final AviationWeatherReport awr = AviationWeatherReport(report);

    expect(awr.toString() == report, false);
  });
}

void aviationWeatherReportParser() {
  test('Test separation for body and remarks', () {
    final body = "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body RMK $remarks";

    expect(AviationWeatherReportParser.getBodySectionFromReport(report), body);
    expect(AviationWeatherReportParser.getRemarksSectionFromReport(report), remarks);
  });
}

void bodySectionParser() {
  test('Test report type: none', () {
    final body = "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.none);
  });
  test('Test report type: metar', () {
    final body = "METAR KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.metar);
  });
  test('Test report type: speci', () {
    final body = "SPECI KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.speci);
  });
}
