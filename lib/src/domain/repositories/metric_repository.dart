import '../models/metric/metric_type.dart';
import '../models/time_series/time_series.dart';

abstract class MetricRepository {
  Stream<TimeSeries<dynamic>> getMetric(MetricType metric);

  Stream<TimeSeries<dynamic>> getMetricSample({
    required String apiKey,
    required MetricType metric,
  });

  Future<TimeSeries<dynamic>?> getMetricAsync(MetricType metric);

  Future<TimeSeries<dynamic>?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  });
}
