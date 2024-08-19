import 'package:sugar/sugar.dart';
extension DayTimeFormatterFromInt on int {
  String format_12() {
    final String postfix = this < 12 ? 'am' : 'pm';
    return '${this < 13 ? this : this % 12}:00 $postfix';
  }
}

extension ZonedDateTimeNaN on ZonedDateTime {
  ZonedDateTime get nan => ZonedDateTime.fromEpochMilliseconds(Timezone('UTC'), 0);
}



