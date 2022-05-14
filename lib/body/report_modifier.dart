/// Modifier of [Report]
///
/// [none] determines situation when no specific type is provided by report.
enum ReportModifier {
  none,
  auto,
  cor,
}

/// [ReportModifierException] is thrown when there is no corresponding Report
/// Modifier for provided string representation.
class ReportModifierException implements Exception {
  final String message;

  const ReportModifierException(this.message);

  String errMsg() => this.message;
}

/// The extension adds [string] getter to represent [ReportModifier] enum value.
extension ReportModifierExtension on ReportModifier {
  String get string {
    if (this == ReportModifier.none) {
      return '';
    }
    return this.name.toUpperCase();
  }
}

/// This is a constructor method for [ReportModifier] from String.
ReportModifier stringAsReportModifier(String? modifier) {
  if (modifier == null || modifier.trim().isEmpty) {
    return ReportModifier.none;
  }
  try {
    return ReportModifier.values.byName(modifier.trim().toLowerCase());
  } on ArgumentError catch (e) {
    print('Unexpected report modifier value: `$modifier`, error: `$e`');
    throw ReportModifierException(
        'Unexpected report modifier value: `$modifier`, error: `$e`');
  }
}
