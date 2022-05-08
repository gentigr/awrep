import 'package:awrep/report.dart';
import 'package:test/test.dart';

void main() {
  group('Report', () {
    group('toString', () {
      reportToString();
    });
  });
}

void reportToString() {
  test('Check if aviation weather report was parsed completely; with rmk', () {
    String report =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 "
        "RMK AO2 SFC VIS 3/4 SLP164 T00830083";

    expect(Report(report).toString() == report, true);
  });

  test('Check if aviation weather report was parsed completely: no rmk', () {
    String report =
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(Report(report).toString() == report, true);
  });
}
