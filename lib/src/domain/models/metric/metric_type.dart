abstract class MetricType {
  const MetricType({
    required this.id,
    required this.code,
    this.eta,
  });

  final String id;
  final String code;
  final int? eta;
}
