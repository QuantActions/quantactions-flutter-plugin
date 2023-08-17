import '../models/metric_or_trend/metric.dart';
import '../models/time_series/time_series.dart';

abstract class MetricRepository {
  Stream<TimeSeries<dynamic>> getByMetric(Metric metric);
}
