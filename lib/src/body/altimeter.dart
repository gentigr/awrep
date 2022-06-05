import 'package:metar/src/common/regexp_decorator.dart';

/// The class represents altimeter group within [Metar].
class Altimeter {
  final String _altimeter;

  /// Constructs an [Altimeter] from string representation.
  ///
  /// Provided string should be in APhPhPhPh format to be parsed properly, where
  /// PhPhPhPh is a four digit group in inches of mercury.
  /// Throws [FormatException] if the provided value is not by format.
  Altimeter(this._altimeter) {
    var regExp = RegExpDecorator('^A\\d{4}\$');
    regExp.verifySingleMatch(_altimeter, this.runtimeType.toString());
  }

  /// The reported altimeter value.
  int get asInteger {
    var regExp = RegExpDecorator('^A(?<altimeter>\\d{4})\$');
    return int.parse(regExp.getMatchByName(_altimeter, 'altimeter'));
  }

  @override
  String toString() {
    return 'A$asInteger';
  }

  @override
  bool operator ==(Object other) {
    return other is Altimeter && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _altimeter.hashCode;
}
