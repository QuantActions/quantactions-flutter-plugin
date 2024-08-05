import 'package:json_annotation/json_annotation.dart';
import 'package:sugar/sugar.dart';

import '../time_series/date_time_extension.dart';

part 'sleep_summary.g.dart';
part 'sleep_summary_extension.dart';

/// This data class hold detailed information about a sleep session (or sleep episode).
/// See also [com.quantactions.sdk.Metric.SLEEP_SUMMARY] for a Time series of these episodes (generally one per day/night).
///
/// @property sleepStart zoned date time of the bed time
/// @property sleepEnd zoned date time of the wake up time
/// @property interruptionsStart list of zoned date times of the beginning on interruptions of the sleep episode
/// @property interruptionsEnd list of zoned date times of the end on interruptions of the sleep episode
/// @property interruptionsNumberOfTaps number of taps in each sleep interruption
@JsonSerializable()
class SleepSummary {
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )

  /// zoned date time of the bed time
  final ZonedDateTime sleepStart;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)

  /// zoned date time of the wake up time
  final ZonedDateTime sleepEnd;

  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <ZonedDateTime>[],
  )

  /// list of zoned date times of the beginning on interruptions of the sleep episode
  final List<ZonedDateTime> interruptionsStart;
  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <ZonedDateTime>[],
  )

  /// list of zoned date times of the end on interruptions of the sleep episode
  final List<ZonedDateTime> interruptionsEnd;

  @JsonKey(defaultValue: <int>[])

  /// number of taps in each sleep interruption
  final List<int> interruptionsNumberOfTaps;

  /// Constructor
  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
  });

  /// Create a [SleepSummary] from a json
  factory SleepSummary.fromJson(Map<String, dynamic> json) =>
      _$SleepSummaryFromJson(json);

  /// Convert the [SleepSummary] to a json
  Map<String, dynamic> toJson() => _$SleepSummaryToJson(this);

  /// Empty constructor
  factory SleepSummary.emptySummary() {
    return SleepSummary(
        sleepStart: ZonedDateTime.now().nan,
        sleepEnd: ZonedDateTime.now().nan,
        interruptionsStart: <ZonedDateTime>[],
        interruptionsEnd: <ZonedDateTime>[],
        interruptionsNumberOfTaps: <int>[]);
  }

  static List<String> _dateTimeListToJson(List<ZonedDateTime> dateTime) =>
      dateTime.map((ZonedDateTime dateTime) => dateTime.toString()).toList();

  static List<ZonedDateTime> _dateTimeListFromJson(List<dynamic> data) =>
      data.map<ZonedDateTime>((dynamic item) {
        if (item == null) return ZonedDateTime.now().nan;
        final List<String> split = (item as String).split('=');
        if (split.length == 1) {
          return ZonedDateTime.fromEpochMilliseconds(
              Timezone.now(), int.parse(item) * 1000);
        } else {
          final Timezone tz = Timezone(dumbTZMapper(split[1]));
          return ZonedDateTime.fromEpochMilliseconds(
              tz, int.parse(split[0]) * 1000);
        }
      }).toList();

  static String _dateTimeToJson(ZonedDateTime dateTime) => dateTime.toString();

  static ZonedDateTime _dateTimeFromJson(String? data) {
    if (data == null) return ZonedDateTime.now().nan;
    final List<String> split = data.split('=');
    if (split.length == 1) {
      return ZonedDateTime.fromEpochMilliseconds(
          Timezone.now(), int.parse(data) * 1000);
    } else {
      final Timezone tz = Timezone(dumbTZMapper(split[1]));
      return ZonedDateTime.fromEpochMilliseconds(
          tz, int.parse(split[0]) * 1000);
    }
  }
  // static ZonedDateTime _truncatedDateTimeFromJson(String? data) {
  //   if (data == null) return ZonedDateTime.now().nan;
  //   final List<String> split = data.split('=');
  //   if (split.length == 1) {
  //     return ZonedDateTime.fromEpochMilliseconds(Timezone.now(), int.parse(data) * 1000);
  //   } else {
  //     final Timezone tz = Timezone(dumbTZMapper(split[1]));
  //     return ZonedDateTime.fromEpochMilliseconds(tz, int.parse(split[0]) * 1000);
  //   }
  // }

  /// Naive timezone mapper
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
}
