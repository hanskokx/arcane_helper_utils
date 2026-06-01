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

  group("Json value extensions", () {
    test("toJsonValue recursively encodes nested maps and lists", () {
      final input = <Object?, Object?>{
        "user": <Object?, Object?>{
          "name": "Hans",
          "stats": <Object?>[1, 2, true],
        },
        42: <Object?>[
          <Object?, Object?>{"nested": "value"},
        ],
      };

      final result = input.toJsonValue() as Map<String, Object?>;

      expect(result["42"], isA<List<Object?>>());
      expect(result["user"], isA<Map<String, Object?>>());
      final user = result["user"]! as Map<String, Object?>;
      expect(user["name"], "Hans");
      expect(user["stats"], <Object?>[1, 2, true]);
    });

    test("toJsonValue stringifies unsupported leaves", () {
      final now = DateTime.utc(2026, 1, 1);

      expect(now.toJsonValue(), now.toString());
    });

    test("fromJsonValue recursively decodes nested maps and lists", () {
      final input = <String, Object?>{
        "metadata": <String, Object?>{
          "list": <Object?>[
            <String, Object?>{"ok": true},
            7,
          ],
        },
      };

      final result = input.fromJsonValue() as Map<String, Object?>;
      final metadata = result["metadata"]! as Map<String, Object?>;
      final list = metadata["list"]! as List<Object?>;

      expect((list.first as Map<String, Object?>)["ok"], isTrue);
      expect(list[1], 7);
    });

    test("fromJsonMap returns null when value is not a map", () {
      expect(("not a map" as Object?).fromJsonMap(), isNull);
      expect((null as Object?).fromJsonMap(), isNull);
    });
  });
}
