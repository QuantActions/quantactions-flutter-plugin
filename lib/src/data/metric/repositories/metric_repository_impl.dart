import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/time_series/time_series_mapper.dart';
import '../../mappers/time_series/time_series_stream_mapper.dart';
import '../providers/metric_provider.dart';

class MetricRepositoryImpl implements MetricRepository {
  final MetricProvider _metricProvider;

  MetricRepositoryImpl({
    required MetricProvider metricProvider,
  }) : _metricProvider = metricProvider;

  @override
  Stream<TimeSeries> getMetric(MetricType metric) {
    return _mapStream(
      stream: _metricProvider.getMetric(metric),
      metric: metric,
    );
  }

  @override
  Future<TimeSeries?> getMetricAsync(MetricType metric) async {
    return _mapFuture(
      response: await _metricProvider.getMetricAsync(metric),
      metric: metric,
    );
  }

  @override
  Stream<TimeSeries> getMetricSample({
    required String apiKey,
    required MetricType metric,
  }) {
    return _mapStream(
      stream: _metricProvider.getMetricSample(
        apiKey: apiKey,
        metric: metric,
      ),
      metric: metric,
    );
  }

  @override
  Future<TimeSeries?> getStatSampleAsync({
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

  Stream<TimeSeries> _mapStream({
    required Stream stream,
    required MetricType metric,
  }) {
    if (metric is Trend) {
      return TimeSeriesStreamMapper.getTrendHolder(stream);
    }

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeriesStreamMapper.getSleepSummary(stream);
      case Metric.screenTimeAggregate:
        return TimeSeriesStreamMapper.getScreenTimeAggregate(stream);

      default:
        return TimeSeriesStreamMapper.getDouble(stream);
    }
  }

  TimeSeries<dynamic>? _mapFuture({
    required String? response,
    required MetricType metric,
  }) {
    if (response == null) return null;

    final json = jsonDecode(response);

    if (metric is Trend) {
      return TimeSeriesMapper.fromJsonTrendHolderTimeSeries(json);
    }

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeriesMapper.fromJsonSleepSummaryTimeSeries(json);
      case Metric.screenTimeAggregate:
        return TimeSeriesMapper.fromJsonScreenTimeAggregateTimeSeries(json);
      default:
        return TimeSeriesMapper.fromJsonDouble(json);
    }
  }
}
