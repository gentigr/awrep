import 'package:metar/src/body/altimeter.dart';
import 'package:metar/src/body/date_time.dart';
import 'package:metar/src/body/modifier.dart';
import 'package:metar/src/body/present_weather/present_weather.dart';
import 'package:metar/src/body/runway_visual_range.dart';
import 'package:metar/src/body/sky_condition/sky_condition.dart';
import 'package:metar/src/body/temperature_dew_point.dart';
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
  ///
  /// Returns null if there is no wind reported.
  Wind? get wind {
    var regExp = RegExpDecorator('(?<wind>(\\d{3}|VRB)\\d{2,3}'
        '(G\\d{2,3})?KT( \\d{3}V\\d{3})?)');
    var value = regExp.getMatchByNameOptional(_body, 'wind');
    return value == null ? null : Wind(value);
  }

  /// The visibility of a [Metar] body.
  ///
  /// Returns null if there is no visibility reported.
  Visibility? get visibility {
    var regExp = RegExpDecorator(' (?<visibility>[0-9 \/PM]{1,5}SM) ');
    var value = regExp.getMatchByNameOptional(_body, 'visibility');
    if (value == null) {
      return null;
    }
    return Visibility(value);
  }

  /// The runway visual ranges of a [Metar] body.
  List<RunwayVisualRange> get runwayVisualRanges {
    var regExp = RegExpDecorator('(?<runway_visual_range>(R[^ .]*FT)|(RVRNO))');
    var rangeMatches = regExp.getMatchesByName(_body, 'runway_visual_range');
    var ranges = <RunwayVisualRange>[];
    for (var rangeStr in rangeMatches) {
      ranges.add(RunwayVisualRange(rangeStr));
    }
    return ranges;
  }

  /// The present weather groups of a [Metar] body.
  List<PresentWeather> get presentWeather {
    var regExp = RegExpDecorator(r'(?<present_weather>(-|\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?((MI|PR|BC|DR|BL|SH|TS|FZ)|'
        '(DZ|RA|SN|SG|IC|PL|GR|GS|UP){1,3}|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|(PO|SQ|FC|SS|DS)))');
    var groupMatches = regExp.getMatchesByName(_body, 'present_weather');
    var groups = <PresentWeather>[];
    for (var groupStr in groupMatches) {
      groups.add(PresentWeather(groupStr));
    }
    return groups;
  }

  /// The sky condition groups of a [Metar] body.
  List<SkyCondition> get skyCondition {
    var regExp = RegExpDecorator(
        '(?<sky_condition>(VV|SKC|CLR|FEW|SCT|BKN|OVC)(\\d{1,3}(CB|TCU)?)?)');
    var groupMatches = regExp.getMatchesByName(_body, 'sky_condition');
    var groups = <SkyCondition>[];
    for (var groupStr in groupMatches) {
      groups.add(SkyCondition(groupStr));
    }
    return groups;
  }

  /// The temperature/dew point group of a [Metar] body.
  TemperatureDewPoint? get temperatureDewPoint {
    var regExp = RegExpDecorator(' (?<temp_dew_point>M?\\d{2}\\/(M?\\d{2})?)');
    var value = regExp.getMatchByNameOptional(_body, 'temp_dew_point');
    if (value == null) {
      return null;
    }
    return TemperatureDewPoint(value);
  }

  /// The altimeter group of a [Metar] body.
  Altimeter? get altimeter {
    var regExp = RegExpDecorator('(?<altimeter>A\\d{4})');
    var value = regExp.getMatchByNameOptional(_body, 'altimeter');
    if (value == null) {
      return null;
    }
    return Altimeter(value);
  }

  /// The true value if end of message sign is present in a [Metar] body.
  bool get endOfMessage {
    var regExp = RegExpDecorator('(?<end_of_message>=)\$');
    var value = regExp.getMatchByNameOptional(_body, 'end_of_message');
    return value != null;
  }

  @override
  String toString() {
    String typeStr = (type == Type.none ? '' : '$type ');
    String modifierStr = (modifier == Modifier.none ? '' : '$modifier ');
    String windStr = _formatOptional(wind);
    String visibilityStr = _formatOptional(visibility);
    String temperatureDewPointStr = _formatOptional(temperatureDewPoint);
    String altimeterStr = _formatOptional(altimeter);
    return '$typeStr$stationId $dateTime $modifierStr$windStr$visibilityStr'
                '${_format(runwayVisualRanges)}'
                '${_format(presentWeather)}'
                '${_format(skyCondition)}'
                '$temperatureDewPointStr$altimeterStr'
            .trim() +
        '${endOfMessage ? '=' : ''}';
  }

  @override
  bool operator ==(Object other) {
    return other is Body && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _body.hashCode;

  String _format<T>(List<T> list) {
    String str = '';
    for (var item in list) {
      str += '$item ';
    }
    return str;
  }

  String _formatOptional<T>(T? object) {
    String str = object?.toString() ?? '';
    if (str.isNotEmpty) {
      str += ' ';
    }
    return str;
  }
}
