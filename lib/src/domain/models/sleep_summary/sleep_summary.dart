import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sugar/sugar.dart';

import '../time_series/date_time_extension.dart';

part 'sleep_summary.g.dart';
part 'sleep_summary_extension.dart';

@JsonSerializable()
class SleepSummary {
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final ZonedDateTime sleepStart;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final ZonedDateTime sleepEnd;
  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <ZonedDateTime>[],
  )
  final List<ZonedDateTime> interruptionsStart;
  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <ZonedDateTime>[],
  )
  final List<ZonedDateTime> interruptionsEnd;
  @JsonKey(defaultValue: <int>[])
  final List<int> interruptionsNumberOfTaps;

  @JsonKey(
    fromJson: _truncatedDateTimeFromJson,
    toJson: _dateTimeToJson,
  )

  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
  });

  factory SleepSummary.fromJson(Map<String, dynamic> json) => _$SleepSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SleepSummaryToJson(this);

  factory SleepSummary.emptySummary() {
    return SleepSummary(
      sleepStart: ZonedDateTime.now().nan,
      sleepEnd: ZonedDateTime.now().nan,
      interruptionsStart:
          List<ZonedDateTime>.generate(1, (int index) => ZonedDateTime.now().nan),
      interruptionsEnd:
          List<ZonedDateTime>.generate(1, (int index) => ZonedDateTime.now().nan),
      interruptionsNumberOfTaps: List<int>.generate(1, (int index) => 0)
    );
  }

  static List<String> _dateTimeListToJson(List<ZonedDateTime> dateTime) =>
      dateTime.map((ZonedDateTime dateTime) => dateTime.toString()).toList();

  static List<ZonedDateTime> _dateTimeListFromJson(List<dynamic> data) => data
      .map<ZonedDateTime>((dynamic item) {
    if (item == null) return ZonedDateTime.now().nan;
    // print(item);
    final List<String> split = (item as String).split('+');
    if (split.length == 1) {
      return ZonedDateTime.fromEpochMilliseconds(Timezone.now(), int.parse(item) * 1000);
    } else {
      final tz = Timezone(split[1]);
      return ZonedDateTime.fromEpochMilliseconds(tz, int.parse(split[0]) * 1000);
    }
      })
    .toList();

  static String _dateTimeToJson(ZonedDateTime dateTime) => dateTime.toString();

  static ZonedDateTime _dateTimeFromJson(String? data) {
    if (data == null) return ZonedDateTime.now().nan;
    // print(data);
    final List<String> split = (data as String).split('+');
    if (split.length == 1) {
      return ZonedDateTime.fromEpochMilliseconds(Timezone.now(), int.parse(data) * 1000);
    } else {
      final tz = Timezone(split[1]);
      return ZonedDateTime.fromEpochMilliseconds(tz, int.parse(split[0]) * 1000);
    }
  }
  static ZonedDateTime _truncatedDateTimeFromJson(String? data) {
    if (data == null) return ZonedDateTime.now().nan;
    // print(data);
    final List<String> split = (data as String).split('+');
    if (split.length == 1) {
      return ZonedDateTime.fromEpochMilliseconds(Timezone.now(), int.parse(data) * 1000);
    } else {
      final tz = Timezone(split[1]);
      return ZonedDateTime.fromEpochMilliseconds(tz, int.parse(split[0]) * 1000);
    }
  }
}
