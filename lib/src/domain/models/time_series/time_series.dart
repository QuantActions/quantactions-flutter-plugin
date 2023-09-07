import 'package:json_annotation/json_annotation.dart';

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
      return json
          .map<TrendHolder>((dynamic item) => TrendHolder.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (T == List<SleepSummary>) {
      return json
          .map<SleepSummary>((dynamic item) => SleepSummary.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (T == List<ScreenTimeAggregate>) {
      return json
          .map<ScreenTimeAggregate>(
            (dynamic item) => ScreenTimeAggregate.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } else {
      if (json == null) {
        return double.nan as T;
      } else {
        return json
            .map<double?>((dynamic item) => item == null ? double.nan : item as double)
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
}
