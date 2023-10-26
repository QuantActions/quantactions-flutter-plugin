import '../domain.dart';

abstract class MetricRepository {
  Stream<TimeSeries<dynamic>> getMetric({
    required MetricType metric,
    required MetricInterval interval,
  });

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
