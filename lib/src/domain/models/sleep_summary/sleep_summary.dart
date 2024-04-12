import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../time_series/date_time_extension.dart';

part 'sleep_summary.g.dart';

@JsonSerializable()
class SleepSummary {
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime sleepStart;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime sleepEnd;
  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <DateTime>[],
  )
  final List<DateTime> interruptionsStart;
  @JsonKey(
    fromJson: _dateTimeListFromJson,
    toJson: _dateTimeListToJson,
    defaultValue: <DateTime>[],
  )
  final List<DateTime> interruptionsEnd;
  @JsonKey(defaultValue: <int>[])
  final List<int> interruptionsNumberOfTaps;

  @JsonKey(
    fromJson: _truncatedDateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime referenceDate;

  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
    required this.referenceDate,
  });

  factory SleepSummary.fromJson(Map<String, dynamic> json) => _$SleepSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SleepSummaryToJson(this);

  factory SleepSummary.emptySummary() {
    return SleepSummary(
      sleepStart: DateTime.now().nan,
      sleepEnd: DateTime.now().nan,
      interruptionsStart:
          List<DateTime>.generate(1, (int index) => DateTime.now().nan),
      interruptionsEnd:
          List<DateTime>.generate(1, (int index) => DateTime.now().nan),
      interruptionsNumberOfTaps: List<int>.generate(1, (int index) => 0),
      referenceDate: DateTime.now().nan,
    );
  }

  static List<String> _dateTimeListToJson(List<DateTime> dateTime) =>
      dateTime.map((DateTime dateTime) => dateTime.toString()).toList();

  static List<DateTime> _dateTimeListFromJson(List<dynamic> data) => data
      .map<DateTime>((dynamic item) {
      // print('Item is ${DateTime.parse((item as String).substring(0, 16))}');
      // return DateTime.parse((item as String).substring(0, 16));
      return DateTime.parse(item);
      })
    .toList();

  static String _dateTimeToJson(DateTime dateTime) => dateTime.toString();

  static DateTime _dateTimeFromJson(String? data) {
    if (data == null) return DateTime.now().nan;
    // print('Item is ${DateTime.parse((data as String).substring(0, 16))}');
    // return DateTime.parse((data as String).substring(0, 16));
    return DateTime.parse(data);
  }
  static DateTime _truncatedDateTimeFromJson(String? data) {
    if (data == null) return DateTime.now().nan;
    // print('Item is ${DateTime.parse((data as String).substring(0, 16))}');
    // return DateTime.parse((data as String).substring(0, 16));
    return DateTime.parse(data);
  }
}

// extension to sleep summary that check if is nan
extension SleepSummaryExtension on SleepSummary {
  bool isNan() {
    return sleepStart == DateTime.now().nan;
  }
}

