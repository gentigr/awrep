/// The other weather phenomena of a [PresentWeatherGroup].
enum OtherPhenomena {
  /// The value represents no weather phenomena.
  none._instance(''),

  /// The value represents 'well-developed dust/sand whirls' weather phenomena.
  whirls._instance('PO'),

  /// The value represents 'squalls' weather phenomena.
  squalls._instance('SQ'),

  /// The value represents 'funnel cloud tornado waterspout' weather phenomena.
  funnelCloud._instance('FC'),

  /// The value represents 'sandstorm' weather phenomena.
  sandstorm._instance('SS'),

  /// The value represents 'duststorm' weather phenomena.
  duststorm._instance('DS');

  final String _value;

  const OtherPhenomena._instance(this._value);

  /// Creates [OtherPhenomena] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [phenomena] value does not
  /// correspond to expected format.
  factory OtherPhenomena(String? phenomena) {
    if (phenomena == null || phenomena.isEmpty) {
      return none;
    }

    if (phenomena.length != 2) {
      throw FormatException('Present weather group other phenomena must have 2 '
          'non-space characters length if not empty, provided `$phenomena`');
    }

    try {
      return OtherPhenomena.values.firstWhere((e) => e.toString() == phenomena);
    } on StateError catch (e) {
      throw FormatException('Unexpected present weather group other phenomena '
          'weather phenomena, provided: `$phenomena`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
