import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:flutter/foundation.dart";

void main() {
  // DateTime
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  debugPrint(dateTime.toIso8601String()); // 2019-01-01T13:45:00.0
  debugPrint(dateTime.startOfHour.toIso8601String()); // 2019-01-01T13:00:00.0

  final bool today = DateTime.now().isToday;
  final bool notToday = DateTime(2001, 12, 31).isToday;
  debugPrint("$today"); // true
  debugPrint("$notToday"); // false

  final DateTime yesterday = DateTime(0).yesterday;
  final DateTime tomorrow = DateTime(0).tomorrow;

  debugPrint("Yesterday: $yesterday");
  debugPrint("Tomorrow: $tomorrow");

  // Strings
  const String? nullString = null;
  const String emptyString = " ";
  const String nonEmptyString = "Hello World!";

  debugPrint("${nullString.isNullOrEmpty}"); // true
  debugPrint("${emptyString.isNullOrEmpty}"); // true
  debugPrint("${nonEmptyString.isNullOrEmpty}"); // false

  const String text = "DartLang";
  final List<String> result = text.splitByLength(3);
  debugPrint("$result"); // ["Dar", "tLa", "ng"]

  const String lowercase = "hello";
  final String capitalized = lowercase.capitalize;
  debugPrint(capitalized); // "Hello"
}
