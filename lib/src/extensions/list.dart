/// An extension on `List` to filter out duplicate elements based on a specified identifier.
///
/// This extension provides a `unique` method that removes duplicate entries
/// from the list, optionally using a custom identifier function.
///
/// The method also supports in-place filtering for efficient memory usage.
extension Unique<E, Id> on List<E> {
  /// Returns a new list with unique elements, filtered by the provided [id] function.
  ///
  /// If an [id] function is provided, it is used to determine uniqueness based on the
  /// result of applying [id] to each element. If [id] is `null`, elements themselves
  /// are used as identifiers.
  ///
  /// Parameters:
  /// - [id] (optional): A function that returns a unique identifier of type `Id`
  ///   for each element, used to filter duplicates. If omitted, the element itself
  ///   is treated as the unique identifier.
  /// - [inplace] (optional): If `true`, modifies the original list in place; if `false`,
  ///   returns a new list with unique elements. Defaults to `true`.
  ///
  /// Returns:
  /// A `List<E>` containing unique elements based on the specified [id] or the elements
  /// themselves if no [id] function is provided.
  ///
  /// Example usage:
  /// ```dart
  /// final list = [1, 2, 2, 3, 4, 4];
  /// final uniqueList = list.unique();
  /// print(uniqueList); // Output: [1, 2, 3, 4]
  ///
  /// final people = [
  ///   Person(id: 1, name: 'Alice'),
  ///   Person(id: 2, name: 'Bob'),
  ///   Person(id: 1, name: 'Alice Duplicate'),
  /// ];
  /// final uniquePeople = people.unique((person) => person.id);
  /// print(uniquePeople.map((p) => p.name)); // Output: ['Alice', 'Bob']
  /// ```
  ///
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set ids = {};
    final List<E> list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

/// An extension on nullable `List` to provide convenience methods for checking nullability and emptiness.
///
/// This extension adds getters that make it easier to check if a list is null,
/// empty, or both in a single operation.
extension ListNullability on List? {
  /// Returns `true` if the list is either not null and not empty.
  ///
  /// This is the inverse of [isNotEmptyOrNull].
  ///
  /// Example usage:
  /// ```dart
  /// List<int>? list = [1, 2, 3];
  /// print(list.isNotNullOrEmpty); // Output: true
  ///
  /// list = [];
  /// print(list.isNotNullOrEmpty); // Output: false
  ///
  /// list = null;
  /// print(list.isNotNullOrEmpty); // Output: false
  /// ```
  ///
  /// This is identical to [isNotNullOrEmpty].
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns `true` if the list is either not null and not empty.
  ///
  /// This is the inverse of [isEmptyOrNull].
  ///
  /// Example usage:
  /// ```dart
  /// List<int>? list = [1, 2, 3];
  /// print(list.isNotEmptyOrNull); // Output: true
  ///
  /// list = [];
  /// print(list.isNotEmptyOrNull); // Output: false
  ///
  /// list = null;
  /// print(list.isNotEmptyOrNull); // Output: false
  /// ```
  ///
  /// This is identical to [isNotNullOrEmpty].
  bool get isNotEmptyOrNull => !isNullOrEmpty;

  /// Returns `true` if the list is either null or empty.
  ///
  /// Example usage:
  /// ```dart
  /// List<int>? list = null;
  /// print(list.isNullOrEmpty); // Output: true
  ///
  /// list = [];
  /// print(list.isNullOrEmpty); // Output: true
  ///
  /// list = [1, 2, 3];
  /// print(list.isNullOrEmpty); // Output: false
  /// ```
  ///
  /// This is identical to [isEmptyOrNull].
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the list is either null or empty.
  ///
  /// Example usage:
  /// ```dart
  /// List<int>? list = null;
  /// print(list.isEmptyOrNull); // Output: true
  ///
  /// list = [];
  /// print(list.isEmptyOrNull); // Output: true
  ///
  /// list = [1, 2, 3];
  /// print(list.isEmptyOrNull); // Output: false
  /// ```
  ///
  /// This is identical to [isEmptyOrNull].
  bool get isEmptyOrNull => isNullOrEmpty;
}
