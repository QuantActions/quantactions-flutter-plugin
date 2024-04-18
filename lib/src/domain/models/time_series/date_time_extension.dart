import 'package:sugar/sugar.dart';

extension ZonedDateTimeNaN on ZonedDateTime {
  ZonedDateTime get nan => ZonedDateTime.fromEpochMilliseconds(Timezone('UTC'), 0);

  bool get isNaN => this == nan;

  static ZonedDateTime fromLocalDateTime(LocalDateTime localDateTime) {
    return ZonedDateTime.fromEpochMilliseconds(Timezone.now(),
        localDateTime.epochMilliseconds);
  }
}


