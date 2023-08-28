import 'metric_type.dart';

enum Metric implements MetricType{
  sleepScore(id: 'sleep'),
  cognitiveFitness(id: 'cognitive'),
  socialEngagement(id: 'social'),
  actionSpeed(id: 'action'),
  typingSpeed(id: 'typing'),
  sleepSummary(id: 'sleep_summary'),
  screenTimeAggregate(id: 'screen_time_aggregate'),
  socialTaps(id: 'social_taps');

  const Metric({
    required this.id,
  });

  @override
  final String id;
}
