# Overview

Arcane Helper Utils is a Dart package designed to enhance Dart development by
providing utility functions and extensions that simplify common tasks.

[![style: arcane analysis](https://img.shields.io/badge/style-arcane_analysis-6E35AE)](https://pub.dev/packages/arcane_analysis)

## Features

- **Ticker Utility**: A utility class that facilitates time-based actions, perfect for animations or any timing-related operations.
- **JSON Converter**: Simplifies the process of converting JSON data into Dart objects.
- **DateTime Extensions**: Adds additional functionality to the `DateTime` class, making it easier to format dates and calculate differences.
- **String Extensions**: Enhances the `String` class by adding new methods for common transformations and checks.
- **JWT Utilities**: Provides getters to parse a JWT token from a `String`, then get common properties from it.
- **List Extensions**: Adds a new `unique` operator for filtering `List` items, as well as getters for `isNullOrEmpty`, `isEmptyOrNull`, `isNotNullOrEmpty`, and `isNotEmptyOrNull`. Furthermore, an `equals` extension has been introduced which can be used to compare two lists.
- **FixedSizeList**: Provides a list of a predictable size, which drops the first value when additional values are added which would otherwise cause the list to exceed its capacity.

## Getting Started

To use this package in your Dart project, add it to your project's `pubspec.yaml` file:

```yaml
dependencies:
  arcane_helper_utils: any
```

Then import it in your Dart files where needed:

```dart
import 'package:arcane_helper_utils/arcane_helper_utils.dart';
```

## Usage Examples

Here are some examples of how to use the utilities and extensions provided by this package:

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

    These helper methods are used in conjunction with the Freezed package to annotate fields that need to be converted from one data type to another.
    The available conversions are:

    - `String?` to `int?`
    - `String?` to `double?`

    Provided the following JSON output, the `valueIsMaybeNull` field will be converted from an empty `String` to `null`, the `valueIsDouble` field will be converted from a `String?` to a `double?`, and the `valueIsInt` field will be converted from a `String?` to an `int?`:

    ```json
    {
      "valueIsMaybeNull": "",
      "valueIsDouble": "123.456",
      "valueIsInt": "123"
    }
    ```

    ```dart
    @freezed
    abstract class MyFreezedClass with _$MyFreezedClass {
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

    These extensions add helpful methods to the `DateTime` class, making it easier to handle common date and time operations such as formatting, comparisons, and calculations.

    These are broken down into the following categories:

    - Start and end of period calculations
    - Comparison operations
    - Period information operations
    - "Yesterday" and "tomorrow" getters
    - Leap year calculations

    #### Start and End of Period Calculations

      The following operations are now available on a `DateTime` object:

      - `startOfHour`: Returns a new `DateTime` object where the time stamp is set to the beginning of the given hour.

        ```dart
        final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
        print(dateTime); // 2019-01-01T13:45:00.0
        print(dateTime.startOfHour); // 2019-01-01T13:00:00.0
        ```

      - `endOfHour`: Returns a new `DateTime` object where the time stamp is set to the end of the given hour.

        ```dart
        final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
        print(dateTime); // 2019-01-01T13:45:00.0
        print(dateTime.endOfHour); // 2019-01-01T13:59:59.999
        ```

      - `startOfDay`: Returns a new `DateTime` object where the time stamp is set to the beginning of the day.

        ```dart
        final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
        print(dateTime); // 2019-01-01T13:45:00.0
        print(dateTime.startOfDay); // 2019-01-01T00:00:00.0
        ```

      - `endOfDay`: Returns a new `DateTime` object where the time stamp is set to the end of the day.

        ```dart
        final DateTime dateTime = DateTime(2019, 1, 1, 13, 45);
        print(dateTime); // 2019-01-01T13:45:00.0
        print(dateTime.endOfDay); // 2019-01-01T23:59:59.9
        ```

      - `startOfWeek`: Returns a new `DateTime` object where the time stamp is set to the beginning of the week (Monday).

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.startOfWeek); // 2023-09-04
        ```

      - `endOfWeek`: Returns a new `DateTime` object where the time stamp is set to the end of the week (Sunday).

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.endOfWeek); // 2023-09-17T23:59:59.999999
        ```

      - `startOfMonth`: Returns a new `DateTime` object where the time stamp is set to the beginning of the month.

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.startOfMonth); // 2023-09-01T00:00:00.0
        ```

      - `endOfMonth`: Returns a new `DateTime` object where the time stamp is set to the end of the month.

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.endOfMonth); // 2023-09-30T23:59:59.999999
        ```

      - `startOfYear`: Returns a new `DateTime` object where the time stamp is set to the beginning of the year.

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.startOfYear); // 2023-01-01T00:00:00.0
        ```

      - `endOfYear`: Returns a new `DateTime` object where the time stamp is set to the end of the year.

        ```dart
        final DateTime dateTime = DateTime(2023, 9, 10);
        print(dateTime); // 2023-09-10
        print(dateTime.endOfYear); // 2023-12-31T23:59:59.999999
        ```

    #### Comparison Operations

      - `isToday`: Returns `true` if the provided `DateTime` is today, otherwise returns `false`.

        ```dart
        final DateTime today = DateTime(2024, 9, 10);
        final bool notToday = DateTime(2001, 12, 31).isToday; // false
        ```

      - `isSameDayAs`: Compares two `DateTime` objects and returns `true` if they represent the same day.

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

      - `firstDayOfWeek`: Returns a new `DateTime` object where the time stamp is set to the beginning of the first day (Sunday) of the original `DateTime`'s week.

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

    #### Leap Years

      - `isLeapYear`: returns a `bool` corresponding to whether a given year is a leap year. This can also be used directly on an `int`.

        ```dart
        print(DateTime(2024).isLeapYear); // true
        print(DateTime(2025).isLeapYear); // false
        print(2024.isLeapYear); // true
        print(2025.isLeapYear); // false
        ```

### JWT Parsing

    These extensions enhance the `String` class with JWT-specific functionalities, making it easier to handle JSON Web Tokens directly as `String` objects.

    Here are some examples of how these methods can be utilized:

    - Parse a JWT string

      ```dart
      String token = "your.jwt.token";
      final JwtPayload? payload = token.jwt; // Returns the JWT's payload
      ```

    - Extracting the email address (`jwt["sub"]`)

      ```dart
      String jwt = "your.jwt.token";
      final String? email = jwt.jwt.email; // Returns the email address in the JWT
      ```

    - Extracting the token expiration time (`jwt["exp"]`)

      ```dart
      String jwt = "your.jwt.token";
      // Returns a `DateTime?` when the token expires
      final DateTime? expiryTime = jwt.jwt.expiryTime;
      
      // Returns `true` if the token has expired
      final bool jwt.jwt.isExpired;

      // Returns `true` if the token expires within the next (1) minute
      final bool jwt.jwt.expiresSoon;
      ```

    - Extracting the user ID (`jwt["uid"]`)

      ```dart
      String jwt = "your.jwt.token";
      final String? uid = jwt.jwt.userId; // Returns the UID value from the token
      ```

    - Extracting the given name (`jwt["given_name"]`)

      ```dart
      String jwt = "your.jwt.token";
      final String? uid = jwt.jwt.givenName; // Returns the given name from the token
      ```

    - Extracting the family name (`jwt["family_name"]`)

      ```dart
      String jwt = "your.jwt.token";
      final String? uid = jwt.jwt.familyName; // Returns the family name from the token
      ```

### String Utilities

    The following utilities have been added to enhance working with `String` objects:

    - `isNullOrEmpty`: Returns `true` if a `String?` is either null or consists of only whitespace.

      ```dart
      const String? nullString = null;
      const String? emptyString = " ";
      const String? nonEmptyString = "Hello World!";

      print(nullString.isNullOrEmpty) // true
      print(emptyString.isNullOrEmpty) // true
      print(nonEmptyString.isNullOrEmpty) // false
      ```

    - `isNotNullOrEmpty`: Returns `true` if a `String?` is neither null nor consists of only whitespace.

      ```dart
      const String? nullString = null;
      const String? emptyString = " ";
      const String? nonEmptyString = "Hello World!";

      print(nullString.isNotNullOrEmpty) // false
      print(emptyString.isNotNullOrEmpty) // false
      print(nonEmptyString.isNotNullOrEmpty) // true
      ```

    - `splitByLength(int length)`: Splits a `String` into a `List<String>` where each value is of the maximum length provided.

      ```dart
      const String text = "DartLang";
      final List<String> result = text.splitByLength(3); // ["Dar", "tLa", "ng"]
      ```

    - `capitalize`: Capitalizes the first letter of a given `String`

      ```dart
      const String text = "hello";
      final String capitalized = text.capitalize; // "Hello"
      ```

    - `capitalizeWords`: Capitalizes the first letter of each word in a given `String`

      ```dart
      String text = "hello world";
      String capitalizedWords = text.capitalizeWords; // "Hello World"
      ```

    - `spacePascalCase`: Adds spaces between words in a PascalCase `String`

      ```dart
      String text = "ArcaneHelperUtils";
      String spaced = text.spacePascalCase; // "Arcane Helper Utils"
      ```

    Additionally, the `CommonString` class provides a quick shortcut to common strings, such as punctuation marks that are otherwise cumbersome to find or type.

### List Extensions

    The following extensions have been added to the `List` object:

    - `unique([Id Function(E element)? id, bool inplace = true])`: Filters a list by a given element, returning only non-duplicate values. Can return either a new `List` or filter the existing list by specifying the `inplace` option.

      ```dart
      const List<int> list = [1, 2, 2, 3, 4, 4];
      final List<int> uniqueList = list.unique();
      print(uniqueList); // Output: [1, 2, 3, 4]
      const List<Person> people = [
        Person(id: 1, name: 'Alice'),
        Person(id: 2, name: 'Bob'),
        Person(id: 1, name: 'Alice Duplicate'),
      ];
      final List<Person> uniquePeople = people.unique((person) => person.id);
      print(uniquePeople.map((p) => p.name)); // Output: ['Alice', 'Bob']
      ```

    - `isNullOrEmpty`: Checks if a list is either null or empty.

      ```dart
      const List<int> list = [1, 2, 3];
      print(list.isNullOrEmpty); // Output: false
      final List<int> emptyList = <int>[];
      print(emptyList.isNullOrEmpty); // Output: true
      final List<int>? nullList = null;
      print(nullList.isNullOrEmpty); // Output: true
      ```

    - `isNullOrEmpty`: Checks if a list is either null or empty.

      ```dart
      final List<int> list = [1, 2, 3];
      print(list.isNullOrEmpty); // Output: false
      final List<int> emptyList = <int>[];
      print(emptyList.isNullOrEmpty); // Output: true
      final List<int>? nullList = null;
      print(nullList.isNullOrEmpty); // Output: true
      ```

    - `equals`: Compares two lists to see if they are equal.

      ```dart
      List<int?>? list1 = [1, 2, null, 4];
      List<int?>? list2 = [1, 2, null, 4];
      List<int?>? list3 = [1, 2, 3, 4];
      List<int?>? list4 = null;
      List<int?>? list5 = [1, 2, 3, null];

      print(list1.equals(list2)); // Output: true
      print(list1.equals(list3)); // Output: false
      print(list1.equals(list4)); // Output: false
      print(list4.equals(null));  // Output: true
      print(list5.equals([1,2,3,null])); // Output: true

      // Example with ignoreSorting:
      List<int>? list6 = [1, 2, 3];
      List<int>? list7 = [3, 1, 2];

      // Output: true (order doesn't matter)
      print(list6.equals(list7, ignoreSorting: true));

      // Output: false (order matters)
      print(list6.equals(list7, ignoreSorting: false));

      List<String>? list8 = ["apple", "banana", "cherry"];
      List<String>? list9 = ["cherry", "apple", "banana"];

      // Output: true
      print(list8.equals(list9, ignoreSorting: true));

      // Output: false
      print(list8.equals(list9, ignoreSorting: false));
      ```

### Fixed size list

The `FixedSizeList` operates much like a traditional `List` with one exception: the length of the list is defined upon creation and adding new items to the list which would otherwise cause the length of the list to exceed the list's capacity will cause the first item(s) to be removed from the list.

Here's an example: Say you want to keep a list of the last 3 log messages. You can create a `FixedSizeList` to push these log messages into:

```dart
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
```

A `FixedSizeList` can be created with a capacity then filled up later (as in the previous example), or a value can be passed in alongside the capacity. The value being passed in should not exceed the length of the given capacity.

```dart
final numbers = FixedSizeList.from([1, 2, 3]); // The list is set to a capacity of 3 (the length of the input)
final moreNumbers = FixedSizeList(3, value: [1, 2, 3]);

final throwsException = FixedSizeList(3, value: [1, 2, 3, 4]); // Throws an exception because [value] exceeds the given capacity.
```

Other `List` factories are supported when creating a `FixedSizeList`, including:

- `filled`
- `empty`
- `from`
- `of`
- `generate`

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests.
