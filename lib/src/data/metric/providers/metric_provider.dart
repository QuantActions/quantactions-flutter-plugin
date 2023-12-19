import '../../../domain/domain.dart';

abstract class MetricProvider {
  Stream<dynamic> getMetric({
    required MetricType metric,
    required MetricInterval interval,
  });

  Stream<dynamic> getMetricSample({
    required String apiKey,
    required MetricType metric,
    required MetricInterval interval,
  });

  Future<String?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  });
}
