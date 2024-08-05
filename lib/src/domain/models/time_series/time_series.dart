import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/iterables.dart';
import 'package:sugar/sugar.dart';

import '../../../../quantactions_flutter_plugin.dart';
import '../../domain.dart';
import 'date_time_extension.dart';

part 'time_series.g.dart';
part 'time_series_extension.dart';

/// Utility class to hold a pair of lists, one with the score values and one with the timestamps
/// @property timestamps timestamps relative to the score, are always normalized to the CURRENT local
/// time zone of the device
///
@JsonSerializable()
class TimeSeries<T> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)

  /// Values over time, can be a double or a more complex object
  final List<T> values;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)

  /// Timestamps relative to the values, are always normalized to the CURRENT local time zone of the device
  final List<ZonedDateTime> timestamps;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)

  /// Lower bound of the confidence interval
  final List<T> confidenceIntervalLow;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)

  /// Upper bound of the confidence interval
  final List<T> confidenceIntervalHigh;

  @JsonKey(fromJson: _dataFromJson<double>, toJson: _dataToJson<double>)

  /// Confidence of the values
  final List<double> confidence;

  /// Constructor
  TimeSeries({
    required this.values,
    required this.timestamps,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.confidence,
  });

  /// Create a TimeSeries object from a json
  factory TimeSeries.fromJson(Map<String, dynamic> json) =>
      _$TimeSeriesFromJson<T>(json);

  /// Convert the TimeSeries object to a json
  Map<String, dynamic> toJson() {
    return _$TimeSeriesToJson<T>(this);
  }

  static T _dataFromJson<T>(dynamic json) {
    return _QATimeSeriesConverter<T>().fromJson(json);
  }

  static dynamic _dataToJson<T>(T object) {
    return _QATimeSeriesConverter<T>().toJson(object);
  }

  static List<String> _dateTimeToJson(List<ZonedDateTime> dateTime) =>
      dateTime.map((ZonedDateTime dateTime) => dateTime.toString()).toList();

  static List<ZonedDateTime> _dateTimeFromJson(List<dynamic> data) =>
      data.map<ZonedDateTime>((dynamic item) {
        // print(item);
        final List<String> split = (item as String).split('=');
        if (split.length == 1) {
          return ZonedDateTime.fromEpochMilliseconds(
              Timezone.now(), int.parse(item) * 1000);
        } else {
          if (split.length == 2) {
            final Timezone tz = Timezone(dumbTZMapper(split[1]));
            return ZonedDateTime.fromEpochMilliseconds(
                tz, int.parse(split[0]) * 1000);
          } else {
            final Timezone tz = Timezone(dumbTZMapper(split[1]));
            final ZonedDateTime a = ZonedDateTime.fromEpochMilliseconds(
                tz, int.parse(split[0]) * 1000);
            return a.truncate(to: DateUnit.days);
          }
        }
      }).toList();

  /// A naive timezone mapper
  static String dumbTZMapper(String tz) {
    switch (tz) {
      case 'GMT+0:00':
        return 'Etc/GMT';
      case 'GMT+1:00':
        return 'Europe/Gibraltar';
      case 'GMT+2:00':
        return 'Europe/Zurich';
      case 'GMT+3:00':
        return 'Europe/Moscow';
      case 'GMT+4:00':
        return 'Asia/Baku';
      case 'GMT+5:00':
        return 'Asia/Tashkent';
      case 'GMT+6:00':
        return 'Asia/Almaty';
      case 'GMT+7:00':
        return 'Asia/Bangkok';
      case 'GMT+8:00':
        return 'Asia/Shanghai';
      case 'GMT+9:00':
        return 'Asia/Tokyo';
      case 'GMT+10:00':
        return 'Australia/Brisbane';
      case 'GMT+11:00':
        return 'Pacific/Guadalcanal';
      case 'GMT+12:00':
        return 'Pacific/Fiji';
      case 'GMT-1:00':
        return 'Atlantic/Cape_Verde';
      case 'GMT-2:00':
        return 'Atlantic/South_Georgia';
      case 'GMT-3:00':
        return 'America/Argentina/Buenos_Aires';
      case 'GMT-4:00':
        return 'America/Caracas';
      case 'GMT-5:00':
        return 'America/Bogota';
      case 'GMT-6:00':
        return 'America/Chicago';
      case 'GMT-7:00':
        return 'America/Denver';
      case 'GMT-8:00':
        return 'America/Los_Angeles';
      case 'GMT-9:00':
        return 'America/Anchorage';
      case 'GMT-10:00':
        return 'Pacific/Honolulu';
      default:
        return tz;
    }
  }

  /// Empty constructor
  factory TimeSeries.empty() {
    return TimeSeries<T>(
      values: List<T>.empty(),
      timestamps: List<ZonedDateTime>.empty(),
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
            .map<double?>(
                (dynamic item) => item == null ? double.nan : checkDouble(item))
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

/// Use this function to fill missing days (the function adds NaNs) both in the future and in the
/// past (up to the specified number of days in the past). Since the SDK does not return a value
/// for the score in a day where the confidence it too low, this function can be useful to fill
/// in blanks for UI/UX purposes.
/// [timeSeries] the current [TimeSeries]
/// [rewindDays] how many days to fill in in the past
TimeSeries<double> fillMissingDays(
    TimeSeries<double> timeSeries, int rewindDays) {
  final List<ZonedDateTime> newTimestamps = <ZonedDateTime>[];
  final List<double> newValues = <double>[];
  final List<double> newConfidenceIntervalLow = <double>[];
  final List<double> newConfidenceIntervalHigh = <double>[];
  final List<double> newConfidence = <double>[];
  final ZonedDateTime currentDay = ZonedDateTime.now();
  // print('Current day is $currentDay [double]');
  // print('Last timestamp is ${timeSeries.timestamps.isNotEmpty ? timeSeries.timestamps[0] : currentDay}');
  ZonedDateTime prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].minus(days: rewindDays)
      : currentDay.minus(days: rewindDays);
  // print(prevDate);
  // print(timeSeries.timestamps.isEmpty);
  if (timeSeries.timestamps.isEmpty) {
    final int nMissingDays = currentDay.difference(prevDate).inDays - 1;
    // print('Nmising days: $nMissingDays');
    for (int j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(double.nan);
      newConfidenceIntervalLow.add(double.nan);
      newConfidenceIntervalHigh.add(double.nan);
      newConfidence.add(double.nan);
    }
  }
  // print(newTimestamps.length);

  for (int i = 0; i < timeSeries.values.length; i++) {
    final int nMissingDays =
        timeSeries.timestamps[i].difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
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
  final int nMissingFutureDays = newTimestamps.isNotEmpty
      ? currentDay.difference(newTimestamps.last).inDays
      : 0;
  final ZonedDateTime lastValue = newTimestamps.last;
  for (int j = 0; j < nMissingFutureDays; j++) {
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

/// Use this function to fill missing days (the function adds NaNs) both in the future and in the
/// past (up to the specified number of days in the past). Since the SDK does not return a value
/// for the score in a day where the confidence it too low, this function can be useful to fill
/// in blanks for UI/UX purposes.
/// [timeSeries] the current [TimeSeries]
/// [rewindDays] how many days to fill in in the past
TimeSeries<SleepSummary> fillMissingDaysSleepSummary(
    TimeSeries<SleepSummary> timeSeries, int rewindDays) {
  final List<ZonedDateTime> newTimestamps = <ZonedDateTime>[];
  final List<SleepSummary> newValues = <SleepSummary>[];
  final List<SleepSummary> newConfidenceIntervalLow = <SleepSummary>[];
  final List<SleepSummary> newConfidenceIntervalHigh = <SleepSummary>[];
  final List<double> newConfidence = <double>[];
  final ZonedDateTime currentDay = ZonedDateTime.now();
  // print('Current day is $currentDay [sleep summary]');
  // print('Last timestamp is ${timeSeries.timestamps.isNotEmpty ? timeSeries.timestamps[0] : currentDay}');
  ZonedDateTime prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].minus(days: rewindDays)
      : currentDay.minus(days: rewindDays);

  if (timeSeries.timestamps.isEmpty) {
    final int nMissingDays = currentDay.difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(SleepSummary.emptySummary());
      newConfidenceIntervalLow.add(SleepSummary.emptySummary());
      newConfidenceIntervalHigh.add(SleepSummary.emptySummary());
      newConfidence.add(double.nan);
    }
  }

  for (int i = 0; i < timeSeries.values.length; i++) {
    final int nMissingDays =
        timeSeries.timestamps[i].difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
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
  final int nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last.difference(currentDay).inDays
      : 0;
  final ZonedDateTime lastValue = newTimestamps.last;
  for (int j = 0; j < nMissingFutureDays; j++) {
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

/// Use this function to fill missing days (the function adds NaNs) both in the future and in the
/// past (up to the specified number of days in the past). Since the SDK does not return a value
/// for the score in a day where the confidence it too low, this function can be useful to fill
/// in blanks for UI/UX purposes.
/// [timeSeries] the current [TimeSeries]
/// [rewindDays] how many days to fill in in the past
TimeSeries<ScreenTimeAggregate> fillMissingDaysScreenTimeAggregate(
    TimeSeries<ScreenTimeAggregate> timeSeries, int rewindDays) {
  final List<ZonedDateTime> newTimestamps = <ZonedDateTime>[];
  final List<ScreenTimeAggregate> newValues = <ScreenTimeAggregate>[];
  final List<ScreenTimeAggregate> newConfidenceIntervalLow =
      <ScreenTimeAggregate>[];
  final List<ScreenTimeAggregate> newConfidenceIntervalHigh =
      <ScreenTimeAggregate>[];
  final List<double> newConfidence = <double>[];
  final ZonedDateTime currentDay = ZonedDateTime.now();
  // print('Current day is $currentDay [screen agg]');
  // print('Last timestamp is ${timeSeries.timestamps.isNotEmpty ? timeSeries.timestamps[0] : currentDay}');
  ZonedDateTime prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final int nMissingDays = currentDay.difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalLow.add(ScreenTimeAggregate.empty());
      newConfidenceIntervalHigh.add(ScreenTimeAggregate.empty());
      newConfidence.add(double.nan);
    }
  }

  for (int i = 0; i < timeSeries.values.length; i++) {
    final int nMissingDays =
        timeSeries.timestamps[i].difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
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
  final int nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last.difference(currentDay).inDays
      : 0;
  final ZonedDateTime lastValue = newTimestamps.last;
  for (int j = 0; j < nMissingFutureDays; j++) {
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

/// Use this function to fill missing days (the function adds NaNs) both in the future and in the
/// past (up to the specified number of days in the past). Since the SDK does not return a value
/// for the score in a day where the confidence it too low, this function can be useful to fill
/// in blanks for UI/UX purposes.
/// [timeSeries] the current [TimeSeries]
/// [rewindDays] how many days to fill in in the past
TimeSeries<TrendHolder> fillMissingDaysTrendHolder(
    TimeSeries<TrendHolder> timeSeries, int rewindDays) {
  final List<ZonedDateTime> newTimestamps = <ZonedDateTime>[];
  final List<TrendHolder> newValues = <TrendHolder>[];
  final List<TrendHolder> newConfidenceIntervalLow = <TrendHolder>[];
  final List<TrendHolder> newConfidenceIntervalHigh = <TrendHolder>[];
  final List<double> newConfidence = <double>[];
  final ZonedDateTime currentDay = ZonedDateTime.now();
  // print('Current day is $currentDay [trend holder]');
  // print('Last timestamp is ${timeSeries.timestamps.isNotEmpty ? timeSeries.timestamps[0] : currentDay}');
  ZonedDateTime prevDate = timeSeries.timestamps.isNotEmpty
      ? timeSeries.timestamps[0].subtract(Duration(days: rewindDays))
      : currentDay.subtract(Duration(days: rewindDays));

  if (timeSeries.timestamps.isEmpty) {
    final int nMissingDays = currentDay.difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
      newTimestamps.add(prevDate.add(Duration(days: j + 1)));
      newValues.add(TrendHolder.empty());
      newConfidenceIntervalLow.add(TrendHolder.empty());
      newConfidenceIntervalHigh.add(TrendHolder.empty());
      newConfidence.add(double.nan);
    }
  }

  for (int i = 0; i < timeSeries.values.length; i++) {
    final int nMissingDays =
        timeSeries.timestamps[i].difference(prevDate).inDays - 1;
    for (int j = 0; j < nMissingDays; j++) {
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
  final int nMissingFutureDays = newTimestamps.isNotEmpty
      ? newTimestamps.last.difference(currentDay).inDays
      : 0;
  final ZonedDateTime lastValue = newTimestamps.last;
  for (int j = 0; j < nMissingFutureDays; j++) {
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

/// an interface for the time series objects that allows to check if the object is nan
abstract class TimeSeriesObjectNan {
  /// check if the object is nan
  bool isNan();
}
