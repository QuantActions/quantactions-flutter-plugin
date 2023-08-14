part of models;

class TimeSeries<T> {
  final List<T> values;
  final List<DateTime> timestamps;
  final List<T> confidenceIntervalLow;
  final List<T> confidenceIntervalHigh;
  final List<double> confidence;

  const TimeSeries({
    required this.values,
    required this.timestamps,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.confidence,
  });
}
