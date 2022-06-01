import 'package:awrep/src/remarks/remarks.dart';
import 'package:test/test.dart';

void main() {
  group('Remarks', () {
    group('toString', () {
      remarksToString();
    });
    group('equalityOperator', () {
      remarksEqualityOperator();
    });
    group('hashCode', () {
      remarksHashCode();
    });
  });
}

void remarksToString() {
  test('Test basic string output format', () {
    final remarks = 'AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Remarks(remarks).toString(), remarks);
  });
}

void remarksEqualityOperator() {
  test('Test equality operator for non-equality', () {
    final remarks1 = 'AO2 SFC VIS 1/4 SLP164 T00830083';
    final remarks2 = 'AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Remarks(remarks1) == Remarks(remarks2), false);
  });
  test('Test equality operator for equality', () {
    final remarks1 = 'AO2 SFC VIS 3/4 SLP164 T00830083';
    final remarks2 = 'AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Remarks(remarks1) == Remarks(remarks2), true);
  });
}

void remarksHashCode() {
  test('Test hash generation for non-equality', () {
    final remarks1 = 'AO2 SFC VIS 1/4 SLP164 T00830083';
    final remarks2 = 'AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Remarks(remarks1).hashCode == Remarks(remarks2).hashCode, false);
  });
  test('Test hash generation for equality', () {
    final remarks1 = 'AO2 SFC VIS 3/4 SLP164 T00830083';
    final remarks2 = 'AO2 SFC VIS 3/4 SLP164 T00830083';

    expect(Remarks(remarks1).hashCode == Remarks(remarks2).hashCode, true);
  });
}
