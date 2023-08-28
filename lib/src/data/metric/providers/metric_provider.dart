import '../../../domain/domain.dart';

abstract class MetricProvider {
  Stream<dynamic> getMetric(MetricType metric);

  Stream<dynamic> getMetricSample({
    required String apiKey,
    required MetricType metric,
  });

  Future<String?> getMetricAsync(MetricType metric);

  Future<String?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  });
}
