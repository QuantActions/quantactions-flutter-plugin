import '../domain.dart';

/// Metric Repository
abstract class MetricRepository {
  /// Get metric stream for a given metric and interval.
  Stream<TimeSeries<dynamic>> getMetric({
    required MetricType metric,
    required MetricInterval interval,
    bool refresh,
  });

  /// Get metric sample (stream) for a given metric and interval, expect up-to-date
  Stream<TimeSeries<dynamic>> getMetricSample({
    required String apiKey,
    required MetricType metric,
    required MetricInterval interval,
  });

  /// Get metric sample (statically) for a given metric and interval, expect up-to-date
  Future<TimeSeries<dynamic>?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  });
}
