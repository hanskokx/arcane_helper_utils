import "dart:convert";

/// An extension on `String` to extract useful information from JSON Web Tokens (JWT).
///
/// This extension provides methods to decode a JWT string and retrieve common
/// fields like email, expiration time, and user ID.
extension JWTUtility on String {
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
  /// String? email = token.jwtEmail();
  /// ```
  String? jwtEmail() {
    try {
      final payload = _parseJwt(this);
      final String email = payload["sub"] as String;
      return email;
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
  /// DateTime? expiry = token.jwtExpiryTime();
  /// ```
  DateTime? jwtExpiryTime() {
    try {
      final payload = _parseJwt(this);
      final expiry = payload["exp"] as int;
      final date = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      return date;
    } catch (_) {
      return null;
    }
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
  /// String? userId = token.jwtUserId();
  /// ```
  String? jwtUserId() {
    try {
      final payload = _parseJwt(this);
      final String id = payload["uid"] as String;
      return id;
    } catch (_) {
      return null;
    }
  }

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
        break;
      case 3:
        output += "=";
        break;
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
  /// Map<String, dynamic> payload = _parseJwt("your.jwt.token");
  /// ```
  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split(".");
    if (parts.length != 3) {
      throw Exception("invalid token");
    }

    final payload = _decodeBase64(parts[1]);
    final dynamic payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception("invalid payload");
    }

    return payloadMap;
  }
}
