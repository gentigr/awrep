/// The descriptor qualifier of a [PresentWeatherGroup].
enum Descriptor {
  /// The value represents no descriptor of the observation.
  none._instance(''),

  /// The value represents 'shallow' descriptor of the observation.
  shallow._instance('MI'),

  /// The value represents 'partial' descriptor of the observation.
  partial._instance('PR'),

  /// The value represents 'patches' descriptor of the observation.
  patches._instance('BC'),

  /// The value represents 'low drifting' descriptor of the observation.
  lowDrifting._instance('DR'),

  /// The value represents 'blowing' descriptor of the observation.
  blowing._instance('BL'),

  /// The value represents 'shower' descriptor of the observation.
  shower._instance('SH'),

  /// The value represents 'thunderstorm' descriptor of the observation.
  thunderstorm._instance('TS'),

  /// The value represents 'freezing' descriptor of the observation.
  freezing._instance('FZ');

  final String _value;

  const Descriptor._instance(this._value);

  /// Creates [Descriptor] enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [descriptor] value does not
  /// correspond to expected format.
  factory Descriptor(String? descriptor) {
    if (descriptor == null || descriptor.isEmpty) {
      return none;
    }

    if (descriptor.length != 2) {
      throw FormatException('Present weather group descriptor must have 2 '
          'non-space characters length if not empty, provided `$descriptor`');
    }

    try {
      return Descriptor.values.firstWhere((e) => e.toString() == descriptor);
    } on StateError catch (e) {
      throw FormatException('Unexpected present weather group descriptor '
          'qualifier, provided: `$descriptor`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
