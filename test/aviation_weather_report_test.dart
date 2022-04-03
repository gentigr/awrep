import 'package:awrep/aviation_weather_report.dart';
import 'package:test/test.dart';

void main() {
  group('aviationWeatherReport', () {
    aviationWeatherReport();
  });
  group('aviationWeatherReportParser', () {
    aviationWeatherReportParser();
  });
  group('bodySectionParser', () {
    bodySectionParser();
  });
}

void aviationWeatherReport() {
  test('Check if aviation weather report was parsed completely; with rmk', () {
    String report =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 "
        "RMK AO2 SFC VIS 3/4 SLP164 T00830083";
    final AviationWeatherReport awr = AviationWeatherReport(report);

    expect(awr.toString() == report, false);
  });
  test('Check if aviation weather report was parsed completely: no rmk', () {
    String report =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final AviationWeatherReport awr = AviationWeatherReport(report);

    expect(awr.toString() == report, false);
  });
}

void aviationWeatherReportParser() {
  test('Test separation for body and remarks', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body RMK $remarks";

    expect(AviationWeatherReportParser.getBodySectionFromReport(report), body);
    expect(AviationWeatherReportParser.getRemarksSectionFromReport(report),
        remarks);
  });
}

void bodySectionParser() {
  group('checkFormat', () {
    bodySectionParserCheckFormat();
  });
  group('getReportType', () {
    bodySectionParserGetReportType();
  });
  group('getStationId', () {
    bodySectionParserGetStationId();
  });
}

void bodySectionParserCheckFormat() {
  test('test no station', () {
    final body = "190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.checkFormat(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test multiple matches', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.checkFormat("$body\n$body"),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message ==
                "Too many matches were found in body section of weather report")));
  }, skip: 'currently failing due to lack of complete regex');
}

void bodySectionParserGetReportType() {
  test('test bad format', () {
    final body = "190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getReportType(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test undefined report type', () {
    final body =
        "UNDEF KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.undefined);
  });
  test('test no report type', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.none);
  });
  test('test metar report type', () {
    final body =
        "METAR KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.metar);
  });
  test('test speci report type', () {
    final body =
        "SPECI KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportType(body), ReportType.speci);
  });
}

void bodySectionParserGetStationId() {
  test('test no station', () {
    final body = "190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getStationId(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test non-alphabetic station', () {
    final body =
        "K1JF 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getStationId(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test correct station id', () {
    final body =
        "SPECI KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getStationId(body), "KJFK");
  });
}
