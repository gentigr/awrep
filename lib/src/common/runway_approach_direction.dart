/// Runway approach direction (left/center/right).
///
/// [none] determines situation when no direction is provided.
enum RunwayApproachDirection {
  none,
  left,
  center,
  right,
}

/// [RunwayApproachDirectionException] is thrown when there is no
/// corresponding [RunwayApproachDirection] for provided string
/// representation.
class RunwayApproachDirectionException implements Exception {
  final String message;

  const RunwayApproachDirectionException(this.message);

  String errMsg() => this.message;
}

/// The extension for [RunwayApproachDirection] enum.
extension RunwayApproachDirectionExtension on RunwayApproachDirection {
  /// Represents [RunwayApproachDirection] enum value as String value.
  String get string {
    if (this == RunwayApproachDirection.none) {
      return '';
    }
    return this.name.toUpperCase()[0];
  }
}

/// The constructor function to create [RunwayApproachDirection] from String.
RunwayApproachDirection stringAsRunwayApproachDirection(String? direction) {
  if (direction == null || direction.trim().isEmpty) {
    return RunwayApproachDirection.none;
  }
  switch (direction.trim().toUpperCase()[0]) {
    case 'L':
      return RunwayApproachDirection.left;
    case 'C':
      return RunwayApproachDirection.center;
    case 'R':
      return RunwayApproachDirection.right;
    default:
      print('Unexpected report runway approach direction value: `$direction`');
      throw RunwayApproachDirectionException(
          'Unexpected report runway approach direction value: `$direction`');
  }
}
