import 'package:core/core.dart';

class TrendHolderMapper {
  static TrendHolder fromJson(Map<String, dynamic> json) {
    return TrendHolder(
      difference2Weeks: json['difference2Weeks'] ?? double.nan,
      statistic2Weeks: json['statistic2Weeks'] ?? double.nan,
      significance2Weeks: json['significance2Weeks'] ?? double.nan,
      difference6Weeks: json['difference6Weeks'] ?? double.nan,
      statistic6Weeks: json['statistic6Weeks'] ?? double.nan,
      significance6Weeks: json['significance6Weeks'] ?? double.nan,
      difference1Year: json['difference1Year'] ?? double.nan,
      statistic1Year: json['statistic1Year'] ?? double.nan,
      significance1Year: json['significance1Year'] ?? double.nan,
    );
  }
}
