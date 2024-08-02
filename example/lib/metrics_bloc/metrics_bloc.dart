import 'dart:async';

import 'package:charts/charts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:equatable/equatable.dart';

part 'metrics_event.dart';

part 'metrics_state.dart';

class MetricsBloc extends Bloc<MetricsEvent, MetricsState> {
  final QAFlutterPlugin _qaFlutterPlugin;
  final String _apiKey;

  final Map<MetricType, bool> wasCalled = <MetricType, bool>{
    Metric.sleepScore: false,
    Trend.sleepScore: false,
    Metric.cognitiveFitness: false,
    Trend.cognitiveFitness: false,
    Metric.socialEngagement: false,
    Trend.socialEngagement: false,
    Metric.actionSpeed: false,
    Trend.actionSpeed: false,
    Metric.sleepSummary: false,
    Trend.sleepLength: false,
    Trend.sleepInterruptions: false,
    Metric.screenTimeAggregate: false,
    Trend.socialScreenTime: false,
    Metric.socialTaps: false,
    Trend.socialTaps: false,
    Metric.typingSpeed: false,
    Trend.typingSpeed: false,
  };

  final Map<MetricType, MetricType> nextInChain = <MetricType, MetricType>{
    Metric.cognitiveFitness: Metric.sleepScore,
    Metric.sleepScore: Metric.socialEngagement,
    Metric.socialEngagement: Metric.actionSpeed,
    Metric.actionSpeed: Metric.sleepSummary,
    Metric.sleepSummary: Metric.screenTimeAggregate,
    Metric.screenTimeAggregate: Metric.socialTaps,
    Metric.socialTaps: Metric.typingSpeed,
    Metric.typingSpeed: Trend.actionSpeed,
    Trend.actionSpeed: Trend.sleepLength,
    Trend.sleepLength: Trend.socialScreenTime,
    Trend.socialScreenTime: Trend.socialTaps,
    Trend.socialTaps: Trend.typingSpeed,
    Trend.typingSpeed: Trend.sleepInterruptions,
    Trend.sleepInterruptions: Trend.sleepScore,
    Trend.sleepScore: Trend.cognitiveFitness,
    Trend.cognitiveFitness: Trend.socialEngagement,
  };

  MetricsBloc({
    required QAFlutterPlugin qaFlutterPlugin,
    required String apiKey,
    required ChartMode chartMode,
    required Map<Metric, TimeSeries<double>> initialMetrics,
    required Map<Trend, TrendHolder> initialTrends,
  })  : _qaFlutterPlugin = qaFlutterPlugin,
        _apiKey = apiKey,
        super(
          MetricsState(
            initialMetrics: initialMetrics,
            initialTrends: initialTrends,
            sleepSummary: fillMissingDaysSleepSummary(TimeSeries<SleepSummary>.empty(), 365),
            screenTimeAggregate: fillMissingDaysScreenTimeAggregate(TimeSeries<ScreenTimeAggregate>.empty(), 365),
            chartMode: chartMode,
          ),
        ) {
    on<ListenMetric>(_listenMetric);
    on<ListenTrend>(_listenTrend);
    on<ChangeChartMode>(_changeChartMode);

    add(const ListenMetric(metric: Metric.cognitiveFitness));
  }

  Future<void> _changeChartMode(
      ChangeChartMode event, Emitter<MetricsState> emit) async {
    emit(state.copyWith(chartMode: event.chartMode));
  }

  Future<void> _listenTrend(
      ListenTrend event, Emitter<MetricsState> emit) async {
    await emit.forEach(
        _qaFlutterPlugin.getMetricSample(
            apiKey: _apiKey,
            metric: event.trend,
            interval: MetricInterval.month),
        onData: (TimeSeries<dynamic> timeSeries) {
      final TimeSeries<TrendHolder> trend =
          (timeSeries as TimeSeries<TrendHolder>).dropna();

      if (nextInChain[event.trend] != null &&
          wasCalled[nextInChain[event.trend]] == false) {
        wasCalled[nextInChain[event.trend]!] = true;
        // from a Trend I only chain trends
        add(ListenTrend(trend: nextInChain[event.trend]! as Trend));
      }

      if (trend.isNotEmpty()) {
        return state.copyWith(trends: <Trend, TrendHolder?>{
          ...state.trends,
          event.trend: trend.values.last,
        });
      } else {
        return state.copyWith(trends: <Trend, TrendHolder?>{
          ...state.trends,
          event.trend: TrendHolder.empty(),
        });
      }
    });
  }

  Future<void> _listenMetric(
      ListenMetric event, Emitter<MetricsState> emit) async {
    await emit.forEach(
        _qaFlutterPlugin.getMetricSample(
            apiKey: _apiKey,
            metric: event.metric,
            interval: MetricInterval.month),
        onData: (TimeSeries<dynamic> timeSeries) {
      if (<Metric>[
        Metric.cognitiveFitness,
        Metric.sleepScore,
        Metric.socialEngagement
      ].contains(event.metric)) {
        if ((timeSeries as TimeSeries<double>).isNotEmpty()) {
          emit(_setScoreReady(event.metric, timeSeries));
        }
      }

      if (nextInChain[event.metric] != null &&
          wasCalled[nextInChain[event.metric]] == false) {
        wasCalled[nextInChain[event.metric]!] = true;
        if (event.metric == Metric.typingSpeed) {
          add(ListenTrend(trend: nextInChain[event.metric]! as Trend));
        } else {
          add(ListenMetric(metric: nextInChain[event.metric]! as Metric));
        }
      }

      if (event.metric == Metric.sleepSummary) {
        return state.copyWith(
          sleepSummary: timeSeries as TimeSeries<SleepSummary>,
        );
      }
      if (event.metric == Metric.screenTimeAggregate) {
        return state.copyWith(
          screenTimeAggregate: timeSeries as TimeSeries<ScreenTimeAggregate>,
        );
      }

      return state.copyWith(
        doubleMetrics: <Metric, TimeSeries<double>>{
          ...state.doubleMetrics,
          event.metric: timeSeries as TimeSeries<double>,
        },
      );
    });
  }

  MetricsState _setScoreReady(Metric metric, TimeSeries<double> timeSeries) {
    return state.copyWith(isScoreLoading: <Metric, bool>{
      ...state.isScoreLoading,
      metric: false,
    }, doubleMetrics: <Metric, TimeSeries<double>>{
      ...state.doubleMetrics,
      metric: timeSeries,
    });
  }
}
