/// The precipitation weather phenomena of a [PresentWeatherGroup].
enum Precipitation {
  /// The value represents no precipitation is observed.
  none._instance(''),

  /// The value represents 'drizzle' precipitation is observed.
  drizzle._instance('DZ'),

  /// The value represents 'rain' precipitation is observed.
  rain._instance('RA'),

  /// The value represents 'snow' precipitation is observed.
  snow._instance('SN'),

  /// The value represents 'snow grains' precipitation is observed.
  snowGrains._instance('SG'),

  /// The value represents 'ice crystals' precipitation is observed.
  iceCrystals._instance('IC'),

  /// The value represents 'ice pellets' precipitation is observed.
  icePellets._instance('PL'),

  /// The value represents 'hail' precipitation is observed.
  hail._instance('GR'),

  /// The value represents 'snow pellets' precipitation is observed.
  snowPellets._instance('GS'),

  /// The value represents 'unknown' precipitation is observed.
  unknown._instance('UP');

  final String _value;

  const Precipitation._instance(this._value);

  /// Creates [Precipitation] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [precipitation] value does not
  /// correspond to expected format.
  factory Precipitation(String? precipitation) {
    if (precipitation == null || precipitation.isEmpty) {
      return none;
    }

    if (precipitation.length != 2) {
      throw FormatException('Present weather group precipitation must have 2 '
          'non-space characters length if not empty, provided `$precipitation`');
    }

    try {
      return Precipitation.values
          .firstWhere((e) => e.toString() == precipitation);
    } on StateError catch (e) {
      throw FormatException('Unexpected present weather group precipitation '
          'weather phenomena, provided: `$precipitation`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
