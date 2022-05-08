import 'package:awrep/body/body.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    group('toString', () {
      bodyToString();
    });
    group('equalityOperator', () {
      bodyEqualityOperator();
    });
    group('hashCode', () {
      bodyHashCode();
    });
  });
}

void bodyToString() {
  test('Test basic string output format', () {
    final body =
        "SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002";

    expect(Body(body).toString(), body);
  });
}

void bodyEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final body1 = "SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";
    final body2 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";

    expect(Body(body1) == Body(body2), false);
  });
  test('Test equality operator for equality', () {
    final body1 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";
    final body2 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";

    expect(Body(body1) == Body(body2), true);
  });
}

void bodyHashCode() {
  test('Test hash generation for non-equality', () {
    final body1 = "SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";
    final body2 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";

    expect(Body(body1).hashCode == Body(body2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final body1 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";
    final body2 = "SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002";

    expect(Body(body1).hashCode == Body(body2).hashCode, true);
  });
}
