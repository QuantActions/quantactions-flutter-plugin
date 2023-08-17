import '../models/metric_or_trend/trend.dart';
import '../models/time_series/time_series.dart';

abstract class TrendRepository {
  Stream<TimeSeries<dynamic>> getByTrend(Trend trend);
}
