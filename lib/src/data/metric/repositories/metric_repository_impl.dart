import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/time_series/time_series_mapper.dart';
import '../providers/metric_provider.dart';

class MetricRepositoryImpl implements MetricRepository {
  final MetricProvider _metricProvider;

  MetricRepositoryImpl({
    required MetricProvider metricProvider,
  }) : _metricProvider = metricProvider;

  @override
  Stream<TimeSeries<dynamic>> getMetric({
  required MetricType metric,
  required MetricInterval interval,
}) {
    return _mapStream(
      stream: _metricProvider.getMetric(
          metric: metric,
          interval: interval,
      ),
      metric: metric,
    );
  }

  @override
  Stream<TimeSeries<dynamic>> getMetricSample({
    required String apiKey,
    required MetricType metric,
    required MetricInterval interval,
  }) {
    return _mapStream(
      stream: _metricProvider.getMetricSample(
        apiKey: apiKey,
        metric: metric,
        interval: interval,
      ),
      metric: metric,
    );
  }

  @override
  Future<TimeSeries<dynamic>?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  }) async {
    return _mapFuture(
      response: await _metricProvider.getStatSampleAsync(
        apiKey: apiKey,
        metric: metric,
      ),
      metric: metric,
    );
  }

  Stream<TimeSeries<dynamic>> _mapStream({
    required Stream<dynamic> stream,
    required MetricType metric,
  }) {
    if (metric is Trend) {
      return TimeSeriesMapper.fromStream<TrendHolder>(stream);
    }

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeriesMapper.fromStream<SleepSummary>(stream);
      case Metric.screenTimeAggregate:
        return TimeSeriesMapper.fromStream<ScreenTimeAggregate>(stream);

      default:
        return TimeSeriesMapper.fromStream<double>(stream);
    }
  }

  TimeSeries<dynamic>? _mapFuture({
    required String? response,
    required MetricType metric,
  }) {
    if (response == null) return null;

    final dynamic json = jsonDecode(response);

    if (metric is Trend) {
      return TimeSeries<TrendHolder>.fromJson(json);
    }

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeries<SleepSummary>.fromJson(json);
      case Metric.screenTimeAggregate:
        return TimeSeries<ScreenTimeAggregate>.fromJson(json);
      default:
        return TimeSeries<double>.fromJson(json);
    }
  }
}
