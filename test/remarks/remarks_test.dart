import 'package:awrep/remarks/remarks.dart';
import 'package:test/test.dart';

void main() {
  group('Remarks', () {
    group('toString', () {
      remarksToString();
    });
  });
}

void remarksToString() {
  test('Test remarks of speci report type', () {
    final remarks = "AO2 SFC VIS 3/4 SLP164 T00830083";

    expect(Remarks(remarks).toString(), remarks);
  });
}
