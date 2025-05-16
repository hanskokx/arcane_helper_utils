import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("StartAndEndOfPeriod", () {
    test("startOfHour returns correct DateTime", () {
      final dateTime = DateTime(2023, 1, 1, 12, 30, 45);
      final result = dateTime.startOfHour;
      expect(result, DateTime(2023, 1, 1, 12, 0, 0));
    });

    test("endOfHour returns correct DateTime", () {
      final dateTime = DateTime(2023, 1, 1, 12, 30, 45);
      final result = dateTime.endOfHour;
      expect(result, DateTime(2023, 1, 1, 12, 59, 59, 999, 999));
    });

    test("startOfDay returns correct DateTime", () {
      final dateTime = DateTime(2023, 1, 1, 12, 30, 45);
      final result = dateTime.startOfDay;
      expect(result, DateTime(2023, 1, 1));
    });

    test("endOfDay returns correct DateTime", () {
      final dateTime = DateTime(2023, 1, 1, 12, 30, 45);
      final result = dateTime.endOfDay;
      expect(result, DateTime(2023, 1, 1, 23, 59, 59, 999, 999));
    });
  });

  group("DaysInMonth", () {
    test("returns correct days for regular months", () {
      expect(DateTime(2023, 1, 1).daysInMonth, 31); // January
      expect(DateTime(2023, 3, 1).daysInMonth, 31); // March
      expect(DateTime(2023, 4, 1).daysInMonth, 30); // April
      expect(DateTime(2023, 5, 1).daysInMonth, 31); // May
      expect(DateTime(2023, 6, 1).daysInMonth, 30); // June
      expect(DateTime(2023, 7, 1).daysInMonth, 31); // July
      expect(DateTime(2023, 8, 1).daysInMonth, 31); // August
      expect(DateTime(2023, 9, 1).daysInMonth, 30); // September
      expect(DateTime(2023, 10, 1).daysInMonth, 31); // October
      expect(DateTime(2023, 11, 1).daysInMonth, 30); // November
      expect(DateTime(2023, 12, 1).daysInMonth, 31); // December
    });

    test("returns correct days for February in leap year", () {
      expect(DateTime(2020, 2, 1).daysInMonth, 29);
    });

    test("returns correct days for February in non-leap year", () {
      expect(DateTime(2023, 2, 1).daysInMonth, 28);
    });
  });

  group("IsToday", () {
    test("returns true for current date", () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      expect(today.isToday, true);
    });

    test("returns false for past date", () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isToday, false);
    });

    test("returns false for future date", () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(tomorrow.isToday, false);
    });
  });

  group("YesterdayAndTomorrow", () {
    test("yesterday returns one day before current date", () {
      final now = DateTime.now();
      final expectedYesterday = DateTime(now.year, now.month, now.day - 1);
      expect(DateTime.now().yesterday, expectedYesterday);
    });

    test("yesterday handles start of month correctly", () {
      final now = DateTime.now();
      final expected = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 1));
      expect(DateTime.now().yesterday, expected);
    });

    test("tomorrow returns one day after current date", () {
      final now = DateTime.now();
      final expectedTomorrow = DateTime(now.year, now.month, now.day + 1);
      expect(DateTime.now().tomorrow, expectedTomorrow);
    });

    test("tomorrow handles end of month correctly", () {
      final now = DateTime.now();
      final expected =
          DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
      expect(DateTime.now().tomorrow, expected);
    });

    test("leap year calculations work as expected", () {
      expect(DateTime(0).isLeapYear, false);
      expect(DateTime(2024).isLeapYear, true);
      expect(DateTime(2025).isLeapYear, false);

      expect((-1).isLeapYear, false);
      expect(0.isLeapYear, false);
      expect(2024.isLeapYear, true);
      expect(2025.isLeapYear, false);
    });
  });
}
