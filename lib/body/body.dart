// Body section of METAR/SPECI report.
class Body {
  String _body;

  Body(this._body);

  @override
  String toString() {
    return this._body;
  }
}