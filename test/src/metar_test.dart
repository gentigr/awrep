import 'package:awrep/body/body.dart';
import 'package:awrep/remarks/remarks.dart';
import 'package:awrep/report.dart';
import 'package:test/test.dart';

void main() {
  group('Report', () {
    group('equalityOperator', () {
      reportEqualityOperator();
    });
    group('hashCode', () {
      reportHashCode();
    });
    group('body', () {
      reportBody();
    });
    group('remarks', () {
      reportRemarks();
    });
    group('toString', () {
      reportToString();
    });
  });
}

void reportEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final report1 = 'KJFK 190351Z 18004KT OVC020 08/08 A3002 RMK AO2 T00830083';
    final report2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Report(report1) == Report(report2), false);
  });
  test('Test equality operator for equality', () {
    final report1 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';
    final report2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Report(report1) == Report(report2), true);
  });
}

void reportHashCode() {
  test('Test hash generation for non-equality', () {
    final report1 = 'KJFK 190351Z 18004KT OVC001 08/08 A3002 RMK AO2 T00830083';
    final report2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Report(report1).hashCode == Report(report2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final report1 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';
    final report2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Report(report1).hashCode == Report(report2).hashCode, true);
  });
}

void reportBody() {
  test('Test separation for body', () {
    final body =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    final remarks = 'RMK AO2 SFC VIS 3/4 SLP164 T00830083';
    final report = '$body $remarks';

    expect(Report(report).body, Body(body));
  });
}

void reportRemarks() {
  test('Test separation for remarks', () {
    final body =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    final remarks = 'RMK AO2 SFC VIS 3/4 SLP164 T00830083';
    final report = '$body $remarks';

    expect(Report(report).remarks, Remarks(remarks));
  });
}

void reportToString() {
  test('Check basic string output with remarks', () {
    String report =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 '
        'RMK AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Report(report).toString() == report, true);
  });

  test('Check basic string output without remarks', () {
    String report =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Report(report).toString() == report, true);
  });
}