import 'package:awrep/body/body.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    group('toString', () {
      bodyToString();
    });
  });
}

void bodyToString() {
  test('Test speci report type', () {
    final body =
        "SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(Body(body).toString(), body);
  });
}
