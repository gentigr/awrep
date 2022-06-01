/// The modifier of a [Metar].
enum Modifier {
  /// The value represents situation when no specific type is provided.
  none._instance(''),

  /// The value represents situation when 'AUTO' type is provided.
  auto._instance('AUTO'),

  /// The value represents situation when 'COR' type is provided.
  cor._instance('COR');

  final String _value;

  const Modifier._instance(this._value);

  /// Creates [Modifier] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [modifier] value does not
  /// correspond to expected format (such as null, empty or AUTO/COR).
  factory Modifier(String? modifier) {
    if (modifier == null) {
      return none;
    }
    if (modifier.isEmpty) {
      return none;
    }
    switch (modifier) {
      case 'AUTO':
        return auto;
      case 'COR':
        return cor;
      default:
        throw FormatException(
            'Unexpected report modifier, provided: `$modifier`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
