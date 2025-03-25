import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  // Example JWT token for testing
  const String validToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."
      "eyJzdWIiOiJ0ZXN0QGV4YW1wbGUuY29tIiwiZXhwIjoxNzM1Njg5NjAwLCJ1aWQiOiIxMjM0NTYifQ."
      "signature";

  group("JWTUtility", () {
    test("jwtEmail extracts email correctly", () {
      expect(validToken.jwtEmail(), "test@example.com");
    });

    test("jwtEmail returns null for invalid token", () {
      expect("invalid.token".jwtEmail(), null);
      expect("".jwtEmail(), null);
    });

    test("jwtExpiryTime extracts expiry time correctly", () {
      final DateTime? expiry = validToken.jwtExpiryTime();
      expect(expiry, isNotNull);
      expect(expiry?.year, 2025); // Based on the exp value in the test token
    });

    test("jwtExpiryTime returns null for invalid token", () {
      expect("invalid.token".jwtExpiryTime(), null);
      expect("".jwtExpiryTime(), null);
    });

    test("jwtUserId extracts user ID correctly", () {
      expect(validToken.jwtUserId(), "123456");
    });

    test("jwtUserId returns null for invalid token", () {
      expect("invalid.token".jwtUserId(), null);
      expect("".jwtUserId(), null);
    });
  });
}
