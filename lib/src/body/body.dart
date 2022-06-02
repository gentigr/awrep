import 'date_time.dart';
import 'modifier.dart';
import 'runway_visual_range.dart';
import 'type.dart';
import 'visibility.dart';
import 'wind.dart';
import '../common/regexp_decorator.dart';

/// The class represents body section of a [Metar].
class Body {
  final String _body;

  const Body(this._body);

  /// The type of a [Metar] body.
  Type get type {
    var regExp = RegExpDecorator('^((?<report_type>[^ ]{5}) )?');
    return Type(regExp.getMatchByNameOptional(_body, 'report_type'));
  }

  /// The station identifier from a [Metar] body.
  String get stationId {
    var regExp = RegExpDecorator('^([^ ]{5} )?(?<station_id>[A-Za-z]{4} )');
    return regExp.getMatchByName(_body, 'station_id').trim();
  }

  /// The date and time of the a [Metar] body.
  DateTime get dateTime {
    var regExp = RegExpDecorator('(?<date_time>\\d{6}Z)');
    return DateTime(regExp.getMatchByName(_body, 'date_time'));
  }

  /// The modifier of a [Metar] body.
  Modifier get modifier {
    var regExp = RegExpDecorator(' (?<modifier>AUTO|COR) ');
    return Modifier(regExp.getMatchByNameOptional(_body, 'modifier'));
  }

  /// The wind section of a [Metar] body.
  Wind get wind {
    var regExp = RegExpDecorator('(?<wind>(\\d{3}|VRB)\\d{2,3}'
        '(G\\d{2,3})?KT( \\d{3}V\\d{3})?)');
    return Wind(regExp.getMatchByName(_body, 'wind'));
  }

  /// The visibility of a [Metar] body.
  Visibility get visibility {
    var regExp = RegExpDecorator(' (?<visibility>[0-9 \/PM]{1,5}SM) ');
    return Visibility(regExp.getMatchByName(_body, 'visibility'));
  }

  /// The runway visual ranges of a [Metar] body.
  List<RunwayVisualRange> get runwayVisualRanges {
    var regExp = RegExpDecorator('(?<runway_visual_range>R[^ .]*FT)');
    var rangeMatches = regExp.getMatchesByName(_body, 'runway_visual_range');
    var ranges = <RunwayVisualRange>[];
    for (var rangeStr in rangeMatches) {
      ranges.add(RunwayVisualRange(rangeStr));
    }
    return ranges;
  }

  @override
  String toString() {
    return this._body;
  }

  @override
  bool operator ==(Object other) {
    return other is Body && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _body.hashCode;
}
