import 'package:json_annotation/json_annotation.dart';

part 'trend_holder.g.dart';

@JsonSerializable()
class TrendHolder {
  @JsonKey(defaultValue: double.nan)
  final double difference2Weeks;
  @JsonKey(defaultValue: double.nan)
  final double statistic2Weeks;
  @JsonKey(defaultValue: double.nan)
  final double significance2Weeks;
  @JsonKey(defaultValue: double.nan)
  final double difference6Weeks;
  @JsonKey(defaultValue: double.nan)
  final double statistic6Weeks;
  @JsonKey(defaultValue: double.nan)
  final double significance6Weeks;
  @JsonKey(defaultValue: double.nan)
  final double difference1Year;
  @JsonKey(defaultValue: double.nan)
  final double statistic1Year;
  @JsonKey(defaultValue: double.nan)
  final double significance1Year;

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

  factory TrendHolder.fromJson(Map<String, dynamic> json) =>
      _$TrendHolderFromJson(json);

  Map<String, dynamic> toJson() => _$TrendHolderToJson(this);
}
