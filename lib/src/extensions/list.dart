/// An extension on `List` to filter out duplicate elements based on a specified identifier.
///
/// This extension provides a `unique` method that removes duplicate entries
/// from the list, optionally using a custom identifier function.
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
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set ids = {};
    final List<E> list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
