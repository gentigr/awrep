// Body section of METAR/SPECI report.
class Body {
  String _body;

  Body(this._body);

  @override
  bool operator ==(Object other) {
    return other is Body && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _body.hashCode;

  @override
  String toString() {
    return this._body;
  }
}
