/// A regular expression pattern decorator.
class RegExpDecorator {
  // Note: the implementation uses composition due to the fact RegExp uses
  // factor constructor, the most straightforward way to implement correct
  // decorator would be to use `implements RegExp` and define all methods or
  // use reflection; since only limited amount of methods are used, for that
  // purpose current approach is considered acceptable.
  final RegExp _regExp;

  /// Constructs a regular expression decorator.
  RegExpDecorator(String regExp) : _regExp = RegExp(regExp);

  /// Verifies that [input] contains exactly one match using [_regExp].
  ///
  /// Throws [FormatException] otherwise.
  void verifySingleMatch(String input, String source) {
    var count = _regExp.allMatches(input).length;
    if (count != 1) {
      throw FormatException('Expected to find one match of `$source` format in '
          '`$input`, but found `$count` using `$_regExp`');
    }
  }

  /// Returns match from [input] by [groupName].
  ///
  /// It is expected that initially provided regular expression does not have
  /// any optional groups defined.
  String getMatchByName(String input, String groupName) {
    verifySingleMatch(input, groupName);
    return _getMatchByNameOptional(input, groupName)!;
  }

  /// Returns match from [input] by [groupName] if exists, null otherwise.
  ///
  /// It is expected that initially provided regular expression does not have
  /// any optional groups defined.
  String? getMatchByNameOptional(String input, String groupName) {
    if (!_regExp.hasMatch(input)) {
      return null;
    }
    return _getMatchByNameOptional(input, groupName);
  }

  String toString() {
    return _regExp.toString();
  }

  String? _getMatchByNameOptional(String input, String groupName) {
    var value = _regExp.firstMatch(input)!.namedGroup(groupName);
    if (value != null) {
      verifySingleMatch(input, groupName);
    }
    return value;
  }
}
