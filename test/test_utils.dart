import 'package:test/test.dart';

/// Expects [FormatException] being thrown from [function] with [message].
void expectFormatException(Function function, String message) {
  expect(function,
      throwsA(predicate((e) => e is FormatException && e.message == message)));
}
