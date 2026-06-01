/// Extension methods for recursively serializing and deserializing JSON-like
/// values.
extension JsonValueObjectExtension on Object? {
  /// Recursively serializes this value into a JSON-safe value.
  Object? toJsonValue() => _JsonValueHelper._toJsonValue(this);

  /// Recursively deserializes this JSON-like value into nested Dart values.
  Object? fromJsonValue() => _JsonValueHelper._fromJsonValue(this);

  /// Recursively deserializes this JSON-like value into a map.
  ///
  /// Returns `null` when this value is `null` or not a map.
  Map<String, Object?>? fromJsonMap() => _JsonValueHelper._fromJsonMap(this);
}

/// Extension methods for JSON map serialization.
extension JsonValueMapExtension on Map<Object?, Object?> {
  /// Recursively serializes this map into a JSON-safe map with string keys.
  Map<String, Object?> toJsonMap() => _JsonValueHelper._toJsonMap(this);
}

/// Extension methods for JSON list serialization and deserialization.
extension JsonValueListExtension on List<Object?> {
  /// Recursively serializes this list into a JSON-safe list.
  List<Object?> toJsonList() => _JsonValueHelper._toJsonList(this);

  /// Recursively deserializes this JSON-like list into nested Dart values.
  List<Object?> fromJsonList() => _JsonValueHelper._fromJsonList(this);
}

abstract class _JsonValueHelper {
  static Object? _toJsonValue(Object? value) {
    if (value == null) return null;
    if (value is String || value is num || value is bool) return value;
    if (value is Map) return _toJsonMap(value);
    if (value is List) return _toJsonList(value.cast<Object?>());
    return value.toString();
  }

  static Map<String, Object?> _toJsonMap(Map<Object?, Object?> map) {
    return map.map((k, v) => MapEntry(k.toString(), _toJsonValue(v)));
  }

  static List<Object?> _toJsonList(List<Object?> list) {
    return list.map(_toJsonValue).toList();
  }

  static Object? _fromJsonValue(Object? value) {
    if (value == null) return null;
    if (value is Map) return _fromJsonMap(value);
    if (value is List) return _fromJsonList(value.cast<Object?>());
    return value;
  }

  static Map<String, Object?>? _fromJsonMap(Object? value) {
    if (value == null) return null;
    if (value is! Map) return null;
    return value.map((k, v) => MapEntry(k.toString(), _fromJsonValue(v)));
  }

  static List<Object?> _fromJsonList(List<Object?> list) {
    return list.map(_fromJsonValue).toList();
  }
}
