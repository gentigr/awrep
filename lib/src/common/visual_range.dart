import 'distance_qualifier.dart';
import 'stable_visual_range.dart';
import 'varying_visual_range.dart';

abstract class VisualRange {
  factory VisualRange(String visualRange) {
    if (visualRange.contains('V')) {
      return VaryingVisualRange(visualRange);
    }
    return StableVisualRange(visualRange);
  }

  /// The lowest visual range distance.
  int get lowestDistance;

  /// The lowest visual range qualifier.
  DistanceQualifier get lowestQualifier;

  /// The highest visual range distance.
  int get highestDistance;

  /// The highest visual range qualifier.
  DistanceQualifier get highestQualifier;
}
