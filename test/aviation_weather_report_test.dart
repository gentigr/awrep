import 'package:awrep/aviation_weather_report.dart';
import 'package:test/test.dart';

void main() {
  group('reportDateTime', () {
    reportDateTime();
  });
  group('wind', () {
    wind();
  });
  group('reportRunway', () {
    reportRunway();
  });
  group('reportLength', () {
    reportLength();
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
  test('test variable light wind', () {
    expect(ReportWind.lgt(6).toString(), "VRB06KT");
  });
  test('test variable gust wind', () {
    expect(ReportWind.all(30, 15, 25, 0, 60).toString(), "03015G25KT 000V060");
  });
}

void reportRunway() {
  group('toString', () {
    runwayToString();
  });
}

void runwayToString() {
  test('test runway with side', () {
    expect(ReportRunway(11, ReportRunwaySide.left).toString(), '11L');
  });
  test('test runway without side', () {
    expect(ReportRunway.single(22).toString(), '22');
  });
  test('test one symbol runway', () {
    expect(ReportRunway.single(3).toString(), '03');
  });
}

void reportLength() {
  group('toString', () {
    reportLengthToString();
  });
}

void reportLengthToString() {
  test('test only length', () {
    expect(ReportLength(1100).toString(), '1100');
  });
  test('test length and plus modifier', () {
    expect(ReportLength.mod(1100, ReportLengthModifier.plus).toString(), 'P1100');
  });
  test('test length and minus modifier', () {
    expect(ReportLength.mod(1100, ReportLengthModifier.minus).toString(), 'M1100');
  });
  test('test empty report length', () {
    expect(ReportLength.empty().toString(), '0000');
  });
  test('test two symbols length', () {
    expect(ReportLength(10).toString(), '0010');
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
  group('getWind', () {
    bodySectionParserGetWind();
  });
  group('getVisibility', () {
    bodySectionParserGetVisibility();
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

void compareReportWindObjects(ReportWind src, ReportWind dst) {
  expect(src.direction, dst.direction);
  expect(src.velocity, dst.velocity);
  expect(src.gust, dst.gust);
  expect(src.vrbFrom, dst.vrbFrom);
  expect(src.vrbTo, dst.vrbTo);
}

void bodySectionParserGetWind() {
  test('test bad format', () {
    final body = "KJFK 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getWind(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test calm wind', () {
    final body = "KJFK 190351Z COR 00000KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(0, 0, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test one-symbol velocity wind', () {
    final body = "KJFK 190351Z COR 10008KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 8, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test two-symbol velocity wind', () {
    final body = "KJFK 190351Z COR 10088KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 88, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test three-symbol velocity wind', () {
    final body = "KJFK 190351Z COR 100888KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 888, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test one-symbol direction wind', () {
    final body = "KJFK 190351Z COR 00205KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(2, 5, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test two-symbol direction wind', () {
    final body = "KJFK 190351Z COR 02005KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(20, 5, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test three-symbol direction wind', () {
    final body = "KJFK 190351Z COR 20005KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(200, 5, 0, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test one-symbol gust wind', () {
    expect(ReportWind.gst(100, 5, 9).toString(), "10005G09KT");
    final body = "KJFK 190351Z COR 10005G09KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 5, 9, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test two-symbol gust wind', () {
    final body = "KJFK 190351Z COR 10005G90KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 5, 90, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test three-symbol gust wind', () {
    final body = "KJFK 190351Z COR 10005G900KT 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 5, 900, 0, 0);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test variable wind', () {
    final body = "KJFK 190351Z COR 10005KT 070V130 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(100, 5, 0, 70, 130);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test variable light wind', () {
    final body = "KJFK 190351Z COR VRB06KT 070V130 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.lgt(6);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
  test('test variable gust wind', () {
    final body =
        "KJFK 190351Z COR 03015G25KT 000V060 1/4SM BR OVC002 08/08 A3002";
    final ReportWind expected = ReportWind.all(30, 15, 25, 0, 60);
    final ReportWind actual = BodySectionParser.getWind(body);
    compareReportWindObjects(actual, expected);
  });
}

void bodySectionParserGetVisibility() {
  test('test bad format', () {
    final body =
        "190351Z COR 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(
        () => BodySectionParser.getVisibility(body),
        throwsA(predicate((e) =>
            e is BodySectionParserException &&
            e.message == "Failed to parse body section of weather report")));
  });
  test('test zero visibility', () {
    final body =
        "KJFK 190351Z CCC 18004KT 0SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getVisibility(body), "0");
  });
  test('test fractional visibility', () {
    final body =
        "KJFK 190351Z 18004KT 1 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getVisibility(body), "1 1/4");
  });
  test('test grand visibility', () {
    final body =
        "METAR KJFK 190351Z AUTO 18004KT 30SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(BodySectionParser.getVisibility(body), "30");
  });
  test('test plus visibility', () {
    final body = "METAR KJFK 190351Z AUTO 18004KT P30SM BR OVC002 08/08 A3002";

    expect(BodySectionParser.getVisibility(body), "P30");
  });
  test('test minus visibility', () {
    final body = "METAR KJFK 190351Z AUTO 18004KT M30SM BR OVC002 08/08 A3002";

    expect(BodySectionParser.getVisibility(body), "M30");
  });
}
