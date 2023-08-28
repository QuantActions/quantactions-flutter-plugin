import '../models/time_series/time_series.dart';

abstract class MetricRepository {
  Stream<TimeSeries<dynamic>> getMetric<T>(T metric);

  Stream<TimeSeries<dynamic>> getMetricSample<T>({
    required String apiKey,
    required T metric,
  });

  Future<TimeSeries<dynamic>> getMetricAsync<T>(T metric);

  Future<TimeSeries<dynamic>> getStatSampleAsync<T>({
    required String apiKey,
    required T metric,
  });
}
