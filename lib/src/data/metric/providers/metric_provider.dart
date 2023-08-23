import '../../../domain/domain.dart';

abstract class MetricProvider {
  Stream<dynamic> getMetricStream(Metric metric);
}
