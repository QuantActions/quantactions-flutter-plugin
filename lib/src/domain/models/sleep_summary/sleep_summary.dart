import 'package:json_annotation/json_annotation.dart';

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

  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
  });

  factory SleepSummary.fromJson(Map<String, dynamic> json) =>
      _$SleepSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SleepSummaryToJson(this);

  factory SleepSummary.emptySummary() {
    return SleepSummary(
      sleepStart: DateTime.fromMicrosecondsSinceEpoch(0),
      sleepEnd: DateTime.fromMicrosecondsSinceEpoch(0),
      interruptionsStart:
          List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
      interruptionsEnd:
          List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
      interruptionsNumberOfTaps: List.generate(1, (index) => 0),
    );
  }

  static List<String> _dateTimeListToJson(List<DateTime> dateTime) =>
      dateTime.map((e) => e.toString()).toList();

  static List<DateTime> _dateTimeListFromJson(List<dynamic> data) => data
      .map<DateTime>((e) => DateTime.parse((e).split('[').first).toLocal())
      .toList();

  static String _dateTimeToJson(DateTime dateTime) => dateTime.toString();

  static DateTime _dateTimeFromJson(String? data) {
    if (data == null) return DateTime.fromMicrosecondsSinceEpoch(0);

    return DateTime.parse((data).split('[').first).toLocal();
  }
}
