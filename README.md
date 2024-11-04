# Overview

Arcane Helper Utils is a Dart package designed to enhance Dart development by
providing utility functions and extensions that simplify common tasks.

[![style: arcane analysis](https://img.shields.io/badge/style-arcane_analysis-6E35AE)](https://pub.dev/packages/arcane_analysis)

## Features

- **Ticker Utility**: A utility class that facilitates time-based actions,
  perfect for animations or any timing-related operations.
- **JSON Converter**: Simplifies the process of converting JSON data into
  Dart objects.
- **DateTime Extensions**: Adds additional functionality to the `DateTime`
  class, making it easier to format dates and calculate differences.
- **String Extensions**: Enhances the `String` class by adding new methods for
  common transformations and checks, including JWT parsing.
- **List Extensions**: Adds a new `unique` operator for filtering `List` items.

## Getting Started

To use this package in your Dart project, add it to your project's
`pubspec.yaml` file:

```yaml
dependencies:
  arcane_helper_utils: any
```

Then import it in your Dart files where needed:

```dart
import 'package:arcane_helper_utils/arcane_helper_utils.dart';
```

## Usage Examples

Here are some examples of how to use the utilities and extensions provided by
this package:

### Ticker

The `Ticker` can be used as a countdown or interval timer.

```dart
final Stream<int> ticker = const Ticker().tick(
  timeout: Duration(seconds: 30),
  interval: Duration(seconds: 5)
);

await for (final int ticksRemaining in ticker) {
  if (ticksRemaining == 0) print("Time's up!");
  print('Tick! $ticksRemaining');
}
```

### JSON Conversion

These helper methods are used in conjunction with the Freezed package to
annotate fields that need to be converted from one data type to another.
The available conversions are:

- `String?` to `int?`
- `String?` to `double?`

Provided the following JSON output, the `valueIsMaybeNull` field will be
converted from an empty `String` to `null`, the `valueIsDouble` field will
be converted from a `String?` to a `double?`, and the `valueIsInt` field will be
converted from a `String?` to an `int?`:

```json
{
  "valueIsMaybeNull": "",
  "valueIsDouble": "123.456",
  "valueIsInt": "123"
}
```

```dart
@freezed
class MyFreezedClass with _$MyFreezedClass {
  const factory MyFreezedClass({
    @DecimalConverter() double? valueIsMaybeNull,
    @DecimalConverter() double? valueIsDouble,
    @IntegerConverter() int? valueIsInt,
  }) = _MyFreezedClass;

  factory MyFreezedClass.fromJson(Map<String, dynamic> json) =>
      _$MyFreezedClassFromJson(json);

  const MyFreezedClass._();
}
```

### DateTime Extensions

These extensions add helpful methods to the `DateTime` class, making it easier
to handle common date and time operations such as formatting, comparisons, and
calculations.

These are broken down into the following categories:

- Start and end of period calculations
- Comparison operations
- Period information operations
- "Yesterday" and "tomorrow" getters

#### Start and End of Period Calculations

The following operations are now available on a `DateTime` object:

- `startOfHour`: Returns a new `DateTime` object where the time stamp is set to
  the beginning of the given hour.

  ```dart
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  print(dateTime); // 2019-01-01T13:45:00.0
  print(dateTime.startOfHour); // 2019-01-01T13:00:00.0
  ```

- `endOfHour`: Returns a new `DateTime` object where the time stamp is set to
  the end of the given hour.

  ```dart
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  print(dateTime); // 2019-01-01T13:45:00.0
  print(dateTime.endOfHour); // 2019-01-01T13:59:59.999
  ```

- `startOfDay`: Returns a new `DateTime` object where the time stamp is set to
  the beginning of the day.

  ```dart
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  print(dateTime); // 2019-01-01T13:45:00.0
  print(dateTime.startOfDay); // 2019-01-01T00:00:00.0
  ```

- `endOfDay`: Returns a new `DateTime` object where the time stamp is set to the
  end of the day.

  ```dart
  final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
  print(dateTime); // 2019-01-01T13:45:00.0
  print(dateTime.endOfDay); // 2019-01-01T23:59:59.9
  ```

- `startOfWeek`: Returns a new `DateTime` object where the time stamp is set to
  the beginning of the week (Monday).

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.startOfWeek); // 2023-09-04
  ```

- `endOfWeek`: Returns a new `DateTime` object where the time stamp is set to
  the end of the week (Sunday).

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.endOfWeek); // 2023-09-17T23:59:59.999999
  ```

- `startOfMonth`: Returns a new `DateTime` object where the time stamp is set to
  the beginning of the month.

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.startOfMonth); // 2023-09-01T00:00:00.0
  ```

- `endOfMonth`: Returns a new `DateTime` object where the time stamp is set to
  the end of the month.

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.endOfMonth); // 2023-09-30T23:59:59.999999
  ```

- `startOfYear`: Returns a new `DateTime` object where the time stamp is set to
  the beginning of the year.

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.startOfYear); // 2023-01-01T00:00:00.0
  ```

- `endOfYear`: Returns a new `DateTime` object where the time stamp is set to
  the end of the year.

  ```dart
  final DateTime dateTime = DateTime(2023, 9, 10);
  print(dateTime); // 2023-09-10
  print(dateTime.endOfYear); // 2023-12-31T23:59:59.999999
  ```

#### Comparison Operations

- `isToday`: Returns `true` if the provided `DateTime` is today, otherwise
  returns `false`.

  ```dart
  final DateTime today = DateTime(2024, 9, 10);
  final bool notToday = DateTime(2001, 12, 31).isToday; // false
  ```

- `isSameDayAs`: Compares two `DateTime` objects and returns `true` if they
  represent the same day.

  ```dart
  final DateTime first = DateTime(2001, 1, 1);
  final DateTime second = DateTime(2001, 1, 2);
  final DateTime third = DateTime(2001, 1, 1);

  final bool firstAndSecond = first.isSameDayAs(second); // false
  final bool firstAndThird = first.isSameDayAs(third); // true
  ```

#### Period Information Operations

- `daysInMonth`: Returns an `int` with the number of days in a provided month.

  ```dart
  final int daysInMonth = DateTime(2024, 9).daysInMonth; // 30
  ```

- `firstDayOfWeek`: Returns a new `DateTime` object where the time stamp is set
  to the beginning of the first day (Sunday) of the original `DateTime`'s week.

  ```dart
  final DateTime today = DateTime(2024, 9, 10); // Tuesday
  final DateTime sunday = today.firstDayOfWeek; // Sunday
  ```

#### "Yesterday" and "tomorrow" getters

- `yesterday`: returns a new `DateTime` object for the previous start of day.

  ```dart
  final DateTime now = DateTime.now(); // 2024-10-07 13:37:48.274
  final DateTime yesterday = DateTime(0).yesterday; // 2024-10-06 00:00:00.000
  ```

- `tomorrow`: returns a new `DateTime` object for tomorrow's start of day.

  ```dart
  final DateTime now = DateTime.now(); // 2024-10-07 13:37:48.274
  final DateTime tomorrow = DateTime(0).tomorrow; // 2024-10-08 00:00:00.000
  ```

### JWT Parsing

These extensions enhance the `String` class with JWT-specific functionalities,
making it easier to handle JSON Web Tokens directly as `String` objects.

Here are some examples of how these methods can be utilized:

- Extracting the email address (`jwt["sub"]`)

  ```dart
  String jwt = "your.jwt.token";
  final String? email = jwt.jwtEmail(); // Returns the email address in the JWT
  ```

- Extracting the token expiration time (`jwt["exp"]`)

  ```dart
  String jwt = "your.jwt.token";
  // Returns a `DateTime?` when the token expires
  final DateTime? email = jwt.jwtExpiryTime();
  ```

- Extracting the user ID (`jwt["uid"]`)

  ```dart
  String jwt = "your.jwt.token";
  final String? uid = jwt.jwtUserId(); // Returns the UID value from the token
  ```

### String Utilities

The following utilities have been added to enhance working with `String`
objects:

- `isNullOrEmpty`: Returns `true` if a `String?` is either null or consists of
  only whitespace.

  ```dart
  const String? nullString = null;
  const String? emptyString = " ";
  const String? nonEmptyString = "Hello World!";

  print(nullString.isNullOrEmpty) // true
  print(emptyString.isNullOrEmpty) // true
  print(nonEmptyString.isNullOrEmpty) // false
  ```

- `isNotNullOrEmpty`: Returns `true` if a `String?` is neither null nor consists
  of only whitespace.

  ```dart
  const String? nullString = null;
  const String? emptyString = " ";
  const String? nonEmptyString = "Hello World!";

  print(nullString.isNotNullOrEmpty) // false
  print(emptyString.isNotNullOrEmpty) // false
  print(nonEmptyString.isNotNullOrEmpty) // true
  ```

- `splitByLength(int length)`: Splits a `String` into a `List<String>` where
  each value is of the maximum length provided.

  ```dart
  const String text = "DartLang";
  final List<String> result = text.splitByLength(3); // ["Dar", "tLa", "ng"]
  ```

- `capitalize`: Capitalizes the first letter of a given `String`

  ```dart
  const String text = "hello";
  final String capitalized = text.capitalize; // "Hello"
  ```

Additionally, the `CommonString` class provides a quick shortcut to common
strings, such as punctuation marks that are otherwise cumbersome to find or type.

### List Extensions

The following extensions have been added to the `List` object:

- `unique([Id Function(E element)? id, bool inplace = true])`: Filters a list
  by a given element, returning only non-duplicate values. Can return either a
  new `List` or filter the existing list by specifying the `inplace` option.

  ```dart
  final List<String> myList = [
    Item(value: "Hello"),
    Item(value: "Hello"),
    Item(value: "World"),
    Item(value: "World"),
  ];

  myList.unique((item) => item.value);
  // [Item(value: "Hello"), Item(value: "World")]

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull
requests.
