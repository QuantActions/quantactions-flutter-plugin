part of models;

class TrendHolder {
  final double difference2Weeks;
  final double statistic2Weeks;
  final double significance2Weeks;
  final double difference6Weeks;
  final double statistic6Weeks;
  final double significance6Weeks;
  final double difference1Year;
  final double statistic1Year;
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
}