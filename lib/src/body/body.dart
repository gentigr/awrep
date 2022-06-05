import 'package:metar/src/body/date_time.dart';
import 'package:metar/src/body/modifier.dart';
import 'package:metar/src/body/present_weather_group/present_weather_group.dart';
import 'package:metar/src/body/runway_visual_range.dart';
import 'package:metar/src/body/sky_condition_group/sky_condition_group.dart';
import 'package:metar/src/body/temperature_dew_point_group.dart';
import 'package:metar/src/body/type.dart';
import 'package:metar/src/body/visibility.dart';
import 'package:metar/src/body/wind.dart';
import 'package:metar/src/common/regexp_decorator.dart';

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

  /// The present weather groups of a [Metar] body.
  List<PresentWeatherGroup> get presentWeatherGroups {
    var regExp = RegExpDecorator(r'(?<weather_group>(-|\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?((DZ|RA|SN|SG|IC|PL|GR|GS|UP)|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|(PO|SQ|FC|SS|DS)))');
    var groupMatches = regExp.getMatchesByName(_body, 'weather_group');
    var groups = <PresentWeatherGroup>[];
    for (var groupStr in groupMatches) {
      groups.add(PresentWeatherGroup(groupStr));
    }
    return groups;
  }

  /// The sky condition groups of a [Metar] body.
  List<SkyConditionGroup> get skyConditionGroups {
    var regExp = RegExpDecorator(
        '(?<sky_group>(VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{3}(CB|TCU)?)?)');
    var groupMatches = regExp.getMatchesByName(_body, 'sky_group');
    var groups = <SkyConditionGroup>[];
    for (var groupStr in groupMatches) {
      groups.add(SkyConditionGroup(groupStr));
    }
    return groups;
  }

  /// The temperature/dew point group of a [Metar] body.
  TemperatureDewPointGroup get temperatureDewPointGroup {
    var regExp = RegExpDecorator(' (?<temp_dew_point>M?\\d{2}\\/(M?\\d{2})?)');
    return TemperatureDewPointGroup(
        regExp.getMatchByName(_body, 'temp_dew_point'));
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
