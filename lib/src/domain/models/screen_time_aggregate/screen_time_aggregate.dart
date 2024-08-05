import 'package:json_annotation/json_annotation.dart';

part 'screen_time_aggregate.g.dart';
part 'screen_time_aggregate_extension.dart';

/// This data class holds information about total and social screen time.
///
/// @property totalScreenTime total screen time in milliseconds.
/// @property socialScreenTime social screen time in milliseconds.
@JsonSerializable()
class ScreenTimeAggregate {
  @JsonKey(defaultValue: double.nan)

  /// total screen time in milliseconds.
  final double totalScreenTime;

  @JsonKey(defaultValue: double.nan)

  /// social screen time in milliseconds.
  final double socialScreenTime;

  /// Constructor
  ScreenTimeAggregate({
    required this.totalScreenTime,
    required this.socialScreenTime,
  });

  /// Create an empty [ScreenTimeAggregate]
  factory ScreenTimeAggregate.empty() {
    return ScreenTimeAggregate(
      totalScreenTime: double.nan,
      socialScreenTime: double.nan,
    );
  }

  /// Create a [ScreenTimeAggregate] from a json
  factory ScreenTimeAggregate.fromJson(Map<String, dynamic> json) =>
      _$ScreenTimeAggregateFromJson(json);

  /// Convert the [ScreenTimeAggregate] to a json
  Map<String, dynamic> toJson() => _$ScreenTimeAggregateToJson(this);
}
