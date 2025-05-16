/// Represents a `List` with a fixed capacity.
///
/// When a new element is added and the list reaches its maximum capacity,
/// the oldest element in the list is automatically removed to make space.
class FixedSizeList<T> {
  final int _capacity;
  final List<T?> _list;

  /// Creates a [FixedSizeList] with the specified [capacity].
  ///
  /// The initial list will be empty.
  FixedSizeList(this._capacity) : _list = <T?>[];

  /// Adds a new [element] to the list.
  ///
  /// If the list is already at its maximum [capacity], the oldest element
  /// will be removed before the new [element] is added.
  void add(T? element) {
    _list.add(element);
    if (_list.length > _capacity) {
      _list.removeAt(0);
    }
  }

  /// Returns an unmodifiable view of the current items in the list.
  ///
  /// This prevents external modification of the internal list.
  List<T?> get items => List.unmodifiable(_list);
}
