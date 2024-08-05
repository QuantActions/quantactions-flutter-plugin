/// Enum for metric interval, used to retrieval a certain backward time window
enum MetricInterval {
  /// 2 weeks
  day(id: '2weeks'),

  /// 6 weeks
  week(id: '6weeks'),

  /// 12 months
  month(id: '12months');

  const MetricInterval({
    required this.id,
  });

  /// Unique identifier for the interval
  final String id;
}
