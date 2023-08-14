part of models;

enum Metric<T> implements MetricOrTrend<T> {
  sleepScore<double>(id: 'sleep'),
  cognitiveFitness<double>(id: 'cognitive'),
  socialEngagement<double>(id: 'social'),
  actionSpeed<double>(id: 'action'),
  typingSpeed<double>(id: 'typing'),
  sleepSummary<SleepSummary>(id: 'sleep_summary'),
  screenTimeAggregate<ScreenTimeAggregate>(id: 'screen_time_aggregate'),
  socialTaps<double>(id: 'social_taps');

  const Metric({
    required this.id,
  });

  @override
  final String id;
}
