import '../../../domain/domain.dart';

/// Metric Provider
abstract class MetricProvider {
  /// Get metric stream for a given metric and interval.
  Stream<dynamic> getMetric({
    required MetricType metric,
    required MetricInterval interval,
  });

  /// Get metric sample (stream) for a given metric and interval, expect up-to-date
  /// (up to today) data.
  Stream<dynamic> getMetricSample({
    required String apiKey,
    required MetricType metric,
    required MetricInterval interval,
  });

  /// Get metric sample (statically) for a given metric and interval, expect up-to-date
  /// (up to today) data.
  Future<String?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  });
}
