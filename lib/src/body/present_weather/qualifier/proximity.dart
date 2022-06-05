/// The proximity qualifier of a [PresentWeatherGroup].
enum Proximity {
  /// The value represents the phenomena at the point of the observation.
  point._instance(''),

  /// The value represents the phenomena in the vicinity of the observation.
  vicinity._instance('VC');

  final String _value;

  const Proximity._instance(this._value);

  /// Creates [Proximity] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [proximity] value does not
  /// correspond to expected format.
  factory Proximity(String? proximity) {
    if (proximity == null || proximity.isEmpty) {
      return point;
    }

    if (proximity.length != 2) {
      throw FormatException('Present weather group proximity must have 2 '
          'non-space characters length if not empty, provided `$proximity`');
    }
    switch (proximity) {
      case 'VC':
        return vicinity;
      default:
        throw FormatException('Unexpected present weather group proximity '
            'qualifier, provided: `$proximity`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
