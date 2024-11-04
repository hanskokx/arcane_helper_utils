extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set ids = {};
    final List<E> list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
