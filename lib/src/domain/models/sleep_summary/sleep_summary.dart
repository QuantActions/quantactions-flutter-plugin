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
      interruptionsNumberOfTaps: List.generate(1, (index) => 0),
    );
  }
}
