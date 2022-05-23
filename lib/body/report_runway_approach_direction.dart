/// Approach Direction of [ReportRunway]
///
/// [none] determines situation when no specific type is provided by report.
enum ReportRunwayApproachDirection {
  none,
  left,
  center,
  right,
}

/// [ReportRunwayApproachDirectionException] is thrown when there is no
/// corresponding [ReportRunwayApproachDirection] for provided string
/// representation.
class ReportRunwayApproachDirectionException implements Exception {
  final String message;

  const ReportRunwayApproachDirectionException(this.message);

  String errMsg() => this.message;
}

/// The extension adds [string] getter to represent
/// [ReportRunwayApproachDirectionException] enum value.
extension ReportRunwayApproachDirectionExtension
    on ReportRunwayApproachDirection {
  String get string {
    if (this == ReportRunwayApproachDirection.none) {
      return '';
    }
    return this.name.toUpperCase()[0];
  }
}

/// The constructor function to create [ReportRunwayApproachDirection]
/// from String.
ReportRunwayApproachDirection stringAsReportRunwayApproachDirection(
    String? direction) {
  if (direction == null || direction.trim().isEmpty) {
    return ReportRunwayApproachDirection.none;
  }
  switch (direction.trim().toLowerCase()[0]) {
    case 'l':
      return ReportRunwayApproachDirection.left;
    case 'c':
      return ReportRunwayApproachDirection.center;
    case 'r':
      return ReportRunwayApproachDirection.right;
    default:
      print('Unexpected report runway approach direction value: `$direction`');
      throw ReportRunwayApproachDirectionException(
          'Unexpected report runway approach direction value: `$direction`');
  }
}
