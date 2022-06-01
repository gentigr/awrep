/// The class represents remarks section of a [Report].
class Remarks {
  final String _remarks;

  const Remarks(this._remarks);

  @override
  String toString() {
    return this._remarks;
  }

  @override
  bool operator ==(Object other) {
    return other is Remarks && this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => _remarks.hashCode;
}
