import 'package:awrep/aviation_weather_report.dart';
import 'package:test/test.dart';

void main() {
  group('reportDateTime', () {
    reportDateTime();
  });
  group('wind', () {
    wind();
  });
  group('aviationWeatherReport', () {
    aviationWeatherReport();
  });
  group('aviationWeatherReportParser', () {
    aviationWeatherReportParser();
  });
  group('bodySection', () {
    bodySection();
  });
  group('bodySectionParser', () {
    bodySectionParser();
  });
}

void reportDateTime() {
  group('toString', () {
    reportDateTimeToString();
  });
}

void reportDateTimeToString() {
  test('test day less than 10', () {
    ReportDateTime rdt = ReportDateTime(1, 12, 12);

    expect(rdt.toString(), "011212Z");
  });
  test('test hour less than 10', () {
    ReportDateTime rdt = ReportDateTime(10, 1, 12);

    expect(rdt.toString(), "100112Z");
  });
  test('test minute less than 10', () {
    ReportDateTime rdt = ReportDateTime(12, 12, 1);

    expect(rdt.toString(), "121201Z");
  });
}

void wind() {
  group('toString', () {
    windToString();
  });
}

void windToString() {
  test('test calm wind', () {
    expect(ReportWind.clm().toString(), "00000KT");
  });
  test('test one-symbol velocity wind', () {
    expect(ReportWind.std(100, 8).toString(), "10008KT");
  });
  test('test two-symbol velocity wind', () {
    expect(ReportWind.std(100, 88).toString(), "10088KT");
  });
  test('test three-symbol velocity wind', () {
    expect(ReportWind.std(100, 888).toString(), "100888KT");
  });
  test('test one-symbol direction wind', () {
    expect(ReportWind.std(2, 5).toString(), "00205KT");
  });
  test('test two-symbol direction wind', () {
    expect(ReportWind.std(20, 5).toString(), "02005KT");
  });
  test('test three-symbol direction wind', () {
    expect(ReportWind.std(200, 5).toString(), "20005KT");
  });
  test('test one-symbol gust wind', () {
    expect(ReportWind.gst(100, 5, 9).toString(), "10005G09KT");
  });
  test('test two-symbol gust wind', () {
    expect(ReportWind.gst(100, 5, 90).toString(), "10005G90KT");
  });
  test('test three-symbol gust wind', () {
    expect(ReportWind.gst(100, 5, 900).toString(), "10005G900KT");
  });
  test('test variable wind', () {
    expect(ReportWind.vrb(100, 5, 70, 130).toString(), "10005KT 070V130");
  });
  test('test variable gust wind', () {
    expect(ReportWind.all(30, 15, 25, 0, 60).toString(), "03015G25KT 000V060");
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

void bodySection() {
  group('toString', () {
    bodySectionToString();
  });
}

void bodySectionToString() {
  test('test speci report type', () {
    final body =
        "SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    BodySection bs = BodySection(body);
    expect(bs.toString(), "SPECI KJFK 190351Z AUTO 18004KT 1/4SM");
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
  group('getDateTime', () {
    bodySectionParserGetDateTime();
  });
  group('getReportModifier', () {
    bodySectionParserGetReportModifier();
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

void bodySectionParserGetDateTime() {
  test('test no time', () {
    final body = "KJFK 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getDateTime(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test correct date time', () {
    final body =
        "SPECI KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    final expectedDateTime = ReportDateTime(19, 03, 51);
    final actualDateTime = BodySectionParser.getDateTime(body);
    expect(actualDateTime.day, expectedDateTime.day);
    expect(actualDateTime.hour, expectedDateTime.hour);
    expect(actualDateTime.minute, expectedDateTime.minute);
  });
}

void bodySectionParserGetReportModifier() {
  test('test bad format', () {
    final body =
        "190351Z COR 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getReportModifier(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test undefined report modifier', () {
    final body =
        "KJFK 190351Z CCC 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportModifier(body), ReportModifier.undefined);
  });
  test('test no report modifier', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportModifier(body), ReportModifier.none);
  });
  test('test auto report type', () {
    final body =
        "METAR KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportModifier(body), ReportModifier.auto);
  });
  test('test cor report type', () {
    final body =
        "SPECI KJFK 190351Z COR 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getReportModifier(body), ReportModifier.cor);
  });
}
