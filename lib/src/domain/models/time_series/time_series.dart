part 'time_series_extension.dart';

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
      values: List<T>.empty(),
      timestamps: List<DateTime>.empty(),
      confidenceIntervalLow: List<T>.empty(),
      confidenceIntervalHigh: List<T>.empty(),
      confidence: List<double>.empty(),
    );
  }
}
