import 'body/body.dart';
import 'remarks/remarks.dart';

/// The class represents METAR/SPECI type of report.
///
/// The class holds [Body] and [Remarks] sections of a report. The
/// implementation follows the technique of writing Dart code:
/// [AVOID storing what you can calculate.](https://dart.dev/guides/language/effective-dart/usage#avoid-storing-what-you-can-calculate).
/// As a result it may have additional performance penalty in comparison to the
/// libraries that parses provided METAR/SPECI report completely during object
/// construction phase.
class Metar {
  static const String _remarksToken = ' RMK ';
  final String _report;

  /// Constructs a [Metar] object from string representation of METAR/SPECI.
  const Metar(this._report);

  /// The body section of a [Metar].
  Body get body {
    var body = _report;
    var index = _report.indexOf(_remarksToken);
    if (index != -1) {
      body = _report.substring(0, index);
    }
    return Body(body);
  }

  /// The [Remarks] section of a [Metar].
  Remarks get remarks {
    var remarks = '';
    var index = _report.indexOf(_remarksToken);
    if (index != -1) {
      remarks = _report.substring(index + 1);
    }
    return Remarks(remarks);
  }

  /// Returns string representation of a [Metar] object.
  ///
  /// The method intentionally re-creates string representation of METAR/SPECI
  /// report for additional cross-check whether all report's fields were parsed
  /// and recognized as expected.
  @override
  String toString() {
    if (remarks.toString().isEmpty) {
      return body.toString();
    }
    return '$body $remarks';
  }

  @override
  bool operator ==(Object other) {
    return other is Metar && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _report.hashCode;
}
