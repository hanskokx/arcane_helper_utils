## 1.4.2

- Added the `isLeapYear` extension to the `DateTime` and `int` objects.
- Added the `FixedSizeList` class. See the readme and examples for details.

## 1.4.1

- Added a `List` equality extension, `equals`.
- Fixed an issue with the `List` extension `unique` that may have caused null-safety issues.

## 1.4.0

- [BREAKING] JWT-related extensions have been reworked.

Old:

```dart
String token = "your.jwt.token";
DateTime? expiry = token.jwtExpiryTime();
String? userId = token.jwtUserId();
String? email = token.jwtEmail();
```

New:

```dart
String token = "your.jwt.token";
DateTime? expiry = token.jwt.expiryTime;
String? userId = token.jwt.userId;
String? email = token.jwt.email;

// Added:
JwtPayload? token.jwt;
String? givenName = token.jwt.givenName;
String? familyName = token.jwt.familyName;
```

Additionally, the exceptions thrown when parsing an invalid JWT have been
updated.

```dart
  String email = "invalid".jwtEmail() // Previously threw Exception("invalid token")
  String email = "invalid".jwt.email // Now throws InvalidTokenException()

  String email = "".jwtEmail() // Previously threw Exception("invalid payload")
  String email = "".jwt.email // Now throws InvalidPayloadException()
```

## 1.3.2

- Added `isEmptyOrNull` and `isNotEmptyOrNull` extensions for `List` and `String` objects. These extensions are identical to `isNullOrEmpty` and `isNotNullOrEmpty`, respectively.
- Fixed a bug in the `DateTime` extension that caused incorrect results when comparing dates using `isToday`.

## 1.3.1

- Added the `isNullOrEmpty` and `isNotNullOrEmpty` extensions for `List` objects.
- Fixed a bug in the `Ticker` extension that prevented intervals shorter than 1 second from being used.
- [chore] Added unit tests for all extensions and utilities in the package.

## 1.3.0

- Added a non-breaking space character to `CommonString` as `CommonString.nbsp`
- Updated package dependencies

## 1.2.6

- Added the `printValue()` extension.
  The `printValue()` extension can be used to print a value to the console
  before returning that same value.

  Example:

  ```dart
  // Print the `textTheme` object to the console before returning it
  Text(
    'Hello, world',
    style: Theme.of(context).textTheme.printValue().headlineMedium,
  ),
  ```

## 1.2.5

- Null `String`s being manipulated should return `null` instead of an empty `String`

## 1.2.4

- Made `String` manipulation utilities available for nullable objects

## 1.2.3

- Adjusted `capitalize` extension to convert remaining letters to lowercase

## 1.2.2

- Added additional `String` manipulation utilities, including:
  - `capitalizeWords`: Capitalizes the first letter of each word in the string.
  - `spacePascalCase`: Adds spaces between words in a PascalCase string.

## 1.2.1

- Added additional documentation and examples for new extension.

## 1.2.0

- Added the `unique` extension for `List` objects.

## 1.1.3

- Removes `Color` extension due to an incompatibility with Flutter. Sorry, @rania-run!

## 1.1.2

- Ensure new `Color` extensions are exported from the package.

## 1.1.1

- Added `Color` extension for luminance. Thanks, @rania-run!
- Fixed a bug in the `splitByLength` extension on `String`

## 1.1.0

- [BREAKING] Removed `Unfocuser` widget to ensure pure Dart compatibility.

To continue using `Unfocuser`, add `unfocuser: ^1.0.0` to your pubspec.yaml.

## 1.0.4

- Added `yesterday` and `tomorrow` extensions to `DateTime`

## 1.0.3+2

- Added an example project

## 1.0.3+1

- Updated documentation

## 1.0.3

- Updated linting rules to use arcane_analysis

## 1.0.2

- Added bulletPoint to CommonString

## 1.0.1

- Added Unfocuser widget and JSON converters

## 1.0.0

- Initial release
