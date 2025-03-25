import "dart:async";

import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("DynamicPrintExtension", () {
    late List<String> printLog;
    late ZoneSpecification spec;
    late Zone testZone;

    setUp(() {
      // Create a buffer to store print output
      printLog = [];

      // Create a custom zone specification that captures print output
      spec = ZoneSpecification(
        print: (_, __, ___, String msg) {
          printLog.add(msg);
        },
      );

      // Create a test zone with the custom specification
      testZone = Zone.current.fork(specification: spec);
    });

    test("printValue prints and returns the value without label", () {
      testZone.run(() {
        const testValue = "test string";
        // Ignore deprecation warning in test
        // ignore: deprecated_member_use_from_same_package
        final result = testValue.printValue<String>();

        expect(result, equals(testValue));
        expect(printLog, hasLength(1));
        expect(printLog.first, equals(testValue));
      });
    });

    test("printValue prints and returns the value with label", () {
      testZone.run(() {
        const testValue = 42;
        const label = "number";
        // ignore: deprecated_member_use_from_same_package
        final result = testValue.printValue<int>(label);

        expect(result, equals(testValue));
        expect(printLog, hasLength(1));
        expect(printLog.first, equals("$label: $testValue"));
      });
    });

    test("printValue works with null values", () {
      testZone.run(() {
        const String? testValue = null;
        // ignore: deprecated_member_use_from_same_package
        final result = testValue.printValue<String?>("nullable");

        expect(result, isNull);
        expect(printLog, hasLength(1));
        expect(printLog.first, equals("nullable: null"));
      });
    });

    test("printValue works with complex objects", () {
      testZone.run(() {
        final testValue = {"key": "value"};
        // ignore: deprecated_member_use_from_same_package
        final result = testValue.printValue<Map<String, String>>();

        expect(result, equals(testValue));
        expect(printLog, hasLength(1));
        expect(printLog.first, equals(testValue.toString()));
      });
    });
  });
}
