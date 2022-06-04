/// The sky cover of sky condition group in a [Metar].
enum SkyCover {
  /// The value represents vertical visibility (8/8 of sky cover).
  verticalVisibility._instance('VV'),

  /// The value represents clear sky (0/8 of sky cover) at manual stations when
  /// no layers are reported.
  skyClear._instance('SKC'),

  /// The value represents clear sky (0/8 of sky cover) at automated stations
  /// when no layers at or below 12,000 feet are reported.
  clear._instance('CLR'),

  /// The value represents few clouds (1/8 - 2/8 of sky cover).
  few._instance('FEW'),

  /// The value represents scattered clouds (3/8 - 4/8 of sky cover).
  scattered._instance('SCT'),

  /// The value represents broken clouds (5/8 - 7/8 of sky cover).
  broken._instance('BKN'),

  /// The value represents overcast clouds (8/8 of sky cover).
  overcast._instance('OVC');

  final String _value;

  const SkyCover._instance(this._value);

  /// Creates [SkyCover] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [contraction] value does not
  /// correspond to expected format.
  factory SkyCover(String contraction) {
    if (contraction.isEmpty ||
        contraction.length < 2 ||
        contraction.length > 3) {
      throw FormatException('Sky condition group sky cover must '
          'have 2 or 3 non-space characters length, provided `$contraction`');
    }
    try {
      return SkyCover.values.firstWhere((e) => e.toString() == contraction);
    } on StateError catch (e) {
      throw FormatException('Unexpected sky condition group sky cover, '
          'provided: `$contraction`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
