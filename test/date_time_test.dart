import "package:arcane_helper_utils/src/extensions/date_time.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("[DateTime] StartAndEndOfPeriod", () {
    test("Start of hour", () {
      final DateTime startOfHour = DateTime(2000, 1, 1, 12, 36, 53).startOfHour;
      expect(startOfHour, equals(DateTime(2000, 1, 1, 12, 0, 0)));
    });

    test("End of hour", () {
      final DateTime endOfHour = DateTime(2000, 1, 1, 12, 36, 53).endOfHour;
      expect(endOfHour, equals(DateTime(2000, 1, 1, 12, 59, 59, 999, 999)));
    });

    test("Start of day", () {
      final DateTime startOfDay = DateTime(2000, 1, 1, 12, 36, 53).startOfDay;
      expect(startOfDay, equals(DateTime(2000, 1, 1, 0, 0, 0)));
    });

    test("End of day", () {
      final DateTime endOfDay = DateTime(2000, 1, 1, 12, 36, 53).endOfDay;
      expect(endOfDay, equals(DateTime(2000, 1, 1, 23, 59, 59, 999, 999)));
    });

    test("Start of week", () {
      final DateTime startOfWeek = DateTime(2000, 1, 1, 12, 36, 53).startOfWeek;
      expect(startOfWeek, equals(DateTime(1999, 12, 27, 0, 0, 0)));
    });

    test("End of week", () {
      final DateTime endOfWeek = DateTime(2000, 1, 1, 12, 36, 53).endOfWeek;
      expect(endOfWeek, equals(DateTime(2000, 1, 2, 23, 59, 59, 999, 999)));
    });

    test("Start of month", () {
      final DateTime startOfMonth =
          DateTime(2000, 1, 17, 12, 36, 53).startOfMonth;
      expect(startOfMonth, equals(DateTime(2000, 1, 1, 0, 0, 0)));
    });

    test("End of month", () {
      final DateTime endOfMonth = DateTime(2000, 1, 17, 12, 36, 53).endOfMonth;
      expect(endOfMonth, equals(DateTime(2000, 1, 31, 23, 59, 59, 999, 999)));
    });

    test("End of month (leap year)", () {
      final DateTime endOfMonth = DateTime(2024, 2, 17, 12, 36, 53).endOfMonth;
      expect(endOfMonth, equals(DateTime(2024, 2, 29, 23, 59, 59, 999, 999)));
    });

    test("Start of year", () {
      final DateTime startOfYear =
          DateTime(2000, 5, 17, 12, 36, 53).startOfYear;
      expect(startOfYear, equals(DateTime(2000, 1, 1, 0, 0, 0)));
    });

    test("End of year", () {
      final DateTime endOfYear = DateTime(2000, 4, 17, 12, 36, 53).endOfYear;
      expect(endOfYear, equals(DateTime(2000, 12, 31, 23, 59, 59, 999, 999)));
    });

    test("End of year (leap year)", () {
      final DateTime endOfYear = DateTime(2024, 4, 17, 12, 36, 53).endOfYear;
      expect(endOfYear, equals(DateTime(2024, 12, 31, 23, 59, 59, 999, 999)));
    });

    test("First day of week", () {
      final DateTime firstDayOfWeek =
          DateTime(2024, 4, 17, 12, 36, 53).firstDayOfWeek;
      expect(
        firstDayOfWeek,
        equals(DateTime(2024, 4, 15)),
      );
    });
  });
  group("[DateTime] Calculations", () {
    test("Is today", () {
      final bool isToday = DateTime.now().isToday;
      final bool isNotToday =
          DateTime.now().subtract(const Duration(days: 1)).isToday;
      expect(isToday, equals(true));
      expect(isNotToday, equals(false));
    });

    test("Is same day as", () {
      final DateTime first = DateTime(2000, 1, 1);
      final DateTime second = DateTime(2000, 1, 2);
      final DateTime third = DateTime(2000, 1, 1);
      final bool firstAndSecond = first.isSameDayAs(second);
      final bool firstAndThird = first.isSameDayAs(third);

      expect(firstAndSecond, equals(false));
      expect(firstAndThird, equals(true));
    });
  });
}
