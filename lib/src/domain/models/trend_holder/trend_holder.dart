import 'package:json_annotation/json_annotation.dart';

part 'trend_holder.g.dart';

part 'trend_holder_extension.dart';

/// Thi object contains 9 values. For each time resolution (short: 2 Weeks, medium: 6 Weeks,
/// long: 1 Year) the trend has 3 values: (difference: value of the change, statistic: p-value,
/// significance: significance of the change)
@JsonSerializable()
class TrendHolder {
  @JsonKey(defaultValue: double.nan)

  /// the amount the metric has increased decrease (note: it is reported in the same unit as the metric)
  final double difference2Weeks;

  @JsonKey(defaultValue: double.nan)

  /// p-value of the test done to check if the trend is significant
  final double statistic2Weeks;

  @JsonKey(defaultValue: double.nan)

  /// the significance of the trend, +1 means metric has significantly increase, -1 means metric has significantly decreased, 0 means no significant change
  final double significance2Weeks;

  @JsonKey(defaultValue: double.nan)

  /// the amount the metric has increased decrease (note: it is reported in the same unit as the metric)
  final double difference6Weeks;

  @JsonKey(defaultValue: double.nan)

  /// p-value of the test done to check if the trend is significant
  final double statistic6Weeks;

  @JsonKey(defaultValue: double.nan)

  /// the significance of the trend, +1 means metric has significantly increase, -1 means metric has significantly decreased, 0 means no significant change
  final double significance6Weeks;

  @JsonKey(defaultValue: double.nan)

  /// the amount the metric has increased decrease (note: it is reported in the same unit as the metric)
  final double difference1Year;

  @JsonKey(defaultValue: double.nan)

  /// p-value of the test done to check if the trend is significant
  final double statistic1Year;

  @JsonKey(defaultValue: double.nan)

  /// the significance of the trend, +1 means metric has significantly increase, -1 means metric has significantly decreased, 0 means no significant change
  final double significance1Year;

  /// Constructor
  TrendHolder({
    required this.difference2Weeks,
    required this.statistic2Weeks,
    required this.significance2Weeks,
    required this.difference6Weeks,
    required this.statistic6Weeks,
    required this.significance6Weeks,
    required this.difference1Year,
    required this.statistic1Year,
    required this.significance1Year,
  });

  /// Empty constructor
  factory TrendHolder.empty() {
    return TrendHolder(
      difference2Weeks: double.nan,
      statistic2Weeks: double.nan,
      significance2Weeks: double.nan,
      difference6Weeks: double.nan,
      statistic6Weeks: double.nan,
      significance6Weeks: double.nan,
      difference1Year: double.nan,
      statistic1Year: double.nan,
      significance1Year: double.nan,
    );
  }

  /// Transform the object to a map
  factory TrendHolder.fromJson(Map<String, dynamic> json) =>
      _$TrendHolderFromJson(json);

  /// Transform the map to an object
  Map<String, dynamic> toJson() => _$TrendHolderToJson(this);
}
