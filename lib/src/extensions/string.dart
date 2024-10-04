/// Provides a quick shortcut to common strings, such as punctuation marks that are otherwise
/// cumbersome to find or type.
abstract class CommonString {
  /// An em dash (`—`) is commonly used in typography to set off parenthetical
  /// phrases or provide emphasis in a sentence.
  static const String emDash = "—";

  /// A bullet point (`•`) is a small, round symbol used in typography to indicate a new
  /// item in a list or to separate items in a series.
  static const String bulletPoint = "•";
}

/// An extension that adds convenience methods to handle nullability and
/// emptiness checks for `String?` types.
extension Nullability on String? {
  /// Returns `true` if the `String?` is neither `null` nor contains only whitespace.
  ///
  /// This is useful for cases where you want to check if a nullable string has a valid
  /// non-empty, non-whitespace value.
  ///
  /// Example usage:
  /// ```dart
  /// String? example = "Hello";
  /// if (example.isNotNullOrEmpty) {
  ///   print("The string is not null and not empty");
  /// }
  /// ```
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns `true` if the `String?` is either `null` or contains only whitespace.
  ///
  /// This is a handy utility to check if a nullable string is either not assigned
  /// or effectively empty (including strings with only whitespace characters).
  ///
  /// Example usage:
  /// ```dart
  /// String? example = null;
  /// if (example.isNullOrEmpty) {
  ///   print("The string is null or empty");
  /// }
  /// ```
  bool get isNullOrEmpty => this == null || (this ?? "").trim().isEmpty;
}

/// An extension on `String` to split the string into parts of a specified length.
extension Split on String {
  /// Splits the string into a list of substrings, each with a maximum length of [length].
  ///
  /// This method divides the string into chunks of size [length]. If the string's
  /// length is not a multiple of [length], the last chunk may be smaller than [length].
  ///
  /// - [length]: The number of characters in each part.
  ///
  /// Returns a list of substrings where each has a maximum of [length] characters.
  ///
  /// Example:
  /// ```dart
  /// String text = "DartLang";
  /// List<String> result = text.splitByLength(3); // ["Dar", "tLa", "ng"]
  /// ```
  List<String> splitByLength(int length) {
    final List<String> parts = [];
    String string = this;

    while (string.isNotEmpty) {
      parts.add(string.substring(0, length));
      string = string.substring(length);
    }
    return parts;
  }
}

/// An extension on `String` to perform text manipulation tasks.
extension TextManipulation on String {
  /// Capitalizes the first letter of the string.
  ///
  /// This method returns a new string where the first character is converted
  /// to uppercase, while the rest of the string remains unchanged.
  ///
  /// Example:
  /// ```dart
  /// String text = "hello";
  /// String capitalized = text.capitalize; // "Hello"
  /// ```
  String get capitalize {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
