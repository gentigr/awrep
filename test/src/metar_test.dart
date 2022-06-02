import 'package:metar/src/body/body.dart';
import 'package:metar/src/remarks/remarks.dart';
import 'package:metar/src/metar.dart';
import 'package:test/test.dart';

void main() {
  group('Metar', () {
    group('body', () {
      metarBody();
    });
    group('remarks', () {
      metarRemarks();
    });
    group('toString', () {
      metarToString();
    });
    group('equalityOperator', () {
      metarEqualityOperator();
    });
    group('hashCode', () {
      metarHashCode();
    });
  });
}

void metarBody() {
  test('Test separation for body', () {
    final body =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    final remarks = 'RMK AO2 SFC VIS 3/4 SLP164 T00830083';
    final metar = '$body $remarks';

    expect(Metar(metar).body, Body(body));
  });
}

void metarRemarks() {
  test('Test separation for remarks', () {
    final body =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';
    final remarks = 'RMK AO2 SFC VIS 3/4 SLP164 T00830083';
    final metar = '$body $remarks';

    expect(Metar(metar).remarks, Remarks(remarks));
  });
}

void metarToString() {
  test('Check basic string output with remarks', () {
    String metar =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 '
        'RMK AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Metar(metar).toString() == metar, true);
  });

  test('Check basic string output without remarks', () {
    String metar =
        'KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002';

    expect(Metar(metar).toString() == metar, true);
  });
}

void metarEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final metar1 = 'KJFK 190351Z 18004KT OVC020 08/08 A3002 RMK AO2 T00830083';
    final metar2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Metar(metar1) == Metar(metar2), false);
  });
  test('Test equality operator for equality', () {
    final metar1 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';
    final metar2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Metar(metar1) == Metar(metar2), true);
  });
}

void metarHashCode() {
  test('Test hash generation for non-equality', () {
    final metar1 = 'KJFK 190351Z 18004KT OVC001 08/08 A3002 RMK AO2 T00830083';
    final metar2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Metar(metar1).hashCode == Metar(metar2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final metar1 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';
    final metar2 = 'KJFK 190351Z 18004KT OVC002 08/08 A3002 RMK AO2 T00830083';

    expect(Metar(metar1).hashCode == Metar(metar2).hashCode, true);
  });
}
