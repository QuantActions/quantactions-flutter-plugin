import 'metric_type.dart';

enum Trend implements MetricType {
  sleepScore(id: 'sleep_trend'),
  cognitiveFitness(id: 'cognitive_trend'),
  socialEngagement(id: 'social_engagement_trend'),
  actionSpeed(id: 'action_trend'),
  typingSpeed(id: 'typing_trend'),
  sleepLength(id: 'sleep_length_trend'),
  sleepInterruptions(id: 'sleep_interruptions_trend'),
  socialScreenTime(id: 'social_screen_time_trend'),
  socialTaps(id: 'social_taps_trend'),
  theWave(id: 'the_wave_trend');

  @override
  final String id;

  const Trend({
    required this.id,
  });
}
