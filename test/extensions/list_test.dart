import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("Unique", () {
    test("removes duplicates from simple list", () {
      final list = [1, 2, 2, 3, 3, 3];
      expect(list.unique(), [1, 2, 3]);
    });

    test("removes duplicates using custom identifier", () {
      final list = [
        {"id": 1, "name": "John"},
        {"id": 2, "name": "Jane"},
        {"id": 1, "name": "John Copy"},
      ];
      final result = list.unique((item) => item["id"]);
      expect(result.length, 2);
      expect(result.map((e) => e["id"]).toList(), [1, 2]);
    });

    test("handles empty list", () {
      final List<int> list = [];
      expect(list.unique(), []);
    });

    test("preserves order of elements", () {
      final list = [3, 1, 2, 1, 3];
      expect(list.unique(), [3, 1, 2]);
    });
  });

  group("ListNullability", () {
    test("isNullOrEmpty returns true for null list", () {
      List<int>? list;
      expect(list.isEmptyOrNull, true);
      expect(list.isNullOrEmpty, true);
    });

    test("isNullOrEmpty returns true for empty list", () {
      final List<int> list = [];
      expect(list.isEmptyOrNull, true);
      expect(list.isNullOrEmpty, true);
    });

    test("isNullOrEmpty returns false for non-empty list", () {
      final list = [1, 2, 3];
      expect(list.isEmptyOrNull, false);
      expect(list.isNullOrEmpty, false);
    });

    test("isNotNullOrEmpty returns opposite of isNullOrEmpty", () {
      List<int>? nullList;
      final emptyList = <int>[];
      final nonEmptyList = [1, 2, 3];

      expect(nullList.isEmptyOrNull, !nullList.isNotEmptyOrNull);
      expect(emptyList.isEmptyOrNull, !emptyList.isNotEmptyOrNull);
      expect(nonEmptyList.isEmptyOrNull, !nonEmptyList.isNotEmptyOrNull);

      expect(nullList.isNullOrEmpty, !nullList.isNotNullOrEmpty);
      expect(emptyList.isNullOrEmpty, !emptyList.isNotNullOrEmpty);
      expect(nonEmptyList.isNullOrEmpty, !nonEmptyList.isNotNullOrEmpty);
    });
  });
}
