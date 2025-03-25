import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("CommonString", () {
    test("contains correct constant values", () {
      expect(CommonString.emDash, "—");
      expect(CommonString.bulletPoint, "•");
      expect(CommonString.nbsp, "\u00A0");
    });
  });

  group("String Nullability", () {
    test("isNotNullOrEmpty returns correct values", () {
      String? nullString;
      expect(nullString.isNotNullOrEmpty, false);
      expect("".isNotNullOrEmpty, false);
      expect(" ".isNotNullOrEmpty, false);
      expect("text".isNotNullOrEmpty, true);
    });

    test("isNullOrEmpty returns correct values", () {
      String? nullString;
      expect(nullString.isNullOrEmpty, true);
      expect("".isNullOrEmpty, true);
      expect(" ".isNullOrEmpty, true);
      expect("text".isNullOrEmpty, false);
    });
  });

  group("String Split", () {
    test("splitByLength splits string correctly", () {
      expect("abcdef".splitByLength(2), ["ab", "cd", "ef"]);
      expect("abcde".splitByLength(2), ["ab", "cd", "e"]);
      expect("abcd".splitByLength(4), ["abcd"]);
      expect("abc".splitByLength(4), ["abc"]);
      expect("".splitByLength(2), []);
    });

    test("handles edge cases", () {
      expect("a".splitByLength(1), ["a"]);
      expect("abc".splitByLength(10), ["abc"]);
      expect("\u00A0".splitByLength(1), ["\u00A0"]);
    });
  });

  group("String TextManipulation", () {
    test("capitalize handles various cases", () {
      expect("hello".capitalize, "Hello");
      expect("HELLO".capitalize, "Hello");
      expect("h".capitalize, "H");
      expect("".capitalize, null);
      String? nullString;
      expect(nullString.capitalize, null);
    });

    test("capitalizeWords handles various cases", () {
      expect("hello world".capitalizeWords, "Hello World");
      expect("HELLO WORLD".capitalizeWords, "Hello World");
      expect("hello".capitalizeWords, "Hello");
      expect("".capitalizeWords, null);
      String? nullString;
      expect(nullString.capitalizeWords, null);
    });

    test("spacePascalCase handles various cases", () {
      expect("HelloWorld".spacePascalCase, "Hello World");
      expect("ABC".spacePascalCase, "A B C");
      expect("helloWorld".spacePascalCase, "hello World");
      expect("".spacePascalCase, null);
      String? nullString;
      expect(nullString.spacePascalCase, null);
    });
  });
}
