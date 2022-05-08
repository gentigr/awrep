import 'package:awrep/body/body.dart';
import 'package:awrep/remarks/remarks.dart';

/// The primary report class that holds [body] and [remarks] sections of report.
/// This implementation follows the following technique of writing Dart code:
/// [AVOID storing what you can calculate.](https://dart.dev/guides/language/effective-dart/usage#avoid-storing-what-you-can-calculate)
/// As a result it may have additional performance penalty in comparison to the
/// libraries that parses provided METAR/SPECI report completely during object
/// construction phase.
class Report {
  static const String _remarksToken = " RMK ";
  final String _report;

  /// Initializes Report class with string representation of METAR/SPECI report.
  const Report(this._report);

  /// Compares Report objects for logical equality.
  @override
  bool operator ==(Object other) {
    return other is Report && this.hashCode == other.hashCode;
  }

  /// Provides hashCode of Report object based on internal content.
  @override
  int get hashCode => _report.hashCode;

  /// Creates [Body] initialized with body part of the report.
  Body get body {
    var body = _report;
    var index = _report.indexOf(_remarksToken);
    if (index != -1) {
      body = _report.substring(0, index);
    }
    return Body(body);
  }

  /// Creates [Remarks] initialized with remarks part of the report.
  Remarks get remarks {
    var remarks = '';
    var index = _report.indexOf(_remarksToken);
    if (index != -1) {
      remarks = _report.substring(index + 1);
    }
    return Remarks(remarks);
  }

  /// Generates string representation of the report.
  ///
  /// This method intentionally re-creates string representation of METAR/SPECI
  /// report for additional cross-check whether all report's fields were parsed
  /// and recognized as expected.
  @override
  String toString() {
    if (remarks.toString().isEmpty) {
      return body.toString();
    }
    return "$body $remarks";
  }
}
