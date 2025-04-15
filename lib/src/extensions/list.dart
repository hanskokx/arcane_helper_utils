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
  List<E> unique([Object? Function(E element)? id, bool inplace = true]) {
    final Set<Object?> ids = {};
    final List<E> list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x));
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

/// Extension on nullable lists of nullable elements to provide a custom equality check.
extension ListEquality<T> on List<T?>? {
  /// Checks if this list is equal to another list.
  ///
  /// Two lists are considered equal if:
  ///   - Both are null, or
  ///   - Both have the same length, and
  ///   - Elements at the same index are equal.
  ///
  /// Nullable list elements are handled as follows:
  ///   - If both elements at a given index are null, they are considered equal.
  ///   - If one element is null and the other is not, they are considered unequal.
  ///
  /// The type parameter `T` represents the type of elements in the list.
  /// The elements can be nullable (`T?`).
  ///
  /// Example:
  ///
  /// ```dart
  /// List<int?>? list1 = [1, 2, null, 4];
  /// List<int?>? list2 = [1, 2, null, 4];
  /// List<int?>? list3 = [1, 2, 3, 4];
  /// List<int?>? list4 = null;
  /// List<int?>? list5 = [1, 2, 3, null];
  ///
  /// print(list1.equals(list2)); // Output: true
  /// print(list1.equals(list3)); // Output: false
  /// print(list1.equals(list4)); // Output: false
  /// print(list4.equals(null));  // Output: true
  /// print(list5.equals([1,2,3,null])); //Output: true
  ///
  /// // Example with ignoreSorting:
  /// List<int>? list6 = [1, 2, 3];
  /// List<int>? list7 = [3, 1, 2];
  /// print(list6.equals(list7, ignoreSorting: true)); // Output: true (order doesn't matter)
  /// print(list6.equals(list7, ignoreSorting: false)); // Output: false (order matters)
  ///
  /// List<String>? list8 = ["apple", "banana", "cherry"];
  /// List<String>? list9 = ["cherry", "apple", "banana"];
  /// print(list8.equals(list9, ignoreSorting: true)); // Output: true
  /// print(list8.equals(list9, ignoreSorting: false)); // Output: false
  /// ```
  ///
  /// Returns `true` if the lists are equal, `false` otherwise.
  ///
  /// The [ignoreSorting] parameter, if set to true, will compare the lists
  /// after sorting them.  This defaults to false.
  bool equals(
    List<T?>? a, {
    bool ignoreSorting = false,
  }) {
    if (this == null) return a == null;
    if (a == null || this?.length != a.length) return false;
    if (this.runtimeType != a.runtimeType) return false;

    if (ignoreSorting) {
      // Create copies to avoid modifying the original lists.
      final List<T?> sortedThis = this?.toList() ?? [];
      final List<T?> sortedA = a.toList();

      // If the lists contain non-comparable elements, we can't rely on sorting to determine equality.
      if (T is! Comparable) {
        // Instead, we check if the lists contain the same elements, regardless of order.
        // This is an O(n^2) operation, but it's the only reliable way to compare non-comparable lists.
        for (final itemThis in sortedThis) {
          final int indexA = sortedA.indexOf(itemThis);
          if (indexA == -1) {
            // itemThis is not in sortedA, so the lists are not equal.
            return false;
          }
          // Remove the item from sortedA to avoid double-counting.
          sortedA.removeAt(indexA);
        }
        // If sortedA is empty, all elements in sortedThis were found in sortedA.
        return sortedA.isEmpty;
      }
      // Sort if comparable
      sortedThis.sort((a, b) {
        if (a == null && b == null) return 0;
        if (a == null) return -1;
        if (b == null) return 1;
        return (a as Comparable).compareTo(b as Comparable);
      });
      sortedA.sort((a, b) {
        if (a == null && b == null) return 0;
        if (a == null) return -1;
        if (b == null) return 1;
        return (a as Comparable).compareTo(b as Comparable);
      });

      // Compare sorted lists
      for (int i = 0; i < sortedThis.length; i++) {
        if (sortedThis[i] != sortedA[i]) {
          return false;
        }
      }
      return true;
    } else {
      // Original comparison
      for (int i = 0; i < (this?.length ?? 0); i++) {
        if (this?[i] != a[i]) {
          return false;
        }
      }
      return true;
    }
  }
}
