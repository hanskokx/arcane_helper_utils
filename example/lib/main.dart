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

  print(DateTime(2024).isLeapYear); // true
  print(DateTime(2025).isLeapYear); // false
  print(2024.isLeapYear); // true
  print(2025.isLeapYear); // false

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
  final String capitalized = lowercase.capitalize!;
  print(capitalized); // "Hello"

  // Capitalize words in a string
  const String lowercaseWords = "hello world";
  final String capitalizedWords = lowercaseWords.capitalizeWords!;
  print(capitalizedWords); // "Hello World"

  // Space out PascalCase words
  const String pascalCase = "ArcaneHelperUtils";
  final String spacedOut = pascalCase.spacePascalCase!;
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

  // * Dynamic debug printing
  // Debug print the `Person` object before returning the name
  final String alice =
      const Person(id: 0, name: "Alice").printValue<Person>().name;
  print(alice); // Output: 'Alice'

  // Debug print the `Person` object with a label before returning the name
  final String bob =
      const Person(id: 1, name: "Bob").printValue<Person>("Person").name;
  print(bob); // Output: 'Bob'

  // * Fixed-size lists
  // Create a FixedSizeList with a capacity of 3 strings.
  final recentLogs = FixedSizeList(3);

  // Output: Initial recentLogs: []
  print("Initial recentLogs: ${recentLogs.items}");

  // Add some log messages.
  recentLogs.add("Request received at 10:00 AM");
  print("recentLogs after first add: ${recentLogs.items}");
  // Output: recentLogs after first add: [Request received at 10:00 AM]
  recentLogs.add("Processing request...");
  print("recentLogs after second add: ${recentLogs.items}");
  // Output: recentLogs after second add: [Request received at 10:00 AM, Processing request...]
  recentLogs.add("Request completed at 10:05 AM");
  print("recentLogs after third add: ${recentLogs.items}");
  // Output: recentLogs after third add: [Request received at 10:00 AM, Processing request..., Request completed at 10:05 AM]

  // Add one more log message, which will cause the oldest one to be removed.
  recentLogs.add("Sending response...");
  print("recentLogs after fourth add: ${recentLogs.items}");
  // Output: recentLogs after fourth add: [Processing request..., Request completed at 10:05 AM, Sending response...]

  // Try to modify the list through the 'items' getter (will throw an error).
  try {
    // This will cause an UnsupportedError because 'items' returns an unmodifiable list.
    recentLogs.items.add("This will fail");
  } catch (e) {
    print("Error trying to modify items: $e");
  }
}

class Person {
  final int id;
  final String name;

  const Person({required this.id, required this.name});
}
