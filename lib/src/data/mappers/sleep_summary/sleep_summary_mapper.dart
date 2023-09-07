import '../../../domain/domain.dart';

class SleepSummaryMapper {
  static SleepSummary fromJson(Map<String, dynamic> json) {
    return SleepSummary(
      sleepStart: json['sleepStart'] == null
          ? DateTime.fromMicrosecondsSinceEpoch(0)
          : DateTime.parse((json['sleepStart'] as String).split('[').first).toLocal(),
      sleepEnd: json['sleepEnd'] == null
          ? DateTime.fromMicrosecondsSinceEpoch(0)
          : DateTime.parse((json['sleepEnd'] as String).split('[').first).toLocal(),
      interruptionsStart: json['interruptionsStart'] == null
          ? List<DateTime>.empty()
          : json['interruptionsStart']
              .cast<String>()
              .map((dynamic item) => DateTime.parse((item as String).split('[').first).toLocal())
              .toList()
              .cast<DateTime>(),
      interruptionsEnd: json['interruptionsEnd'] == null
          ? List<DateTime>.empty()
          : json['interruptionsStart']
              .cast<String>()
              .map((dynamic item) => DateTime.parse((item as String).split('[').first).toLocal())
              .toList()
              .cast<DateTime>(),
      interruptionsNumberOfTaps: json['interruptionsNumberOfTaps'] == null
          ? List<int>.empty()
          : json['interruptionsNumberOfTaps'].cast<int>(),
    );
  }
}
