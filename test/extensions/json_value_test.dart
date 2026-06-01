import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("JsonValue extensions", () {
    test("toJsonList serializes nested list values", () {
      final List<Object?> nested = <Object?>[
        <Object?>[
          1,
          2,
          <Object?, Object?>{"ok": true},
        ],
      ];

      final result = nested.toJsonList();

      expect(result, isA<List<Object?>>());
      expect((result.first as List<Object?>)[0], 1);
      expect(
        ((result.first as List<Object?>)[2] as Map<String, Object?>)["ok"],
        isTrue,
      );
    });

    test("toJsonMap serializes map keys and nested values", () {
      final map = <Object?, Object?>{
        123: "value",
        "nested": <Object?, Object?>{"a": 1},
      };

      expect(map.toJsonMap().containsKey("123"), isTrue);
      expect(
        (map.toJsonMap()["nested"] as Map<String, Object?>)["a"],
        1,
      );
    });

    test("fromJsonMap decodes nested structures from Object?", () {
      final Object value = <String, Object?>{
        "meta": <String, Object?>{
          "list": <Object?>[
            <String, Object?>{"x": 1},
          ],
        },
      };

      final decoded = value.fromJsonMap();
      final meta = decoded!["meta"]! as Map<String, Object?>;
      final list = meta["list"]! as List<Object?>;

      expect((list.first as Map<String, Object?>)["x"], 1);
    });

    test("toJsonValue and fromJsonValue round-trip primitives", () {
      const Object original = 42;
      final jsonValue = original.toJsonValue();
      final decoded = jsonValue.fromJsonValue();

      expect(decoded, 42);
    });
  });
}
