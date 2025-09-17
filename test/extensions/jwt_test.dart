import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  // Example JWT token for testing
  const String validToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."
      "eyJzdWIiOiJ0ZXN0QGV4YW1wbGUuY29tIiwiZXhwIjoxNzM1Njg5NjAwLCJ1aWQiOiIxMjM0NTYiLCJnaXZlbl9uYW1lIjoiZ2l2ZW4iLCJmYW1pbHlfbmFtZSI6ImZhbWlseSJ9."
      "Ki_D9fOhv7bLe86j6fdZ1guNGI7ldKSeeANUfinwNtc";

  group("JWTUtility", () {
    test("jwt getter parses a valid JWT", () {
      expect(validToken.jwt, isNotNull);
    });

    test("jwt getter throws an exception for invalid token", () {
      expect(() => "invalid.token".jwt, throwsException);
      expect(() => "".jwt, throwsException);
    });

    test("jwt.email extracts email correctly", () {
      expect(validToken.jwt.email, "test@example.com");
    });

    test("jwt.email throws an exception for invalid token", () {
      expect(
        () => "invalid.token".jwt.email,
        throwsA(isA<InvalidTokenException>()),
      );
      expect(() => "".jwt.email, throwsA(isA<InvalidTokenException>()));
    });

    test("jwt.givenName extracts given name correctly", () {
      expect(validToken.jwt.givenName, "given");
    });

    test("jwt.givenName throws an exception for invalid token", () {
      expect(
        () => "invalid.token".jwt.givenName,
        throwsA(isA<InvalidTokenException>()),
      );
      expect(() => "".jwt.givenName, throwsA(isA<InvalidTokenException>()));
    });

    test("jwt.familyName extracts family name correctly", () {
      expect(validToken.jwt.familyName, "family");
    });

    test("jwt.familyName returns null for invalid token", () {
      expect(
        () => "invalid.token".jwt.familyName,
        throwsA(isA<InvalidTokenException>()),
      );
      expect(() => "".jwt.familyName, throwsA(isA<InvalidTokenException>()));
    });

    test("jwt.expiryTime extracts expiry time correctly", () {
      final DateTime? expiry = validToken.jwt.expiryTime;
      expect(expiry, isNotNull);
      expect(expiry?.year, 2025); // Based on the exp value in the test token
    });

    test("jwt.isExpired checks expiration on tokens properly", () {
      final bool isExpired = validToken.jwt.isExpired;
      expect(isExpired, isNotNull);
      expect(isExpired, true);
    });

    test("jwt.expiresSoon checks expiration on tokens properly", () {
      final bool expiresSoon = validToken.jwt.expiresSoon;
      expect(expiresSoon, isNotNull);
      expect(expiresSoon, true);
    });

    test("jwt.expiryTime throws an exception for invalid token", () {
      expect(
        () => "invalid.token".jwt.expiryTime,
        throwsA(isA<InvalidTokenException>()),
      );
      expect(() => "".jwt.expiryTime, throwsA(isA<InvalidTokenException>()));
    });

    test("jwt.userId extracts user ID correctly", () {
      expect(validToken.jwt.userId, "123456");
    });

    test("jwt.userId throws an exception for invalid token", () {
      expect(
        () => "invalid.token".jwt.userId,
        throwsA(isA<InvalidTokenException>()),
      );
      expect(() => "".jwt.userId, throwsA(isA<InvalidTokenException>()));
    });
  });
}
