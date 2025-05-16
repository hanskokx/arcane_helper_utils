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
  FixedSizeList(
    this._capacity, {
    Iterable<T>? value,
  }) : _list = List.from(value ?? <T>[]) {
    assert(
      this._capacity >= 0,
      "List capacity must be a positive number",
    );
    assert(
      _list.length <= _capacity,
      "Initial list length cannot exceed capacity.",
    );
  }

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

  /// Creates a list of the given length with [fill] at each position.
  ///
  /// The [length] must be a non-negative integer. This value will become the
  /// maximum length of the list. The resulting `FixedSizeList` is not growable.
  ///
  /// Example:
  /// ```dart
  /// final zeroList = FixedSizeList<int>.filled(3, 0); // [0, 0, 0]
  /// ```
  ///
  /// After being created and filled, the list is no different from any other
  /// fixed-length list created using any other [FixedSizeList] constructors.
  ///
  /// All elements of the created list share the same [fill] value.
  /// ```dart
  /// final shared = FixedSizeList.filled(3, []);
  /// shared[0].add(499);
  /// print(shared);  // [[499], [499], [499]]
  /// ```
  /// You can use [FixedSizeList.generate] to create a list with a fixed length
  /// and a new object at each position.
  /// ```dart
  /// final unique = FixedSizeList.generate(3, (_) => []);
  /// unique[0].add(499);
  /// print(unique); // [[499], [], []]
  /// ```
  factory FixedSizeList.filled(int length, T fill) =>
      FixedSizeList(length, value: List.filled(length, fill));

  /// Creates a new empty list with a maximum capacity of [capacity].
  ///
  /// ```dart
  /// final fixedLengthList = FixedSizeList.empty(3);
  /// print(fixedLengthList); // []
  /// fixedLengthList.add(1); // [1]
  /// fixedLengthList.add(2); // [1, 2]
  /// fixedLengthList.add(3); // [1, 2, 3]
  /// fixedLengthList.add(4); // [2, 3, 4]
  /// ```
  factory FixedSizeList.empty(int capacity) =>
      FixedSizeList(capacity, value: []);

  /// Creates a `FixedSizeList` containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// All the [elements] should be instances of [T].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <num>[1, 2, 3];
  /// final listFrom = FixedSizeList<int>.from(numbers);
  /// print(listFrom); // [1, 2, 3]
  /// ```
  /// The `elements` iterable itself may have any element type, so this
  /// constructor can be used to down-cast a `FixedSizeList`, for example as:
  /// ```dart import:convert
  /// const jsonArray = '''
  ///   [{"text": "foo", "value": 1, "status": true},
  ///    {"text": "bar", "value": 2, "status": false}]
  /// ''';
  /// final List<dynamic> dynamicList = jsonDecode(jsonArray) as List<dynamic>;
  /// final FixedSizeList<Map<String, dynamic>> fooData =
  ///     FixedSizeList.from(dynamicList.where((x) => x is Map && x['text'] == 'foo'));
  /// print(fooData); // [{text: foo, value: 1, status: true}]
  /// ```
  factory FixedSizeList.from(Iterable elements) =>
      FixedSizeList(elements.length, value: List.from(elements));

  /// Creates a `FixedSizeList` from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// final listOf = FixedSizeList<num>.of(numbers);
  /// print(listOf); // [1, 2, 3]
  /// ```
  factory FixedSizeList.of(Iterable<T> elements) =>
      FixedSizeList(elements.length, value: List.of(elements));

  /// Generates a `FixedSizeList` of values.
  ///
  /// Creates a `FixedSizeList` with [length] positions and fills it with values
  /// created by calling [generator] for each index in the range `0` ..
  /// `length - 1` in increasing order.
  ///
  /// ```dart
  /// final fixedLengthList =
  ///     FixedSizeList<int>.generate(3, (int index) => index * index);
  /// print(fixedLengthList); // [0, 1, 4]
  /// ```
  /// The [length] must be non-negative.
  factory FixedSizeList.generate(int length, T generator(int index)) =>
      FixedSizeList(length, value: List.generate(length, generator));

  /// Returns an unmodifiable view of the current items in the list.
  ///
  /// This prevents external modification of the internal list.
  List<T?> get items => List.unmodifiable(_list);

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
