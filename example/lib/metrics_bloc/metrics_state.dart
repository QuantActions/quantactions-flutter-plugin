part of 'metrics_bloc.dart';

class MetricsState extends Equatable {
  late final Map<Metric, TimeSeries<double>> doubleMetrics;
  final TimeSeries<SleepSummary> sleepSummary;
  final TimeSeries<ScreenTimeAggregate> screenTimeAggregate;
  final Map<Metric, bool> isScoreLoading;

  TimeSeries<double> groupedDoubleMetrics(Metric metric, ChartMode chartMode) {
    return GroupDataMapper.groupTimeSeriesByChartMode(
        timeSeries: doubleMetrics[metric]!, chartMode: chartMode);
  }

  TimeSeries<SleepSummary> groupedSleepSummary(ChartMode chartMode) {
    return GroupDataMapper.groupTimeSeriesByChartMode(
        timeSeries: sleepSummary, chartMode: chartMode);
  }

  TimeSeries<ScreenTimeAggregate> groupedScreenTimeAggregate(
      ChartMode chartMode) {
    return GroupDataMapper.groupTimeSeriesByChartMode(
        timeSeries: screenTimeAggregate, chartMode: chartMode);
  }

  late final Map<Trend, TrendHolder?> trends;
  final ChartMode chartMode;

  TimeSeries<double> score(Metric metric, ChartMode chartMode) {
    switch (metric) {
      case Metric.cognitiveFitness:
        return groupedDoubleMetrics(Metric.cognitiveFitness, chartMode);
      case Metric.sleepScore:
        return groupedDoubleMetrics(Metric.sleepScore, chartMode);
      case Metric.socialEngagement:
        return groupedDoubleMetrics(Metric.socialEngagement, chartMode);
      default:
        return TimeSeries<double>.empty();
    }
  }

  List<TimeSeries<double>> get scores => <TimeSeries<double>>[
        groupedDoubleMetrics(Metric.cognitiveFitness, chartMode),
        groupedDoubleMetrics(Metric.sleepScore, chartMode),
        groupedDoubleMetrics(Metric.socialEngagement, chartMode),
      ];

  MetricsState({
    required Map<Metric, TimeSeries<double>> initialMetrics,
    required Map<Trend, TrendHolder?> initialTrends,
    required this.sleepSummary,
    required this.screenTimeAggregate,
    required this.chartMode,
    this.isScoreLoading = const <Metric, bool>{
      Metric.cognitiveFitness: true,
      Metric.sleepScore: true,
      Metric.socialEngagement: true,
    },
  }) {
    doubleMetrics = <Metric, TimeSeries<double>>{
      Metric.cognitiveFitness:
          initialMetrics[Metric.cognitiveFitness] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
      Metric.sleepScore:
          initialMetrics[Metric.sleepScore] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
      Metric.socialEngagement:
          initialMetrics[Metric.socialEngagement] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
      Metric.actionSpeed:
          initialMetrics[Metric.actionSpeed] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
      Metric.typingSpeed:
          initialMetrics[Metric.typingSpeed] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
      Metric.socialTaps:
          initialMetrics[Metric.socialTaps] ?? fillMissingDays(TimeSeries<double>.empty(), 365),
    };

    trends = <Trend, TrendHolder?>{
      Trend.cognitiveFitness: initialTrends[Trend.cognitiveFitness],
      Trend.sleepScore: initialTrends[Trend.sleepScore],
      Trend.socialEngagement: initialTrends[Trend.socialEngagement],
      Trend.actionSpeed: initialTrends[Trend.actionSpeed],
      Trend.typingSpeed: initialTrends[Trend.typingSpeed],
      Trend.sleepLength: initialTrends[Trend.sleepLength],
      Trend.sleepInterruptions: initialTrends[Trend.sleepInterruptions],
      Trend.socialScreenTime: initialTrends[Trend.socialScreenTime],
      Trend.socialTaps: initialTrends[Trend.socialTaps],
    };
  }

  MetricsState copyWith({
    Map<Metric, TimeSeries<double>>? doubleMetrics,
    Map<Trend, TrendHolder?>? trends,
    TimeSeries<SleepSummary>? sleepSummary,
    TimeSeries<ScreenTimeAggregate>? screenTimeAggregate,
    ChartMode? chartMode,
    Map<Metric, bool>? isScoreLoading,
  }) {
    return MetricsState(
      initialMetrics: doubleMetrics ?? this.doubleMetrics,
      initialTrends: trends ?? this.trends,
      sleepSummary: sleepSummary ?? this.sleepSummary,
      screenTimeAggregate: screenTimeAggregate ?? this.screenTimeAggregate,
      chartMode: chartMode ?? this.chartMode,
      isScoreLoading: isScoreLoading ?? this.isScoreLoading,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        doubleMetrics,
        groupedDoubleMetrics,
        trends,
        chartMode,
        sleepSummary,
        screenTimeAggregate,
        isScoreLoading,
      ];
}
