// ignore_for_file: avoid_print

import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:arcane_helper_utils/src/extensions/color.dart";
import "package:pure_dart_ui/pure_dart_ui.dart";

void main() {
  // DateTime
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  print(dateTime.toIso8601String()); // 2019-01-01T13:45:00.0
  print(dateTime.startOfHour.toIso8601String()); // 2019-01-01T13:00:00.0

  final bool today = DateTime.now().isToday;
  final bool notToday = DateTime(2001, 12, 31).isToday;
  print("$today"); // true
  print("$notToday"); // false

  final DateTime yesterday = DateTime(0).yesterday;
  final DateTime tomorrow = DateTime(0).tomorrow;

  print("Yesterday: $yesterday");
  print("Tomorrow: $tomorrow");

  // Strings
  const String? nullString = null;
  const String emptyString = " ";
  const String nonEmptyString = "Hello World!";

  print("${nullString.isNullOrEmpty}"); // true
  print("${emptyString.isNullOrEmpty}"); // true
  print("${nonEmptyString.isNullOrEmpty}"); // false

  const String text = "DartLang";
  final List<String> result = text.splitByLength(3);
  print("$result"); // ["Dar", "tLa", "ng"]

  const String lowercase = "hello";
  final String capitalized = lowercase.capitalize;
  print(capitalized); // "Hello"

  // Color
  const Color myColor = Color.fromARGB(255, 153, 97, 227);
  final Color luminanceBasedcolor =
      myColor.isDark ? const Color(0xff000000) : const Color(0xffffffff);
  print(luminanceBasedcolor); // Color(0xff000000)
}
