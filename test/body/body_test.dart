import 'package:awrep/body/body.dart';
import 'package:awrep/body/report_type.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    group('reportType', () {
      bodyReportType();
    });
    group('equalityOperator', () {
      bodyEqualityOperator();
    });
    group('hashCode', () {
      bodyHashCode();
    });
    group('toString', () {
      bodyToString();
    });
  });
}

void bodyReportType() {
  test('Test undefined report type exception is not caught', () {
    final String body = 'UNDEF KJFK 190351Z 18004KT BR OVC002 08/08 A3002';
    var msg = 'Unexpected report type value: `UNDEF `';
    var err = 'Invalid argument (name): No enum value with that name: "undef"';

    expect(
        () => Body(body).reportType,
        throwsA(predicate((e) =>
            e is ReportTypeException && e.message == '$msg, error: `$err`')));
  });

  test('Test no report type body', () {
    final body = 'KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.none);
  });

  test('Test metar report type body', () {
    final body = 'METAR KJFK 190351Z 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.metar);
  });

  test('Test speci report type speci', () {
    final body = 'SPECI KJFK 190351Z 18004KT 1/4SM OVC002 08/08 A3002';

    expect(Body(body).reportType, ReportType.speci);
  });
}

void bodyEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final body1 = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1) == Body(body2), false);
  });
  test('Test equality operator for equality', () {
    final body1 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1) == Body(body2), true);
  });
}

void bodyHashCode() {
  test('Test hash generation for non-equality', () {
    final body1 = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1).hashCode == Body(body2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final body1 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';
    final body2 = 'SPECI KMMU 190351Z AUTO 18004KT 1/4SM BR OVC002 08/08 A3002';

    expect(Body(body1).hashCode == Body(body2).hashCode, true);
  });
}

void bodyToString() {
  test('Test basic string output format', () {
    final body = 'SPECI KJFK 190351Z AUTO 18004KT 1/4SM R04R/2000V3000FT '
        'BR OVC002 08/08 A3002';

    expect(Body(body).toString(), body);
  });
}
