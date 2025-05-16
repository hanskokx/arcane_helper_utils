import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("FixedSizeList", () {
    test("initial list is empty", () {
      final list = FixedSizeList(5);
      expect(list.items, isEmpty);
    });

    test("adding elements below capacity", () {
      final list = FixedSizeList(3);
      list.add("one");
      expect(list.items, ["one"]);
      list.add("two");
      expect(list.items, ["one", "two"]);
    });

    test("adding elements up to capacity", () {
      final list = FixedSizeList(2);
      list.add("a");
      list.add("b");
      expect(list.items, ["a", "b"]);
    });

    test("adding elements beyond capacity removes the oldest", () {
      final list = FixedSizeList(2);
      list.add("first");
      list.add("second");
      expect(list.items, ["first", "second"]);
      list.add("third");
      expect(list.items, ["second", "third"]);
      list.add("fourth");
      expect(list.items, ["third", "fourth"]);
    });

    test("capacity of zero results in an empty list that stays empty", () {
      final list = FixedSizeList(0);
      list.add("anything");
      expect(list.items, isEmpty);
      list.add("something else");
      expect(list.items, isEmpty);
    });

    test("items getter returns an unmodifiable list", () {
      final list = FixedSizeList(2);
      list.add("alpha");
      list.add("beta");
      final items = list.items;
      expect(() => items.add("gamma"), throwsUnsupportedError);

      // Ensure original list is not modified
      expect(list.items, ["alpha", "beta"]);
    });

    test("adding multiple elements beyond capacity", () {
      final list = FixedSizeList(1);
      list.add("one");
      list.add("two");
      list.add("three");
      list.add("four");
      expect(list.items, ["four"]);
    });

    test("adding the same element multiple times", () {
      final list = FixedSizeList(3);
      list.add("same");
      list.add("same");
      list.add("same");
      expect(list.items, ["same", "same", "same"]);
      list.add("different");
      expect(list.items, ["same", "same", "different"]);
    });
  });
}
