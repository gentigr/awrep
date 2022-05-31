/// Type of Report
///
/// [none] determines situation when no specific type is provided by report.
enum ReportType {
  none,
  metar,
  speci,
}

/// [ReportTypeException] is thrown when there is no corresponding Report Type
/// for provided string representation.
class ReportTypeException implements Exception {
  final String message;

  const ReportTypeException(this.message);

  String errMsg() => this.message;
}

/// This extension adds [string] getter to represent [ReportType] enum value.
extension ReportTypeExtension on ReportType {
  String get string {
    if (this == ReportType.none) {
      return '';
    }
    return this.name.toUpperCase();
  }
}

/// This is a constructor method for [ReportType] from String.
ReportType stringAsReportType(String? type) {
  if (type == null || type.trim().isEmpty) {
    return ReportType.none;
  }
  try {
    return ReportType.values.byName(type.trim().toLowerCase());
  } on ArgumentError catch (e) {
    throw ReportTypeException(
        'Unexpected report type value: `$type`, error: `$e`');
  }
}
