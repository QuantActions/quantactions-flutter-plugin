import 'package:json_annotation/json_annotation.dart';

part 'screen_time_aggregate.g.dart';

@JsonSerializable()
class ScreenTimeAggregate {
  @JsonKey(defaultValue: double.nan)
  final double totalScreenTime;
  @JsonKey(defaultValue: double.nan)
  final double socialScreenTime;

  ScreenTimeAggregate({
    required this.totalScreenTime,
    required this.socialScreenTime,
  });

  factory ScreenTimeAggregate.empty() {
    return ScreenTimeAggregate(
      totalScreenTime: 0.0,
      socialScreenTime: 0.0,
    );
  }

  factory ScreenTimeAggregate.fromJson(Map<String, dynamic> json) =>
      _$ScreenTimeAggregateFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenTimeAggregateToJson(this);
}
