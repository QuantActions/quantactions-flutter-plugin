part of 'metrics_bloc.dart';

abstract class MetricsEvent {
  const MetricsEvent();
}

class ChangeChartMode extends MetricsEvent {
  final ChartMode chartMode;

  const ChangeChartMode(this.chartMode);
}

class ListenMetric extends MetricsEvent {
  final Metric metric;

  const ListenMetric({
    required this.metric,
  });
}

class ListenTrend extends MetricsEvent {
  final Trend trend;

  const ListenTrend({
    required this.trend,
  });
}





