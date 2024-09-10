import "package:freezed_annotation/freezed_annotation.dart";

/// A `JsonConverter` that converts a nullable `String?` to a nullable `double?`.
///
/// This converter is useful for converting JSON strings to Dart `double?` values and vice versa,
/// especially when dealing with APIs or data sources where numbers might be represented as strings.
///
/// Example:
/// Assuming a JSON string of `{"valueIsDouble": "123.456"}` is returned from
/// the API and you want to access the value from your class as:
/// ```dart
///  final double? myValue = MyFreezedClass.valueIsDouble;
/// ```
///
/// You would implement the converter as follows:
///
/// ```dart
/// @freezed
/// class MyFreezedClass with _$MyFreezedClass {
///   const factory MyFreezedClass({
///     @DecimalConverter() double? valueIsDouble,
///   }) = _MyFreezedClass;
///
///   factory MyFreezedClass.fromJson(Map<String, dynamic> json) =>
///       _$MyFreezedClassFromJson(json);
///
///   const MyFreezedClass._();
/// }
/// ```
class DoubleConverter implements JsonConverter<double?, String?> {
  /// Creates a const instance of [DoubleConverter].
  const DoubleConverter();

  /// Converts a nullable `String?` to a nullable `double?`.
  ///
  /// If the input string is `null` or can't be parsed into a valid `double`,
  /// this method returns `null`.
  @override
  double? fromJson(String? value) {
    return double.tryParse(value ?? "");
  }

  /// Converts a nullable `double?` to a nullable `String?`.
  ///
  /// If the input `double` is `null`, this method returns `null`.
  @override
  String? toJson(double? value) => value?.toString();
}

/// A `JsonConverter` that converts a nullable `String?` to a nullable `int?`.
///
/// This converter is useful for converting JSON strings to Dart `int?` values and vice versa,
/// especially when dealing with APIs or data sources where numbers might be represented as strings.
///
/// Example:
/// Assuming a JSON string of `{"valueIsInt": "123"}` is returned from
/// the API and you want to access the value from your class as:
/// ```dart
///  final int? myValue = MyFreezedClass.valueIsInt;
/// ```
///
/// You would implement the converter as follows:
///
/// ```dart
/// @freezed
/// class MyFreezedClass with _$MyFreezedClass {
///   const factory MyFreezedClass({
///     @IntegerConverter() double? valueIsInt,
///   }) = _MyFreezedClass;
///
///   factory MyFreezedClass.fromJson(Map<String, dynamic> json) =>
///       _$MyFreezedClassFromJson(json);
///
///   const MyFreezedClass._();
/// }
/// ```
class IntegerConverter implements JsonConverter<int?, String?> {
  /// Creates a const instance of [IntegerConverter].
  const IntegerConverter();

  /// Converts a nullable `String?` to a nullable `int?`.
  ///
  /// If the input string is `null` or can't be parsed into a valid `int`,
  /// this method returns `null`.
  @override
  int? fromJson(String? value) {
    return int.tryParse(value ?? "");
  }

  /// Converts a nullable `int?` to a nullable `String?`.
  ///
  /// If the input `int` is `null`, this method returns `null`.
  @override
  String? toJson(int? value) => value?.toString();
}
