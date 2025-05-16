import "dart:math" show Random;

/// Represents a `List` with a fixed capacity.
///
/// When a new element is added and the list reaches its maximum capacity,
/// the oldest element in the list is automatically removed to make space.
class FixedSizeList<T> implements List<T> {
  final int _capacity;
  final List<T> _list;

  /// Creates a [FixedSizeList] with the specified [capacity].
  ///
  /// The initial list will be empty.
  FixedSizeList(this._capacity, {List<T>? list}) : _list = list ?? <T>[];

  /// Adds a new [element] to the list.
  ///
  /// If the list is already at its maximum [capacity], the oldest element
  /// will be removed before the new [element] is added.
  @override
  void add(T element) {
    _list.add(element);
    if (_list.length > _capacity) {
      _list.removeAt(0);
    }
  }

  factory FixedSizeList.filled(int capacity, T fill) =>
      FixedSizeList(capacity, list: List.filled(capacity, fill));

  factory FixedSizeList.empty(int capacity) =>
      FixedSizeList(capacity, list: List.empty());

  factory FixedSizeList.from(Iterable elements) =>
      FixedSizeList(elements.length, list: List.from(elements));

  factory FixedSizeList.of(Iterable<T> elements) =>
      FixedSizeList(elements.length, list: List.of(elements));

  factory FixedSizeList.generate(int length, T generator(int index)) =>
      FixedSizeList(length, list: List.generate(length, generator));

  /// Returns an unmodifiable view of the current items in the list.
  ///
  /// This prevents external modification of the internal list.
  List<T?> get items => List.unmodifiable(_list);

  // Delegate all other List methods to the internal list
  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    RangeError.checkValidRange(0, _capacity, newLength);
    _list.length = newLength;
  }

  @override
  T operator [](int index) => _list[index];

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
  }

  @override
  void addAll(Iterable<T> iterable) {
    for (final T i in iterable) {
      _list.add(i);
    }
  }

  @override
  bool any(bool Function(T element) test) => _list.any(test);

  @override
  Map<int, T> asMap() => _list.asMap();

  @override
  List<R> cast<R>() => _list.cast<R>();

  @override
  void clear() => _list.clear();

  @override
  bool contains(Object? element) => _list.contains(element);

  @override
  T elementAt(int index) => _list.elementAt(index);

  @override
  bool every(bool Function(T element) test) => _list.every(test);

  @override
  Iterable<E> expand<E>(Iterable<E> Function(T element) toElements) =>
      _list.expand(toElements);

  @override
  T firstWhere(bool Function(T element) test, {T Function()? orElse}) =>
      _list.firstWhere(test, orElse: orElse);

  @override
  E fold<E>(E initialValue, E Function(E previousValue, T element) combine) =>
      _list.fold(initialValue, combine);

  @override
  Iterable<T> followedBy(Iterable<T> other) => _list.followedBy(other);

  @override
  void forEach(void Function(T element) action) => _list.forEach(action);

  @override
  Iterable<T> getRange(int start, int end) => _list.getRange(start, end);

  @override
  int indexOf(T element, [int startIndex = 0]) =>
      _list.indexOf(element, startIndex);

  @override
  int indexWhere(bool Function(T element) test, [int startIndex = 0]) =>
      _list.indexWhere(test, startIndex);

  @override
  void insert(int index, T element) {
    _list.insert(index, element);
    if (_list.length > _capacity) {
      _list.removeAt(0);
    }
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    _list.insertAll(index, iterable);

    while (_list.length > _capacity) {
      _list.removeAt(0);
    }
  }

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  Iterator<T> get iterator => _list.iterator;

  @override
  String join([String separator = ""]) => _list.join(separator);

  @override
  T lastWhere(bool Function(T element) test, {T Function()? orElse}) =>
      _list.lastWhere(test, orElse: orElse);

  @override
  Iterable<E> map<E>(E Function(T e) toElement) => _list.map(toElement);

  @override
  T reduce(T Function(T value, T element) combine) => _list.reduce(combine);

  @override
  T removeAt(int index) => _list.removeAt(index);

  @override
  bool remove(Object? value) => _list.remove(value);

  @override
  void removeRange(int start, int end) => _list.removeRange(start, end);

  @override
  void removeWhere(bool Function(T element) test) => _list.removeWhere(test);

  @override
  void replaceRange(int start, int end, Iterable<T> newContents) =>
      _list.replaceRange(start, end, newContents);

  @override
  void retainWhere(bool Function(T element) test) => _list.retainWhere(test);

  @override
  Iterable<T> get reversed => _list.reversed;

  @override
  void setAll(int index, Iterable<T> iterable) => _list.setAll(index, iterable);

  @override
  void setRange(
    int start,
    int end,
    Iterable<T> iterable, [
    int skipCount = 0,
  ]) =>
      _list.setRange(start, end, iterable, skipCount);

  @override
  T singleWhere(bool Function(T element) test, {T Function()? orElse}) =>
      _list.singleWhere(test, orElse: orElse);

  @override
  Iterable<T> skip(int count) => _list.skip(count);

  @override
  Iterable<T> skipWhile(bool Function(T value) test) => _list.skipWhile(test);

  @override
  List<T> sublist(int start, [int? end]) => _list.sublist(start, end);

  @override
  Iterable<T> take(int count) => _list.take(count);

  @override
  Iterable<T> takeWhile(bool Function(T value) test) => _list.takeWhile(test);

  @override
  List<T> toList({bool growable = true}) => _list.toList(growable: growable);

  @override
  Set<T> toSet() => _list.toSet();

  @override
  String toString() => _list.toString();

  @override
  void sort([Comparator<T>? compare]) => _list.sort(compare);

  @override
  void shuffle([Random? random]) => _list.shuffle(random);

  @override
  T get first => _list.first;

  @override
  T get last => _list.last;

  @override
  T get single => _list.single;

  @override
  List<T> operator +(List<T> other) => _list + other;

  @override
  void fillRange(int start, int end, [T? fillValue]) =>
      _list.fillRange(start, end, fillValue);

  @override
  set first(T value) => _list.first;

  @override
  set last(T value) => _list.last;

  @override
  int lastIndexOf(T element, [int? start]) => _list.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(T element) test, [int? start]) =>
      _list.lastIndexWhere(test as bool Function(T?), start);

  @override
  T removeLast() => _list.removeLast();

  @override
  Iterable<T> where(bool Function(T element) test) =>
      _list.where(test as bool Function(T?)).cast<T>();

  @override
  Iterable<R> whereType<R>() => _list.whereType<R>();
}
