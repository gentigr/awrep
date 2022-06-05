/// The obscuration weather phenomena of a [PresentWeatherGroup].
enum Obscuration {
  /// The value represents no obscuration is observed.
  none._instance(''),

  /// The value represents 'mist' obscuration is observed.
  mist._instance('BR'),

  /// The value represents 'fog' obscuration is observed.
  fog._instance('FG'),

  /// The value represents 'smoke' obscuration is observed.
  smoke._instance('FU'),

  /// The value represents 'volcanic ash' obscuration is observed.
  volcanicAsh._instance('VA'),

  /// The value represents 'widespread dust' obscuration is observed.
  widespreadDust._instance('DU'),

  /// The value represents 'sand' obscuration is observed.
  sand._instance('SA'),

  /// The value represents 'haze' obscuration is observed.
  haze._instance('HZ'),

  /// The value represents 'spray' obscuration is observed.
  spray._instance('PY');

  final String _value;

  const Obscuration._instance(this._value);

  /// Creates [Obscuration] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [obscuration] value does not
  /// correspond to expected format.
  factory Obscuration(String? obscuration) {
    if (obscuration == null || obscuration.isEmpty) {
      return none;
    }

    if (obscuration.length != 2) {
      throw FormatException('Present weather group obscuration must have 2 '
          'non-space characters length if not empty, provided `$obscuration`');
    }

    try {
      return Obscuration.values.firstWhere((e) => e.toString() == obscuration);
    } on StateError catch (e) {
      throw FormatException('Unexpected present weather group obscuration '
          'weather phenomena, provided: `$obscuration`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
