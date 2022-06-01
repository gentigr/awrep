// Remarks section of METAR/SPECI report.
class Remarks {
  String _remarks;

  Remarks(this._remarks);

  @override
  bool operator ==(Object other) {
    return other is Remarks && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _remarks.hashCode;

  @override
  String toString() {
    return this._remarks;
  }
}