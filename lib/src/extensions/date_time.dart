import "package:week_number/iso.dart";

/// An extension on `DateTime` to get the start and end of various time periods.
extension StartAndEndOfPeriod on DateTime {
  /// Returns a `DateTime` object representing the start of the hour.
  ///
  /// The time is set to the beginning of the current hour with minutes, seconds,
  /// and milliseconds set to zero.
  DateTime get startOfHour => DateTime(year, month, day, hour);

  /// Returns a `DateTime` object representing the end of the hour.
  ///
  /// The time is set to the last microsecond of the current hour.
  DateTime get endOfHour => DateTime(year, month, day, hour)
      .add(const Duration(hours: 1))
      .subtract(const Duration(microseconds: 1));

  /// Returns a `DateTime` object representing the start of the day.
  ///
  /// The time is set to 00:00 (midnight) of the current day.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a `DateTime` object representing the end of the day.
  ///
  /// The time is set to the last microsecond of the current day, 23:59:59.999999.
  DateTime get endOfDay => startOfDay
      .add(const Duration(days: 1))
      .subtract(const Duration(microseconds: 1));

  /// Returns a `DateTime` object representing the end of the current week.
  ///
  /// The time is set to the end of the last day of the current week (Sunday).
  DateTime get endOfWeek => endOfDay.add(
        Duration(
          days: DateTime.daysPerWeek - weekday,
        ),
      );

  /// Returns a `DateTime` object representing the end of the current month.
  ///
  /// The time is set to the last microsecond of the last day of the current month.
  DateTime get endOfMonth => endOfDay.add(
        Duration(
          days: daysInMonth - day,
        ),
      );

  /// Returns a `DateTime` object representing the start of the current week.
  ///
  /// The time is set to the start of the first day of the current week (Monday).
  DateTime get startOfWeek => startOfDay.subtract(
        Duration(
          days: weekday - DateTime.monday,
        ),
      );

  /// Returns a `DateTime` object representing the start of the current month.
  ///
  /// The time is set to the beginning of the first day of the current month.
  DateTime get startOfMonth => DateTime(
        year,
        month,
        1,
      ).startOfDay;

  /// Returns a `DateTime` object representing the start of the current year.
  ///
  /// The time is set to the beginning of the first day of the current year.
  DateTime get startOfYear => DateTime(year).startOfDay;

  /// Returns a `DateTime` object representing the end of the current year.
  ///
  /// The time is set to the last microsecond of the last day of the current year.
  DateTime get endOfYear => startOfYear
      .add(
        Duration(days: this.isLeapYear ? 365 : 364),
      )
      .endOfDay;
}

/// An extension on `DateTime` to get the number of days in the current month.
extension DaysInMonth on DateTime {
  /// Returns the number of days in the current month.
  ///
  /// It correctly handles leap years and different month lengths.
  int get daysInMonth => DateTime(year, month + 1, 0).day;
}

/// An extension on `DateTime` to check if a date is today or if it is the same day as another date.
extension IsToday on DateTime {
  /// Returns `true` if the current date is today.
  bool get isToday => DateTime.now().difference(this).inDays == 0;

  /// Returns `true` if the current date is the same day as [other].
  bool isSameDayAs(DateTime other) =>
      DateTime(other.year, other.month, other.day)
          .isAtSameMomentAs(DateTime(year, month, day));
}

/// An extension on `DateTime` to get the first day of the current week.
extension FirstDayOfWeek on DateTime {
  /// Returns a `DateTime` object representing the first day of the current week (Monday).
  ///
  /// The time is set to the start of that day.
  DateTime get firstDayOfWeek {
    final int daysToSubtract = weekday - DateTime.monday;
    final DateTime firstDay =
        subtract(Duration(days: daysToSubtract)).startOfDay;
    return firstDay;
  }
}
