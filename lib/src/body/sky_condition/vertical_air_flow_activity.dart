/// The reportable vertical air flow activity in sky condition group at manual
/// stations in a [Metar].
enum VerticalAirFlowActivity {
  /// The value represents no activity reported.
  none._instance(''),

  /// The value represents cumulonimbus presence.
  cumulonimbus._instance('CB'),

  /// The value represents towering cumulus presence.
  toweringCumulus._instance('TCU');

  final String _value;

  const VerticalAirFlowActivity._instance(this._value);

  /// Creates [VerticalAirFlowActivity] enum object from string representation.
  ///
  /// Throws a [FormatException] if specified [activity] value does not
  /// correspond to expected format.
  factory VerticalAirFlowActivity(String? activity) {
    if (activity == null || activity.isEmpty) {
      return none;
    }
    if (activity.length < 2 || activity.length > 3) {
      throw FormatException('Sky condition group vertical air flow activity '
          'must have 2 or 3 non-space characters length if present, '
          'provided `$activity`');
    }
    try {
      return VerticalAirFlowActivity.values
          .firstWhere((e) => e.toString() == activity);
    } on StateError catch (e) {
      throw FormatException('Unexpected sky condition group vertical flow '
          'activity, provided: `$activity`, error: `$e`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
