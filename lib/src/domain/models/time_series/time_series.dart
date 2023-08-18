class TimeSeries<T> {
  final List<T> values;
  final List<DateTime> timestamps;
  final List<T> confidenceIntervalLow;
  final List<T> confidenceIntervalHigh;
  final List<double> confidence;

  TimeSeries({
    required this.values,
    required this.timestamps,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.confidence,
  });

  factory TimeSeries.empty() {
    return TimeSeries<T>(
      values: List.empty(),
      timestamps: List.empty(),
      confidenceIntervalLow: List.empty(),
      confidenceIntervalHigh: List.empty(),
      confidence: List.empty(),
    );
  }
}
