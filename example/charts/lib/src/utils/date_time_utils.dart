

import 'package:intl/intl.dart';

class DateTimeUtils {

  static DateTime fromMillisecondsSinceEpoch(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
  }


  static List<int> getTimesList() {
    final List<int> times = <int>[];

    for (int hour = 6; hour < 22; ++hour) {
      times.add(hour);
    }

    return times;
  }

  static List<int> getMonthDays() {
    return List<int>.generate(31, (int index) => index + 1);
  }

  static int getWeekNumber(DateTime from, DateTime to) {
    final DateTime startDate = DateTime.utc(from.year, from.month, from.day);
    final DateTime endDate = DateTime.utc(to.year, to.month, to.day);
    return (endDate.difference(startDate).inDays / 7).round();
  }

  static String getHourAndMin(DateTime date) {
    final int hours = date.hour + (24 * (date.day - 1));
    if (hours == 0) {
      return '${DateFormat('m').format(date)}min';
    } else {
      return '${hours}h ${DateFormat('m').format(date)}min';
    }
  }

  static int getHours(DateTime date) {
    return date.hour + (24 * (date.day - 1));
  }

  static int getMinutes(DateTime date) {
    return date.minute;
  }

  static int getNextHourByMilliseconds(int milliseconds) {
    final DateTime date = fromMillisecondsSinceEpoch(milliseconds);
    return (getHours(date) + 1) * 3600000;
  }

  /// Monday, May 30
  static String formatDateWithWeekday(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  /// 30 May 2023
  static String formatDate(DateTime date) {
    return DateFormat('d MMMM yyy').format(date);
  }

  static bool isDateTheSame(DateTime firstDate, DateTime secondDate) {
    return firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month &&
        firstDate.day == secondDate.day;
  }

  static DateTime getNextMonth([DateTime? date]) {
    final DateTime currentDate = date ?? DateTime.now();
    return currentDate.month == 12
        ? DateTime(currentDate.year + 1, currentDate.month + 1)
        : DateTime(currentDate.year + 1, currentDate.month + 1);
  }

  static DateTime dateWithoutTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String format_DDMMYYYYY(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  static Duration parseISO8601ToDuration(String iso8601Duration) {
    final RegExp regex =
        RegExp(r'P(?:([0-9]+)D)?(?:T(?:([0-9]+)H)?(?:([0-9]+)M)?(?:([0-9]+(?:\.[0-9]+)?)S)?)?');
    final Iterable<RegExpMatch> matches = regex.allMatches(iso8601Duration);

    if (matches.isEmpty) {
      return Duration.zero;
    }

    final RegExpMatch match = matches.elementAt(0);

    final int days = int.tryParse(match.group(1) ?? '0') ?? 0;
    final int hours = int.tryParse(match.group(2) ?? '0') ?? 0;
    final int minutes = int.tryParse(match.group(3) ?? '0') ?? 0;
    final double seconds = double.tryParse(match.group(4) ?? '0') ?? 0;

    final int totalSeconds = days * Duration.secondsPerDay +
        hours * Duration.secondsPerHour +
        minutes * Duration.secondsPerMinute +
        seconds.round();

    return Duration(seconds: totalSeconds);
  }
}

extension WeekNumberGetter on DateTime {
  int weekNumber() => DateTimeUtils.getWeekNumber(DateTime(DateTime.now().year), this);
}
