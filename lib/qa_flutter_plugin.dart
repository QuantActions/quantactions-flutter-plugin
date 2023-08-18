import 'package:qa_flutter_plugin/src/core/core.dart';
import 'package:qa_flutter_plugin/src/data/data.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

export 'package:qa_flutter_plugin/src/domain/models/models.dart';

class QAFlutterPlugin {
  late TrendRepository _trendRepository;
  late MetricRepository _metricRepository;

  QAFlutterPlugin() {
    dataDI.initDependencies();

    _trendRepository = appLocator.get<TrendRepository>();
    _metricRepository = appLocator.get<MetricRepository>();
  }

  Stream<TimeSeries<dynamic>> getTrend(Trend trend) {
    return _trendRepository.getByTrend(trend);
  }

  Stream<TimeSeries<dynamic>> getMetric(Metric metric) {
    return _metricRepository.getByMetric(metric);
  }
}
