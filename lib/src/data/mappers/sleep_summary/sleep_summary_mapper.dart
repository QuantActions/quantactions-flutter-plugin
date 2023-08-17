import '../../../domain/domain.dart';

class SleepSummaryMapper {
  static SleepSummary fromJson(Map<String, dynamic> json) {
    return SleepSummary(
      sleepStart: json['sleepStart'] == null
          ? DateTime.fromMicrosecondsSinceEpoch(0)
          : DateTime.parse(
              (json['sleepStart'] as String).split('[').first,
            ).toLocal(),
      sleepEnd: json['sleepEnd'] == null
          ? DateTime.fromMicrosecondsSinceEpoch(0)
          : DateTime.parse((json['sleepEnd'] as String).split('[').first)
              .toLocal(),
      interruptionsStart: json['interruptionsStart'] == null
          ? List.empty()
          : json['interruptionsStart']
              .cast<String>()
              .map((e) =>
                  DateTime.parse((e as String).split('[').first).toLocal())
              .toList()
              .cast<DateTime>(),
      interruptionsEnd: json['interruptionsEnd'] == null
          ? List.empty()
          : json['interruptionsStart']
              .cast<String>()
              .map(
                (e) => DateTime.parse((e as String).split('[').first).toLocal(),
              )
              .toList()
              .cast<DateTime>(),
      interruptionsNumberOfTaps: json['interruptionsNumberOfTaps'] == null
          ? List.empty()
          : json['interruptionsNumberOfTaps'].cast<int>(),
    );
  }
}
