import 'package:sugar/sugar.dart';

/// ZonedDateTime extension
extension ZonedDateTimeNaN on ZonedDateTime {
  /// Definition of NaN ZonedDateTime
  ZonedDateTime get nan =>
      ZonedDateTime.fromEpochMilliseconds(Timezone('UTC'), 0);

  /// Check if ZonedDateTime is NaN
  bool get isNaN => this == nan;

  /// Return a ZonedDateTime from a LocalDateTime
  static ZonedDateTime fromLocalDateTime(LocalDateTime localDateTime) {
    return ZonedDateTime.fromEpochMilliseconds(
        Timezone.now(), localDateTime.epochMilliseconds);
  }
}
