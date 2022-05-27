/// The class represents runway number.
class RunwayNumber {
  final int _number;

  /// Constructs runway number from integer representation.
  ///
  /// Throws [FormatException] if the number is outside expected range [1; 36].
  RunwayNumber(this._number) {
    if (_number < 1 || _number > 36) {
      throw FormatException('Runway number value must be within [1; 36] range, '
          'provided: `$_number`');
    }
  }

  /// Constructs runway number from string representation.
  ///
  /// Throws [FormatException] if non-digit symbols are provided.
  RunwayNumber.fromString(String runwayNumber) : this(int.parse(runwayNumber));

  /// The runway number representation using integer type.
  int get asInteger {
    return _number;
  }

  /// The runway number representation using string type.
  @override
  String toString() {
    return _number.toString().padLeft(2, '0');
  }
}
