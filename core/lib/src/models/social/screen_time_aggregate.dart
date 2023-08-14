part of models;

class ScreenTimeAggregate {
  final double totalScreenTime;
  final double socialScreenTime;

  ScreenTimeAggregate({
    required this.totalScreenTime,
    required this.socialScreenTime,
  });

  factory ScreenTimeAggregate.fromJson(Map<String, dynamic> json) {
    return ScreenTimeAggregate(
      totalScreenTime: json['totalScreenTime'] ?? double.nan,
      socialScreenTime: json['socialScreenTime'] ?? double.nan,
    );
  }
}
