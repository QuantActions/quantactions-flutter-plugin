import '../../../domain/domain.dart';
import '../../mappers/time_series/time_series_stream_mapper.dart';
import '../providers/metric_provider.dart';

class MetricRepositoryImpl implements MetricRepository {
  final MetricProvider _metricProvider;

  MetricRepositoryImpl({
    required MetricProvider metricProvider,
  }) : _metricProvider = metricProvider;

  @override
  Stream<TimeSeries<dynamic>> getByMetric(Metric metric) {
    final Stream<dynamic> stream = _metricProvider.getMetricStream(metric);

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeriesStreamMapper.getSleepSummary(stream);
      case Metric.screenTimeAggregate:
        return TimeSeriesStreamMapper.getScreenTimeAggregate(stream);
      default:
        return TimeSeriesStreamMapper.getDouble(stream);
    }
  }
}
