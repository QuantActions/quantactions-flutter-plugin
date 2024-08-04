import '../../../../quantactions_flutter_plugin.dart';

enum Trend implements MetricType {
  sleepScore(id: 'sleep_trend', code: '003-003-001-004', eta: 0, populationRange: placeholder),
  cognitiveFitness(id: 'cognitive_trend', code: '003-003-002-004', eta: 0, populationRange: placeholder),
  socialEngagement(id: 'social_engagement_trend', code: '003-003-003-005', eta: 0, populationRange: placeholder),
  actionSpeed(id: 'action_trend', code: '003-003-002-001', eta: 0, populationRange: placeholder),
  typingSpeed(id: 'typing_trend', code: '003-003-002-003', eta: 0, populationRange: placeholder),
  sleepLength(id: 'sleep_length_trend', code: '003-003-001-001', eta: 0, populationRange: placeholder),
  sleepInterruptions(id: 'sleep_interruptions_trend', code: '003-003-001-003', eta: 0, populationRange: placeholder),
  socialScreenTime(id: 'social_screen_time_trend', code: '003-003-003-002', eta: 0, populationRange: placeholder),
  socialTaps(id: 'social_taps_trend', code: '003-003-003-004', eta: 0, populationRange: placeholder),
  theWave(id: 'the_wave_trend', code: '003-003-004-001', eta: 0, populationRange: placeholder);

  @override
  final String id;
  @override
  final String code;
  @override
  final int? eta;
  @override
  final PopulationRange? populationRange;

  const Trend({
    this.eta,
    required this.id,
    required this.code,
    this.populationRange,
  });
}
