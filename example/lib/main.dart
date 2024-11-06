// ignore_for_file: avoid_print

import "package:arcane_helper_utils/arcane_helper_utils.dart";

void main() {
  // * DateTime
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

  // * Strings
  const String? nullString = null;
  const String emptyString = " ";
  const String nonEmptyString = "Hello World!";

  // Nullability
  print("${nullString.isNullOrEmpty}"); // true
  print("${emptyString.isNullOrEmpty}"); // true
  print("${nonEmptyString.isNullOrEmpty}"); // false

  // Split a string by x characters
  const String text = "DartLang";
  final List<String> result = text.splitByLength(3);
  print("$result"); // ["Dar", "tLa", "ng"]

  // Capitalize a string
  const String lowercase = "hello";
  final String capitalized = lowercase.capitalize;
  print(capitalized); // "Hello"

  // Capitalize words in a string
  const String lowercaseWords = "hello world";
  final String capitalizedWords = lowercaseWords.capitalizeWords;
  print(capitalizedWords); // "Hello World"

  // Space out PascalCase words
  const String pascalCase = "ArcaneHelperUtils";
  final String spacedOut = pascalCase.spacePascalCase;
  print(spacedOut); // "Arcane Helper Utils";

  // * Lists
  final List<Person> people = [
    const Person(id: 1, name: "Alice"),
    const Person(id: 2, name: "Bob"),
    const Person(id: 1, name: "Alice Duplicate"),
  ];

  // Process the list into a new list item. Original list is preserved.
  final List<Person> uniquePeople = people.unique((person) => person.id, false);
  print(
    people.map((p) => p.name),
    // Output: ['Alice', 'Bob', 'Alice Duplicate']
  );
  print(uniquePeople.map((p) => p.name)); // Output: ['Alice', 'Bob']

  // Process the existing list, in place
  people.unique((person) => person.id);
  print(people.map((p) => p.name)); // Output: ['Alice', 'Bob']
}

class Person {
  final int id;
  final String name;

  const Person({required this.id, required this.name});
}
