/// The runway approach direction.
enum RunwayApproachDirection {
  /// The value represents situation when no direction is provided.
  none._instance(''),

  /// The value represents situation when the direction of approach is LEFT.
  left._instance('L'),

  /// The value represents situation when the direction of approach is CENTER.
  center._instance('C'),

  /// The value represents situation when the direction of approach is RIGHT.
  right._instance('R');

  final String _value;

  const RunwayApproachDirection._instance(this._value);

  /// Creates enum object from its string representation.
  ///
  /// Throws a [FormatException] if specified [runwayApproachDirection] value
  /// does not correspond to expected format (such as null, empty or one
  /// non-space symbol).
  factory RunwayApproachDirection(String? runwayApproachDirection) {
    if (runwayApproachDirection == null) {
      return none;
    }
    String value = runwayApproachDirection.trim().toUpperCase();
    if (value.isEmpty) {
      return none;
    }
    if (value.length > 1) {
      throw FormatException('Runway approach direction must consist only of 1 '
          'non-space character, provided `$runwayApproachDirection`');
    }
    switch (value) {
      case 'L':
        return left;
      case 'C':
        return center;
      case 'R':
        return right;
      default:
        throw FormatException('Unexpected runway approach direction, '
            'provided: `$runwayApproachDirection`');
    }
  }

  @override
  String toString() {
    return _value;
  }
}
