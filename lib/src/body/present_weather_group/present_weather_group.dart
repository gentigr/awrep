import 'package:metar/src/body/present_weather_group/phenomena/obscuration.dart';
import 'package:metar/src/body/present_weather_group/phenomena/other_phenomena.dart';
import 'package:metar/src/body/present_weather_group/phenomena/precipitation.dart';
import 'package:metar/src/body/present_weather_group/qualifier/descriptor.dart';
import 'package:metar/src/body/present_weather_group/qualifier/intensity.dart';
import 'package:metar/src/body/present_weather_group/qualifier/proximity.dart';
import 'package:metar/src/common/regexp_decorator.dart';

/// The class represents present weather group of a [Metar].
class PresentWeatherGroup {
  final String _weatherGroup;

  /// Constructs a [PresentWeatherGroup] object from string representation.
  ///
  /// Provided string is in IDDPP format usually, where I is intensity,
  /// DD is a descriptor, PP is a phenomena.
  /// Throws [FormatException] if the provided value is not comply with format.
  PresentWeatherGroup(this._weatherGroup) {
    var regExp = RegExpDecorator(r'^(-|\+|VC)?'
        '(MI|PR|BC|DR|BL|SH|TS|FZ)?'
        '((DZ|RA|SN|SG|IC|PL|GR|GS|UP)|'
        '(BR|FG|FU|VA|DU|SA|HZ|PY)|'
        '(PO|SQ|FC|SS|DS)){1}\$');
    regExp.verifySingleMatch(_weatherGroup, this.runtimeType.toString());
  }

  /// The intensity of a weather phenomena.
  Intensity get intensity {
    var regExp = RegExpDecorator(r'^(?<intensity>(-|\+))');
    return Intensity(regExp.getMatchByNameOptional(_weatherGroup, 'intensity'));
  }

  /// The proximity of a weather phenomena.
  Proximity get proximity {
    var regExp = RegExpDecorator('^(?<proximity>(VC))');
    return Proximity(regExp.getMatchByNameOptional(_weatherGroup, 'proximity'));
  }

  /// The descriptor of a weather phenomena.
  Descriptor get descriptor {
    var regExp =
        RegExpDecorator(r'^(-|\+|VC)?(?<descriptor>(MI|PR|BC|DR|BL|SH|TS|FZ))');
    return Descriptor(
        regExp.getMatchByNameOptional(_weatherGroup, 'descriptor'));
  }

  /// The precipitation of a weather phenomena.
  Precipitation get precipitation {
    var regExp =
        RegExpDecorator('(?<precipitation>(DZ|RA|SN|SG|IC|PL|GR|GS|UP))\$');
    return Precipitation(
        regExp.getMatchByNameOptional(_weatherGroup, 'precipitation'));
  }

  /// The obscuration of a weather phenomena.
  Obscuration get obscuration {
    var regExp = RegExpDecorator('(?<obscuration>(BR|FG|FU|VA|DU|SA|HZ|PY))\$');
    return Obscuration(
        regExp.getMatchByNameOptional(_weatherGroup, 'obscuration'));
  }

  /// The other weather phenomena.
  OtherPhenomena get other {
    var regExp = RegExpDecorator('(?<other>(PO|SQ|FC|SS|DS))\$');
    return OtherPhenomena(
        regExp.getMatchByNameOptional(_weatherGroup, 'other'));
  }

  @override
  String toString() {
    return '$intensity$proximity$descriptor$precipitation$obscuration$other';
  }

  @override
  bool operator ==(Object other) {
    return other is PresentWeatherGroup && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _weatherGroup.hashCode;
}
