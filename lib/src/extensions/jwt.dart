import "dart:convert";

typedef JwtPayload = Map<String, dynamic>;

/// An extension on `String` to extract useful information from JSON Web Tokens (JWT).
///
/// This extension provides methods to decode a JWT string and retrieve common
/// fields like email, expiration time, and user ID.
extension JWTUtility on String {
  /// Decodes a base64 URL-encoded string.
  ///
  /// This method replaces the URL-safe characters in the base64 string (`-` and `_`)
  /// with standard base64 characters (`+` and `/`), then decodes the string into UTF-8.
  ///
  /// Throws an `Exception` if the base64 string is not properly padded or is invalid.
  ///
  /// Example:
  /// ```dart
  /// String decoded = _decodeBase64("your_base64_string");
  /// ```
  String _decodeBase64(String str) {
    String output = str.replaceAll("-", "+").replaceAll("_", "/");
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += "==";
      case 3:
        output += "=";
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  /// Parses the JWT and returns the payload as a map.
  ///
  /// A JWT consists of three parts: header, payload, and signature, separated by dots (`.`).
  /// This method decodes the payload (the second part) from base64 and converts it into
  /// a `Map<String, dynamic>`.
  ///
  /// Throws an `Exception` if the token is not valid or the payload is not a proper JSON map.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> payload = parseJwt("your.jwt.token");
  /// ```
  JwtPayload get jwt {
    final parts = this.split(".");
    if (parts.length != 3) {
      throw InvalidTokenException();
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload) as JwtPayload?;
    if (payloadMap is! JwtPayload) {
      throw InvalidPayloadException();
    }

    return payloadMap;
  }
}

extension JWTMapUtility on JwtPayload {
  /// Extracts the email from the JWT payload.
  ///
  /// This method attempts to parse the JWT and retrieve the `sub` field, which is
  /// typically used to store the email of the token owner.
  ///
  /// Returns the email as a `String` if present, or `null` if the parsing fails or the
  /// email is not found.
  ///
  /// Example:
  /// ```dart
  /// String token = "your.jwt.token";
  /// String? email = token.jwt.email;
  /// ```
  String? get email {
    try {
      return this["sub"] as String;
    } catch (_) {
      return null;
    }
  }

  /// Extracts the given (first) name from the JWT payload.
  ///
  /// This method attempts to parse the JWT and retrieve the `given_name` field,
  /// which is typically used to store the given (first) name of the token owner.
  ///
  /// Returns the given name as a `String` if present, or `null` if the parsing
  /// fails or the given name is not found.
  ///
  /// Example:
  /// ```dart
  /// String token = "your.jwt.token";
  /// String? givenName = token.jwt.givenName;
  /// ```
  String? get givenName {
    try {
      return this["given_name"] as String;
    } catch (_) {
      return null;
    }
  }

  /// Extracts the family (last) name from the JWT payload.
  ///
  /// This method attempts to parse the JWT and retrieve the `family_name` field,
  /// which is typically used to store the family (last) name of the token owner.
  ///
  /// Returns the family name as a `String` if present, or `null` if the parsing
  /// fails or the family name is not found.
  ///
  /// Example:
  /// ```dart
  /// String token = "your.jwt.token";
  /// String? familyName = token.jwt.familyName;
  /// ```
  String? get familyName {
    try {
      return this["family_name"] as String;
    } catch (_) {
      return null;
    }
  }

  /// Extracts the expiration time from the JWT payload.
  ///
  /// This method retrieves the `exp` field from the JWT, which represents the expiration
  /// time as a Unix timestamp. The timestamp is converted to a `DateTime` object.
  ///
  /// Returns the `DateTime` representing the expiration time, or `null` if the parsing
  /// fails or the expiration time is not found.
  ///
  /// Example:
  /// ```dart
  /// String token = "your.jwt.token";
  /// DateTime? expiry = token.jwt.expiryTime;
  /// ```
  DateTime? get expiryTime {
    try {
      final expiry = this["exp"] as int;
      final date = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      return date;
    } catch (_) {
      return null;
    }
  }

  /// Determines whether the JWT has expired.
  ///
  /// If the current `expiryTime` is `null`, this value always returns `true`.
  /// Otherwise, the current `expiryTime` is compared to the current `DateTime`.
  /// Returns `true` if `DateTime.now()` is after the `expiryTime`. Otherwise,
  /// returns `false`.
  bool get isExpired {
    if (expiryTime == null) return true;
    return DateTime.now().isAfter(expiryTime!);
  }

  /// Determines whether the JWT will expire within the next (1) minute.
  ///
  /// If the current `expiryTime` is `null`, this value always returns `true`.
  /// Otherwise, the current `expiryTime` is compared to the current `DateTime`,
  /// plus (1) minute..
  /// Returns `true` if the token expires within the next (1) minute. Otherwise,
  /// returns `false`.
  bool get expiresSoon {
    if (expiryTime == null) return true;
    return DateTime.now().add(const Duration(minutes: 1)).isAfter(expiryTime!);
  }

  /// Extracts the user ID from the JWT payload.
  ///
  /// This method retrieves the `uid` field, which is typically the unique user identifier.
  /// This ID can be used in analytics or for tracking purposes.
  ///
  /// Returns the user ID as a `String`, or `null` if the parsing fails or the ID is not found.
  ///
  /// Example:
  /// ```dart
  /// String token = "your.jwt.token";
  /// String? userId = token.jwt.userId;
  /// ```
  String? get userId {
    try {
      return this["uid"] as String;
    } catch (_) {
      return null;
    }
  }
}

class InvalidTokenException implements Exception {}

class InvalidPayloadException implements Exception {}
