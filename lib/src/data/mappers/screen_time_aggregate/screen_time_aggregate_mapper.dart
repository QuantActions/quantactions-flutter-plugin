import '../../../domain/domain.dart';

class ScreenTimeAggregateMapper {
  static ScreenTimeAggregate fromJson(Map<String, dynamic> json) {
    return ScreenTimeAggregate(
      totalScreenTime: json['totalScreenTime'] ?? double.nan,
      socialScreenTime: json['socialScreenTime'] ?? double.nan,
    );
  }
}
