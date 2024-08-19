import 'package:sugar/sugar.dart';

class SleepLength {
  final int hours;
  final int minutes;

  SleepLength({
    this.hours = 0,
    this.minutes = 0,
  });

  factory SleepLength.sleepLengthBy({
    required ZonedDateTime sleepStartInitial,
    required ZonedDateTime sleepStop,
  }) {
    final ZonedDateTime sleepStart = sleepStartInitial.isAfter(sleepStop)
        ? sleepStartInitial.subtract(const Duration(days: 1))
        : sleepStartInitial;
    final int diffHours = sleepStop.difference(sleepStart).inHours;
    final int diffMinutes =
        sleepStop.difference(sleepStart).inMinutes - diffHours * 60;
    return SleepLength(hours: diffHours, minutes: diffMinutes);
  }
}
