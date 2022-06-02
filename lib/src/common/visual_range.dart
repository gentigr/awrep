import 'package:metar/src/common/distance_qualifier.dart';
import 'package:metar/src/common/stable_visual_range.dart';
import 'package:metar/src/common/varying_visual_range.dart';

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
