import 'metric_type.dart';

enum Metric implements MetricType{
  sleepScore(id: 'sleep', code: '003-001-001-002', eta: 7),
  cognitiveFitness(id: 'cognitive', code: '003-001-001-003', eta: 4),
  socialEngagement(id: 'social', code: '003-001-001-004', eta: 2),
  actionSpeed(id: 'action', code: '001-003-003-002', eta: 5),
  typingSpeed(id: 'typing', code: '001-003-004-002', eta: 5),
  sleepSummary(id: 'sleep_summary', code: '001-002-006-004', eta: 7),
  screenTimeAggregate(id: 'screen_time_aggregate', code: '003-001-001-005', eta: 2),
  socialTaps(id: 'social_taps', code: '001-005-005-011', eta: 2);

  @override
  final String id;
  @override
  final String code;
  @override
  final int eta;

  const Metric({
    required this.id,
    required this.code,
    required this.eta,
  });
}
