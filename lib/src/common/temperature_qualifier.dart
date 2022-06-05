/// The qualifier for temperatures to include sub-zero temperatures.
enum TemperatureQualifier {
  /// The value represents situation when no qualifier is provided.
  none._instance(''),

  /// The value represents situation when sub-zero temperature is reported.
  minus._instance('M');

  final String _value;

  const TemperatureQualifier._instance(this._value);

  /// Creates [TemperatureQualifier] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [temperatureQualifier] value
  /// does not correspond to expected format (such as null, empty or 'M').
  factory TemperatureQualifier(String? temperatureQualifier) {
    if (temperatureQualifier == null || temperatureQualifier.isEmpty) {
      return none;
    }

    if (temperatureQualifier.length > 1) {
      throw FormatException(
          'Temperature qualifier must consist only of 1 non-space '
          'character if not empty, provided `$temperatureQualifier`');
    }
    switch (temperatureQualifier) {
      case 'M':
        return minus;
      default:
        throw FormatException(
            'Unexpected temperature qualifier, must be `M` or empty, but '
            'provided: `$temperatureQualifier`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
