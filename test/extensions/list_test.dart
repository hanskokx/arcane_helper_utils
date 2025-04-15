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

  group("ListEquality", () {
    // Helper function to make tests more concise
    void testEquality<T>(
      List<T?>? list1,
      List<T?>? list2,
      bool expected, {
      bool ignoreSorting = false,
    }) {
      expect(
        list1.equals(list2, ignoreSorting: ignoreSorting),
        expected,
        reason:
            'Expected ${list1?.toString()} and ${list2?.toString()} to be ${expected ? "equal" : "unequal"} when ignoreSorting is $ignoreSorting',
      );
    }

    test("Both lists are null", () {
      testEquality(null, null, true);
    });

    test("One list is null, the other is not", () {
      testEquality([1, 2, 3], null, false);
      testEquality(null, [1, 2, 3], false);
    });

    test("Lists have different lengths", () {
      testEquality([1, 2, 3], [1, 2], false);
      testEquality([1, 2], [1, 2, 3], false);
    });

    test("Lists have the same elements in the same order", () {
      testEquality([1, 2, 3], [1, 2, 3], true);
      testEquality(["a", "b", "c"], ["a", "b", "c"], true);
      testEquality([true, false, true], [true, false, true], true);
    });

    test(
        "Lists have the same elements in a different order - without ignoreSorting",
        () {
      testEquality([1, 2, 3], [3, 2, 1], false);
    });

    test(
        "Lists have the same elements in a different order - with ignoreSorting",
        () {
      testEquality([1, 2, 3], [3, 2, 1], true, ignoreSorting: true);
    });

    test("Lists have different elements", () {
      testEquality([1, 2, 3], [1, 2, 4], false);
      testEquality(["a", "b", "c"], ["a", "b", "d"], false);
    });

    test("Lists with null elements - both null at same index", () {
      testEquality([1, null, 3], [1, null, 3], true);
    });

    test("Lists with null elements - one null, one not null at same index", () {
      testEquality([1, null, 3], [1, 2, 3], false);
      testEquality([1, 2, 3], [1, null, 3], false);
    });

    test("Lists with multiple null elements", () {
      testEquality([null, null, null], [null, null, null], true);
      testEquality([null, 1, null], [null, 1, null], true);
      testEquality([null, 1, null], [1, null, 1], false);
    });

    test("Empty lists", () {
      testEquality([], [], true);
    });
    test("List of different types", () {
      testEquality(<int?>[], <String?>[], false);
    });

    test("Lists of comparable items with different order - ignoreSorting true",
        () {
      testEquality([3, 1, 2], [1, 2, 3], true, ignoreSorting: true);
      testEquality(
        ["c", "a", "b"],
        ["b", "c", "a"],
        true,
        ignoreSorting: true,
      );
    });

    test("Lists of comparable items with different order - ignoreSorting false",
        () {
      testEquality([3, 1, 2], [1, 2, 3], false, ignoreSorting: false);
      testEquality(
        ["c", "a", "b"],
        ["b", "c", "a"],
        false,
        ignoreSorting: false,
      );
    });

    test("Lists with nulls and different order - ignoreSorting true", () {
      testEquality([null, 3, 1, 2], [1, 2, 3, null], true, ignoreSorting: true);
      testEquality([3, 1, 2, null], [null, 1, 2, 3], true, ignoreSorting: true);
    });

    test("Lists with nulls and different order - ignoreSorting false", () {
      testEquality(
        [null, 3, 1, 2],
        [1, 2, 3, null],
        false,
        ignoreSorting: false,
      );
    });

    test(
        "Lists of non-comparable items with different order - ignoreSorting true",
        () {
      final List<NonComparable?> list1 = [
        NonComparable(1),
        NonComparable(2),
        NonComparable(3),
      ];
      final List<NonComparable?> list2 = [
        NonComparable(3),
        NonComparable(1),
        NonComparable(2),
      ];
      testEquality(list1, list2, true, ignoreSorting: true);
    });
  });
}

class NonComparable {
  final int value;
  NonComparable(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NonComparable &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => "NonComparable($value)";
}
