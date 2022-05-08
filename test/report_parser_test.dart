import 'package:awrep/report_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ReportParser', () {
    group('getBody', () {
      reportParserGetBody();
    });
    group('getRemarks', () {
      reportParserGetRemarks();
    });
  });
}

void reportParserGetBody() {
  test('Test separation for body', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "RMK AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body $remarks";

    expect(ReportParser.getBody(report), body);
  });
}

void reportParserGetRemarks() {
  test('Test separation for remarks', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "RMK AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body $remarks";

    expect(ReportParser.getRemarks(report), remarks);
  });
}
