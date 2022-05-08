// Set of helper functions to parse aviation weather report
class ReportParser {
  static const String _remarksToken = " RMK ";

  static String getBody(String report) {
    var index = report.indexOf(_remarksToken);
    if (index != -1) {
      return report.substring(0, index);
    }
    return report;
  }

  static String getRemarks(String report) {
    var index = report.indexOf(_remarksToken);
    if (index != -1) {
      return report.substring(index + 1);
    }
    return "";
  }
}