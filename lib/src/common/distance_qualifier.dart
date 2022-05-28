/// The qualifier for distances to specify better or worse conditions.
enum DistanceQualifier {
  /// The value represents situation when no qualifier is provided.
  none._instance(''),

  /// The value represents situation when the distance is less than reported.
  less._instance('M'),

  /// The value represents situation when the distance is more than reported.
  more._instance('P');

  final String _value;

  const DistanceQualifier._instance(this._value);

  /// Creates [DistanceQualifier] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [distanceQualifier] value
  /// does not correspond to expected format (such as null, empty or one
  /// non-space symbol such as 'M' or 'P').
  factory DistanceQualifier(String? distanceQualifier) {
    if (distanceQualifier == null) {
      return none;
    }
    String value = distanceQualifier.trim().toUpperCase();
    if (value.isEmpty) {
      return none;
    }
    if (value.length > 1) {
      throw FormatException(
          'Distance qualifier must consist only of 1 non-space '
          'character, provided `$distanceQualifier`');
    }
    switch (value) {
      case 'M':
        return less;
      case 'P':
        return more;
      default:
        throw FormatException(
            'Unexpected distance qualifier, must be [M|P] but '
            ' provided: `$distanceQualifier`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
