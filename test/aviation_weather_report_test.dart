import 'package:test/test.dart';
import 'package:metar/aviation_weather_report.dart';

void main() {
  test('Counter value should be incremented', () {
    final report = AviationWeatherReport(
        "KJFK 190351Z 18004KT 1/4SM R04R/2000V3000FT BR OVC002 08/08 A3002 "
        "RMK AO2 SFC VIS 3/4 SLP164 T00830083");

    expect(report.isParsed, false);
  });
}
