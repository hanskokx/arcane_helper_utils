// ignore_for_file: avoid_print

extension DynamicPrintExtension on dynamic {
  /// The `printValue()` extension can be used to print a value to the
  /// console before returning that same value.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Hello, world',
  ///   style: Theme.of(context).textTheme.printValue().headlineMedium,
  /// ),
  /// ```
  ///
  /// This will print the text style to the console before returning it, which
  /// can be useful for debugging.
  ///
  /// Additionally, an optional label can be specified for the printed value, which
  /// will be prepended to the output.
  /// ```dart
  /// Text(
  ///   'Hello, world',
  ///   style: Theme.of(context).textTheme.printValue('headlineMedium'),
  /// ),
  /// ```
  @Deprecated(
    "WARNING: The printValue() extension can potentially leak sensitive "
    "information.\n"
    "It is recommended to use only during debugging and to remove before "
    "releasing to production.",
  )
  T printValue<T>([String label = ""]) {
    if (label.isNotEmpty) {
      print("$label: ${toString()}");
    } else {
      print("${toString()}");
    }
    return this as T;
  }
}
