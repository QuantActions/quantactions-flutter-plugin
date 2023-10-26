enum MetricInterval {
  day(id: 'day'),
  week(id: 'week'),
  month(id: 'month');

  const MetricInterval({
    required this.id,
  });

  final String id;
}
