part of models;

extension TimeSeriesExtension<T> on TimeSeries<T> {
  TimeSeries<T> takeLast(int n) {
    return TimeSeries<T>(
      values: values.sublist(values.length - n),
      timestamps: timestamps.sublist(timestamps.length - n),
      confidenceIntervalLow: confidenceIntervalLow.sublist(
        confidenceIntervalLow.length - n,
      ),
      confidenceIntervalHigh: confidenceIntervalHigh.sublist(
        confidenceIntervalHigh.length - n,
      ),
      confidence: confidence.sublist(confidence.length - n),
    );
  }

  static TimeSeries empty() {
    return TimeSeries(
      values: List.empty(),
      timestamps: List.empty(),
      confidenceIntervalLow: List.empty(),
      confidenceIntervalHigh: List.empty(),
      confidence: List.empty(),
    );
  }
}
