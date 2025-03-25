import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("DoubleConverter", () {
    const converter = DoubleConverter();

    test("fromJson converts valid string to double", () {
      expect(converter.fromJson("123.45"), 123.45);
      expect(converter.fromJson("-123.45"), -123.45);
      expect(converter.fromJson("0.0"), 0.0);
    });

    test("fromJson handles null and invalid inputs", () {
      expect(converter.fromJson(null), null);
      expect(converter.fromJson(""), null);
      expect(converter.fromJson("invalid"), null);
    });

    test("toJson converts double to string", () {
      expect(converter.toJson(123.45), "123.45");
      expect(converter.toJson(-123.45), "-123.45");
      expect(converter.toJson(0.0), "0.0");
      expect(converter.toJson(null), null);
    });
  });

  group("IntegerConverter", () {
    const converter = IntegerConverter();

    test("fromJson converts valid string to int", () {
      expect(converter.fromJson("123"), 123);
      expect(converter.fromJson("-123"), -123);
      expect(converter.fromJson("0"), 0);
    });

    test("fromJson handles null and invalid inputs", () {
      expect(converter.fromJson(null), null);
      expect(converter.fromJson(""), null);
      expect(converter.fromJson("invalid"), null);
      expect(converter.fromJson("123.45"), null);
    });

    test("toJson converts int to string", () {
      expect(converter.toJson(123), "123");
      expect(converter.toJson(-123), "-123");
      expect(converter.toJson(0), "0");
      expect(converter.toJson(null), null);
    });
  });
}
