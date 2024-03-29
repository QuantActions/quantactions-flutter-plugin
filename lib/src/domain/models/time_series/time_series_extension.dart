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

  TimeSeries<T> reverse() {
    return TimeSeries<T>(
      values: values.reversed.toList(),
      timestamps: timestamps.reversed.toList(),
      confidenceIntervalLow:
      confidenceIntervalLow.reversed.toList(),
      confidenceIntervalHigh:
      confidenceIntervalHigh.reversed.toList(),
      confidence: confidence.reversed.toList(),
    );
  }
}

extension DoubleTimeSeiresExtension on TimeSeries<double> {
  bool isEmpty() {
    return values.where((double element) => !element.isNaN).isEmpty;
  }
  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension SleepSummaryTimeSeiresExtension on TimeSeries<SleepSummary> {
  bool isEmpty() {
    return values.where((SleepSummary element) => element.sleepStart != DateTime.fromMicrosecondsSinceEpoch(0)).isEmpty;
  }
  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension ScreenTimeAggregateTimeSeiresExtension on TimeSeries<ScreenTimeAggregate> {
  bool isEmpty() {
    return values.where((ScreenTimeAggregate element) => !element.totalScreenTime.isNaN).isEmpty;
  }
  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension TrendHolderTimeSeiresExtension on TimeSeries<TrendHolder> {
  bool isEmpty() {
    return values.where((TrendHolder element) => !element.isNan()).isEmpty;
  }
  bool isNotEmpty() {
    return !isEmpty();
  }
}






