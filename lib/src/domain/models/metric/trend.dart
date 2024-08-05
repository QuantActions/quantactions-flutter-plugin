import '../../../../quantactions_flutter_plugin.dart';

///  Enumeration class that holds all of the info for the trends relative to each metric
enum Trend implements MetricType {
  /// Trend for the sleep score
  sleepScore(
      id: 'sleep_trend',
      code: '003-003-001-004',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the cognitive fitness
  cognitiveFitness(
      id: 'cognitive_trend',
      code: '003-003-002-004',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the social engagement
  socialEngagement(
      id: 'social_engagement_trend',
      code: '003-003-003-005',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the action speed
  actionSpeed(
      id: 'action_trend',
      code: '003-003-002-001',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the typing speed
  typingSpeed(
      id: 'typing_trend',
      code: '003-003-002-003',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the sleep length
  sleepLength(
      id: 'sleep_length_trend',
      code: '003-003-001-001',
      eta: 0,
      populationRange: placeholder),

  /// Trend for the sleep interruptions
  sleepInterruptions(
      id: 'sleep_interruptions_trend',
      code: '003-003-001-003',
      eta: 0,
      populationRange: placeholder),

  /// Trend for social screen time
  socialScreenTime(
      id: 'social_screen_time_trend',
      code: '003-003-003-002',
      eta: 0,
      populationRange: placeholder),

  /// Trend for social taps
  socialTaps(
      id: 'social_taps_trend',
      code: '003-003-003-004',
      eta: 0,
      populationRange: placeholder),

  /// General trend tha considers sleep and cognitive fitness
  theWave(
      id: 'the_wave_trend',
      code: '003-003-004-001',
      eta: 0,
      populationRange: placeholder);

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
