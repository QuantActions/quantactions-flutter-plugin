import 'package:json_annotation/json_annotation.dart';

import '../../../../qa_flutter_plugin.dart';
import '../../domain.dart';

part 'time_series.g.dart';

part 'time_series_extension.dart';

@JsonSerializable()
class TimeSeries<T> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final List<T> values;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final List<DateTime> timestamps;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final List<T> confidenceIntervalLow;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final List<T> confidenceIntervalHigh;
  @JsonKey(fromJson: _dataFromJson<double>, toJson: _dataToJson<double>)
  final List<double> confidence;

  TimeSeries({
    required this.values,
    required this.timestamps,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.confidence,
  });

  factory TimeSeries.fromJson(Map<String, dynamic> json) => _$TimeSeriesFromJson<T>(json);

  Map<String, dynamic> toJson() {
    return _$TimeSeriesToJson<T>(this);
  }

  static T _dataFromJson<T>(dynamic json) {
    return _QATimeSeriesConverter<T>().fromJson(json);
  }

  static dynamic _dataToJson<T>(T object) {
    return _QATimeSeriesConverter<T>().toJson(object);
  }

  static List<String> _dateTimeToJson(List<DateTime> dateTime) =>
      dateTime.map((DateTime dateTime) => dateTime.toString()).toList();

  static List<DateTime> _dateTimeFromJson(List<dynamic> data) => data
      .map<DateTime>((dynamic item) => DateTime.parse(item.split('[').first).toLocal())
      .toList();

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

class _QATimeSeriesConverter<T> implements JsonConverter<T, dynamic> {
  _QATimeSeriesConverter();

  @override
  T fromJson(dynamic json) {
    if (T == List<TrendHolder>) {
      return json.map<TrendHolder>((dynamic item) {
        if (item == null) {
          return TrendHolder.empty();
        }
        return TrendHolder.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else if (T == List<SleepSummary>) {
      return json.map<SleepSummary>((dynamic item) {
        if (item == null) {
          return SleepSummary.emptySummary();
        }
        return SleepSummary.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else if (T == List<ScreenTimeAggregate>) {
      return json.map<ScreenTimeAggregate>((dynamic item) {
        if (item == null) {
          return ScreenTimeAggregate.empty();
        }
        return ScreenTimeAggregate.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else {
      if (json == null) {
        return double.nan as T;
      } else {
        return json
            .map<double?>((dynamic item) => item == null ? double.nan : checkDouble(item))
            .cast<double>()
            .toList();
      }
    }
  }

  @override
  dynamic toJson(T object) {
    if (T == List<TrendHolder>) {
      return (object as List<dynamic>)
          .map((dynamic item) => (item as TrendHolder).toJson())
          .toList();
    } else if (T == List<SleepSummary>) {
      return (object as List<dynamic>)
          .map((dynamic item) => (item as SleepSummary).toJson())
          .toList();
    } else if (T == List<ScreenTimeAggregate>) {
      return (object as List<dynamic>)
          .map((dynamic item) => (item as ScreenTimeAggregate).toJson())
          .toList();
    } else {
      return object;
    }
  }

  static double checkDouble(dynamic value) {
    if (value is double) {
      return value;
    } else {
      return value.toDouble();
    }
  }

}

TimeSeries<double> fillMissingDays(TimeSeries<double> timeSeries , int rewindDays) {
  final List<DateTime> newTimestamps = [];
  final List<double> newValues = [];
  final List<double> newConfidenceIntervalLow = [];
  final List<double> newConfidenceIntervalHigh = [];
  final List<double> newConfidence = [];
  final currentDay = DateTime.now();
  var prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final nMissingDays = prevDate
        .difference(currentDay)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(double.nan);
      newConfidenceIntervalLow.add(double.nan);
      newConfidenceIntervalHigh.add(double.nan);
      newConfidence.add(double.nan);
    }
  }

  for (var i = 0; i < timeSeries.values.length; i++) {
    final nMissingDays = timeSeries.timestamps[i]
        .difference(prevDate)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(double.nan);
      newConfidenceIntervalLow.add(double.nan);
      newConfidenceIntervalHigh.add(double.nan);
      newConfidence.add(double.nan);
    }
    newTimestamps.add(timeSeries.timestamps[i]);
    newValues.add(timeSeries.values[i]);
    newConfidenceIntervalLow.add(timeSeries.confidenceIntervalLow[i]);
    newConfidenceIntervalHigh.add(timeSeries.confidenceIntervalHigh[i]);
    newConfidence.add(timeSeries.confidence[i]);
    prevDate = timeSeries.timestamps[i];
  }

  // Adding missing days up to today
  final nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last
      .difference(currentDay)
      .inDays
      : 0;
  final lastValue = newTimestamps.last;
  for (var j = 0; j < nMissingFutureDays; j++) {
    newTimestamps.add(lastValue.add(Duration(days: j + 1)));
    newValues.add(double.nan);
    newConfidenceIntervalLow.add(double.nan);
    newConfidenceIntervalHigh.add(double.nan);
    newConfidence.add(double.nan);
  }

  return TimeSeries<double>(
    values: newValues,
    timestamps: newTimestamps,
    confidenceIntervalLow: newConfidenceIntervalLow,
    confidenceIntervalHigh: newConfidenceIntervalHigh,
    confidence: newConfidence,
  );
}

// now I need a similar fillMissing function for TimeSeries<SleepSummary> and TimeSeries<ScreenTimeAggregate>

TimeSeries<SleepSummary> fillMissingDaysSleepSummary(TimeSeries<SleepSummary> timeSeries , int rewindDays) {
  final List<DateTime> newTimestamps = <DateTime>[];
  final List<SleepSummary> newValues = <SleepSummary>[];
  final List<SleepSummary> newConfidenceIntervalLow = [];
  final List<SleepSummary> newConfidenceIntervalHigh = [];
  final List<double> newConfidence = [];
  final currentDay = DateTime.now();
  var prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final int nMissingDays = prevDate
        .difference(currentDay)
        .inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(SleepSummary.emptySummary());
      newConfidenceIntervalLow.add(SleepSummary.emptySummary());
      newConfidenceIntervalHigh.add(SleepSummary.emptySummary());
      newConfidence.add(double.nan);
    }
  }

  for (var i = 0; i < timeSeries.values.length; i++) {
    final nMissingDays = timeSeries.timestamps[i]
        .difference(prevDate)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(SleepSummary.emptySummary());
      newConfidenceIntervalLow.add(SleepSummary.emptySummary());
      newConfidenceIntervalHigh.add(SleepSummary.emptySummary());
      newConfidence.add(double.nan);
    }
    newTimestamps.add(timeSeries.timestamps[i]);
    newValues.add(timeSeries.values[i]);
    newConfidenceIntervalLow.add(timeSeries.confidenceIntervalLow[i]);
    newConfidenceIntervalHigh.add(timeSeries.confidenceIntervalHigh[i]);
    newConfidence.add(timeSeries.confidence[i]);
    prevDate = timeSeries.timestamps[i];
  }

  // Adding missing days up to today
  final nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last
      .difference(currentDay)
      .inDays
      : 0;
  final lastValue = newTimestamps.last;
  for (var j = 0; j < nMissingFutureDays; j++) {
    newTimestamps.add(lastValue.add(Duration(days: j + 1)));
    newValues.add(SleepSummary.emptySummary());
    newConfidenceIntervalLow.add(SleepSummary.emptySummary());
    newConfidenceIntervalHigh.add(SleepSummary.emptySummary());
    newConfidence.add(double.nan);
  }

  return TimeSeries<SleepSummary>(
    values: newValues,
    timestamps: newTimestamps,
    confidenceIntervalLow: newConfidenceIntervalLow,
    confidenceIntervalHigh: newConfidenceIntervalHigh,
    confidence: newConfidence,
  );

}

TimeSeries<ScreenTimeAggregate> fillMissingDaysScreenTimeAggregate(TimeSeries<ScreenTimeAggregate> timeSeries , int rewindDays) {
  final List<DateTime> newTimestamps = [];
  final List<ScreenTimeAggregate> newValues = [];
  final List<ScreenTimeAggregate> newConfidenceIntervalLow = [];
  final List<ScreenTimeAggregate> newConfidenceIntervalHigh = [];
  final List<double> newConfidence = [];
  final currentDay = DateTime.now();
  var prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final nMissingDays = prevDate
        .difference(currentDay)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalLow.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalHigh.add(ScreenTimeAggregate.empty());
      newConfidence.add(double.nan);
    }
  }

  for (var i = 0; i < timeSeries.values.length; i++) {
    final nMissingDays = timeSeries.timestamps[i]
        .difference(prevDate)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalLow.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalHigh.add(ScreenTimeAggregate.empty());
      newConfidence.add(double.nan);
    }
    newTimestamps.add(timeSeries.timestamps[i]);
    newValues.add(timeSeries.values[i]);
    newConfidenceIntervalLow.add(timeSeries.confidenceIntervalLow[i]);
    newConfidenceIntervalHigh.add(timeSeries.confidenceIntervalHigh[i]);
    newConfidence.add(timeSeries.confidence[i]);
    prevDate = timeSeries.timestamps[i];
  }

  // Adding missing days up to today
  final nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last
      .difference(currentDay)
      .inDays
      : 0;
  final lastValue = newTimestamps.last;
  for (var j = 0; j < nMissingFutureDays; j++) {
    newTimestamps.add(lastValue.add(Duration(days: j + 1)));
    newValues.add(ScreenTimeAggregate.empty());
    newConfidenceIntervalLow.add(ScreenTimeAggregate.empty());
    newConfidenceIntervalHigh.add(ScreenTimeAggregate.empty());
    newConfidence.add(double.nan);
  }

  return TimeSeries<ScreenTimeAggregate>(
    values: newValues,
    timestamps: newTimestamps,
    confidenceIntervalLow: newConfidenceIntervalLow,
    confidenceIntervalHigh: newConfidenceIntervalHigh,
    confidence: newConfidence,
  );
}
// I need a fill missing days function for TrendHolder

TimeSeries<TrendHolder> fillMissingDaysTrendHolder(TimeSeries<TrendHolder> timeSeries , int rewindDays) {
  final List<DateTime> newTimestamps = [];
  final List<TrendHolder> newValues = [];
  final List<TrendHolder> newConfidenceIntervalLow = [];
  final List<TrendHolder> newConfidenceIntervalHigh = [];
  final List<double> newConfidence = [];
  final currentDay = DateTime.now();
  var prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final nMissingDays = prevDate
        .difference(currentDay)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(TrendHolder.empty());
      newConfidenceIntervalLow.add(TrendHolder.empty());
      newConfidenceIntervalHigh.add(TrendHolder.empty());
      newConfidence.add(double.nan);
    }
  }

  for (var i = 0; i < timeSeries.values.length; i++) {
    final nMissingDays = timeSeries.timestamps[i]
        .difference(prevDate)
        .inDays - 1;
    for (var j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(TrendHolder.empty());
      newConfidenceIntervalLow.add(TrendHolder.empty());
      newConfidenceIntervalHigh.add(TrendHolder.empty());
      newConfidence.add(double.nan);
    }
    newTimestamps.add(timeSeries.timestamps[i]);
    newValues.add(timeSeries.values[i]);
    newConfidenceIntervalLow.add(timeSeries.confidenceIntervalLow[i]);
    newConfidenceIntervalHigh.add(timeSeries.confidenceIntervalHigh[i]);
    newConfidence.add(timeSeries.confidence[i]);
    prevDate = timeSeries.timestamps[i];
  }

  // Adding missing days up to today
  final nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last
      .difference(currentDay)
      .inDays
      : 0;
  final lastValue = newTimestamps.last;
  for (var j = 0; j < nMissingFutureDays; j++) {
    newTimestamps.add(lastValue.add(Duration(days: j + 1)));
    newValues.add(TrendHolder.empty());
    newConfidenceIntervalLow.add(TrendHolder.empty());
    newConfidenceIntervalHigh.add(TrendHolder.empty());
    newConfidence.add(double.nan);
  }

  return TimeSeries<TrendHolder>(
    values: newValues,
    timestamps: newTimestamps,
    confidenceIntervalLow: newConfidenceIntervalLow,
    confidenceIntervalHigh: newConfidenceIntervalHigh,
    confidence: newConfidence,
  );
}

// and also a takeLast function for TrendHolder

TimeSeries<TrendHolder> takeLastTrendHolder(TimeSeries<TrendHolder> timeSeries, int n) {

  final timeSeries2 = fillMissingDaysTrendHolder(timeSeries, n);

  return TimeSeries<TrendHolder>(
    values: timeSeries2.values.sublist(timeSeries2.values.length - n),
    timestamps: timeSeries2.timestamps.sublist(timeSeries2.timestamps.length - n),
    confidenceIntervalLow:
    timeSeries2.confidenceIntervalLow.sublist(timeSeries2.confidenceIntervalLow.length - n),
    confidenceIntervalHigh:
    timeSeries2.confidenceIntervalHigh.sublist(timeSeries2.confidenceIntervalHigh.length - n),
    confidence: timeSeries2.confidence.sublist(timeSeries2.confidence.length - n),
  );
}


TimeSeries<double> takeLast(TimeSeries<double> timeSeries, int n) {

  final timeSeries2 = fillMissingDays(timeSeries, n);

  return TimeSeries<double>(
    values: timeSeries2.values.sublist(timeSeries2.values.length - n),
    timestamps: timeSeries2.timestamps.sublist(timeSeries2.timestamps.length - n),
    confidenceIntervalLow:
    timeSeries2.confidenceIntervalLow.sublist(timeSeries2.confidenceIntervalLow.length - n),
    confidenceIntervalHigh:
    timeSeries2.confidenceIntervalHigh.sublist(timeSeries2.confidenceIntervalHigh.length - n),
    confidence: timeSeries2.confidence.sublist(timeSeries2.confidence.length - n),
  );
}

// now I need the similar function for TimeSeries<SleepSummary> and TimeSeries<ScreenTimeAggregate>

TimeSeries<SleepSummary> takeLastSleepSummary(TimeSeries<SleepSummary> timeSeries, int n) {

  final timeSeries2 = fillMissingDaysSleepSummary(timeSeries, n);

  return TimeSeries<SleepSummary>(
    values: timeSeries2.values.sublist(timeSeries2.values.length - n),
    timestamps: timeSeries2.timestamps.sublist(timeSeries2.timestamps.length - n),
    confidenceIntervalLow:
    timeSeries2.confidenceIntervalLow.sublist(timeSeries2.confidenceIntervalLow.length - n),
    confidenceIntervalHigh:
    timeSeries2.confidenceIntervalHigh.sublist(timeSeries2.confidenceIntervalHigh.length - n),
    confidence: timeSeries2.confidence.sublist(timeSeries2.confidence.length - n),
  );
}

TimeSeries<ScreenTimeAggregate> takeLastScreenTimeAggregate(TimeSeries<ScreenTimeAggregate> timeSeries, int n) {

  final timeSeries2 = fillMissingDaysScreenTimeAggregate(timeSeries, n);

  return TimeSeries<ScreenTimeAggregate>(
    values: timeSeries2.values.sublist(timeSeries2.values.length - n),
    timestamps: timeSeries2.timestamps.sublist(timeSeries2.timestamps.length - n),
    confidenceIntervalLow:
    timeSeries2.confidenceIntervalLow.sublist(timeSeries2.confidenceIntervalLow.length - n),
    confidenceIntervalHigh:
    timeSeries2.confidenceIntervalHigh.sublist(timeSeries2.confidenceIntervalHigh.length - n),
    confidence: timeSeries2.confidence.sublist(timeSeries2.confidence.length - n),
  );
}


