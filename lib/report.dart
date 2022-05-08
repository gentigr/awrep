import 'package:awrep/body/body.dart';
import 'package:awrep/remarks/remarks.dart';
import 'package:awrep/report_parser.dart';

// The primary report class that holds Body and Remarks
class Report {
  final Body _body;
  final Remarks _remarks;

  Report(String report)
      : _body = Body(ReportParser.getBody(report)),
        _remarks = Remarks(ReportParser.getRemarks(report));

  @override
  String toString() {
    if (_remarks.toString().isEmpty) {
      return _body.toString();
    }
    return "$_body RMK $_remarks";
  }
}
