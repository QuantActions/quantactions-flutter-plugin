part of 'time_series.dart';

extension TimeSeriesExtension<T> on TimeSeries<T> {
  TimeSeries<T> takeLast(int n) {
    return TimeSeries<T>(
      values: values.sublist(values.length - n),
      timestamps: timestamps.sublist(timestamps.length - n),
      confidenceIntervalLow:
          confidenceIntervalLow.sublist(confidenceIntervalLow.length - n),
      confidenceIntervalHigh:
          confidenceIntervalHigh.sublist(confidenceIntervalHigh.length - n),
      confidence: confidence.sublist(confidence.length - n),
    );
  }
}
