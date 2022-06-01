/// The type of a [Metar].
enum Type {
  /// The value represents situation when no specific type is provided.
  none._instance(''),

  /// The value represents situation when 'METAR' type is provided.
  metar._instance('METAR'),

  /// The value represents situation when 'METAR' type is provided.
  speci._instance('SPECI');

  final String _value;

  const Type._instance(this._value);

  /// Creates [Type] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [type] value does not correspond
  /// to expected format (such as null, empty or METAR/SPECI).
  factory Type(String? type) {
    if (type == null) {
      return none;
    }
    if (type.isEmpty) {
      return none;
    }
    if (type.length != 5) {
      throw FormatException('Report type must have 5 non-space characters '
          'length if not empty, provided `$type`');
    }
    switch (type) {
      case 'METAR':
        return metar;
      case 'SPECI':
        return speci;
      default:
        throw FormatException('Unexpected report type, provided: `$type`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
