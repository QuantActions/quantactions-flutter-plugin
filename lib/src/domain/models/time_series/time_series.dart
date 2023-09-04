import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'time_series.g.dart';

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

  factory TimeSeries.fromJson(Map<String, dynamic> json) =>
      _$TimeSeriesFromJson<T>(json);

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
      dateTime.map((e) => e.toString()).toList();

  static List<DateTime> _dateTimeFromJson(List<dynamic> data) => data
      .map<DateTime>((e) => DateTime.parse((e).split('[').first).toLocal())
      .toList();

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

class _QATimeSeriesConverter<T> implements JsonConverter<T, dynamic> {
  _QATimeSeriesConverter();

  @override
  T fromJson(dynamic json) {
    if (T == List<TrendHolder>) {
      return json.map<TrendHolder>((e) => TrendHolder.fromJson(e)).toList();
    } else if (T == List<SleepSummary>) {
      return json.map<SleepSummary>((e) => SleepSummary.fromJson(e)).toList();
    } else if (T == List<ScreenTimeAggregate>) {
      return json
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList();
    } else {
      if (json == null) {
        return double.nan as T;
      } else {
        return json
            .map<double?>((e) => e == null ? double.nan : e as double).cast<double>()
            .toList();
      }
    }
  }

  @override
  dynamic toJson(T object) {
    if (T == List<TrendHolder>) {
      return (object as List)
          .map((element) => (element as TrendHolder).toJson())
          .toList();
    } else if (T == List<SleepSummary>) {
      return (object as List)
          .map((element) => (element as SleepSummary).toJson())
          .toList();
    } else if (T == List<ScreenTimeAggregate>) {
      return (object as List)
          .map((element) => (element as ScreenTimeAggregate).toJson())
          .toList();
    } else {
      return object;
    }
  }
}
