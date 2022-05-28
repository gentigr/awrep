/// A regular expression pattern decorator.
class RegExpDecorator {
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
    return _regExp.firstMatch(input)!.namedGroup(groupName)!;
  }

  /// Returns match from [input] by [groupName] if exists, null otherwise.
  ///
  /// It is expected that initially provided regular expression does not have
  /// any optional groups defined.
  String? getMatchByNameOptional(String input, String groupName) {
    if (!_regExp.hasMatch(input)) {
      return null;
    }
    return getMatchByName(input, groupName);
  }
}
