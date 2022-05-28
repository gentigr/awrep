/// Modifier of [Report] distance values
///
/// [none] determines situation when no specific modifier is provided.
enum ReportDistanceModifier {
  none,
  less, // the distance is less than reported
  greater, // the distance is greater than reported
}

/// [ReportDistanceModifierException] is thrown when there is no corresponding
/// [ReportDistanceModifier] for provided string representation.
class ReportDistanceModifierException implements Exception {
  final String message;

  const ReportDistanceModifierException(this.message);

  String errMsg() => this.message;
}

/// The extension adds [string] getter to represent [ReportDistanceModifier]
/// enum value.
extension ReportDistanceModifierExtension on ReportDistanceModifier {
  String get string {
    switch (this) {
      case ReportDistanceModifier.none:
        return '';
      case ReportDistanceModifier.less:
        return 'M';
      case ReportDistanceModifier.greater:
        return 'P';
      default:
        print('Not implemented ReportDistanceModifier value: `$this`');
        throw ReportDistanceModifierException(
            'Not implemented ReportDistanceModifier value: `$this`');
    }
  }
}

/// This is a constructor method for [ReportDistanceModifier] from String.
ReportDistanceModifier stringAsReportDistanceModifier(String? modifier) {
  if (modifier == null || modifier.trim().isEmpty) {
    return ReportDistanceModifier.none;
  }
  switch (modifier.trim().toLowerCase()[0]) {
    case 'm':
      return ReportDistanceModifier.less;
    case 'p':
      return ReportDistanceModifier.greater;
    default:
      print('Unexpected report distance modifier value: `$modifier`');
      throw ReportDistanceModifierException(
          'Unexpected report distance modifier value: `$modifier`');
  }
}
