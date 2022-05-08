import 'package:awrep/report_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ReportParser', () {
    reportParserGroup();
  });
}

void reportParserGroup() {
  test('Test separation for body and remarks', () {
    final body =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";
    final report = "$body RMK $remarks";

    expect(ReportParser.getBody(report), body);
    expect(ReportParser.getRemarks(report), remarks);
  });
}
