part of models;

enum Trend<T> implements MetricOrTrend<T> {
  sleepScore<TrendHolder>(id: 'sleep_trend'),
  cognitiveFitness<TrendHolder>(id: 'cognitive_trend'),
  socialEngagement<TrendHolder>(id: 'social_engagement_trend'),
  actionSpeed<TrendHolder>(id: 'action_trend'),
  typingSpeed<TrendHolder>(id: 'typing_trend'),
  sleepLength<TrendHolder>(id: 'sleep_length_trend'),
  sleepInterruptions<TrendHolder>(id: 'sleep_interruptions_trend'),
  socialScreenTime<TrendHolder>(id: 'social_screen_time_trend'),
  socialTaps<TrendHolder>(id: 'social_taps_trend'),
  theWave<TrendHolder>(id: 'the_wave_trend');

  const Trend({
    required this.id,
  });

  @override
  final String id;
}
