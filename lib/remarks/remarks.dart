// Remarks section of METAR/SPECI report.
class Remarks {
  String _remarks;

  Remarks(this._remarks);

  @override
  String toString() {
    return this._remarks;
  }
}