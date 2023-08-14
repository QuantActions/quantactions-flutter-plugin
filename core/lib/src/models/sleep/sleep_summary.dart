part of models;

class SleepSummary {
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final List<DateTime> interruptionsStart;
  final List<DateTime> interruptionsEnd;
  final List<int> interruptionsNumberOfTaps;

  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
  });

  factory SleepSummary.emptySummary() {
    return SleepSummary(
        sleepStart: DateTime.fromMicrosecondsSinceEpoch(0),
        sleepEnd: DateTime.fromMicrosecondsSinceEpoch(0),
        interruptionsStart:
            List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
        interruptionsEnd:
            List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
        interruptionsNumberOfTaps: List.generate(1, (index) => 0));
  }

  factory SleepSummary.fromJson(Map<String, dynamic> json) {
    return SleepSummary(
      sleepStart: json['sleepStart'] == null
          ? DateTime.fromMicrosecondsSinceEpoch(0)
          : DateTime.parse((json['sleepStart'] as String).split('[').first)
              .toLocal(),
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
              .map((e) =>
                  DateTime.parse((e as String).split('[').first).toLocal())
              .toList()
              .cast<DateTime>(),
      interruptionsNumberOfTaps: json['interruptionsNumberOfTaps'] == null
          ? List.empty()
          : json['interruptionsNumberOfTaps'].cast<int>(),
    );
  }
}
