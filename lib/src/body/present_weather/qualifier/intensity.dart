/// The intensity qualifier of a [PresentWeatherGroup].
enum Intensity {
  /// The value represents light intensity.
  light._instance('-'),

  /// The value represents moderate intensity.
  moderate._instance(''),

  /// The value represents heavy intensity.
  heavy._instance('+');

  final String _value;

  const Intensity._instance(this._value);

  /// Creates [Intensity] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [intensity] value does not
  /// correspond to expected format.
  factory Intensity(String? intensity) {
    if (intensity == null) {
      return moderate;
    }
    if (intensity.isEmpty) {
      return moderate;
    }
    if (intensity.length != 1) {
      throw FormatException('Present weather group intensity must have 1 '
          'non-space characters length if not empty, provided `$intensity`');
    }
    switch (intensity) {
      case '-':
        return light;
      case '+':
        return heavy;
      default:
        throw FormatException('Unexpected present weather group intensity '
            'qualifier, provided: `$intensity`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
