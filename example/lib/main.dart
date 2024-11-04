// ignore_for_file: avoid_print

import "package:arcane_helper_utils/arcane_helper_utils.dart";

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

  final list = [1, 2, 2, 3, 4, 4];
  final uniqueList = list.unique();
  print(uniqueList); // Output: [1, 2, 3, 4]
  final people = [
    Person(id: 1, name: "Alice"),
    Person(id: 2, name: "Bob"),
    Person(id: 1, name: "Alice Duplicate"),
  ];
  final uniquePeople = people.unique((person) => person.id);
  print(uniquePeople.map((p) => p.name)); // Output: ['Alice', 'Bob']
}
