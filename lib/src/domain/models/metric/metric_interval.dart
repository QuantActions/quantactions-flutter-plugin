enum MetricInterval {
  day(id: '2weeks'),
  week(id: '6weeks'),
  month(id: '12months');

  const MetricInterval({
    required this.id,
  });

  final String id;
}
