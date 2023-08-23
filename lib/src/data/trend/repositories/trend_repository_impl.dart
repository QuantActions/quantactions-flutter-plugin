import 'package:qa_flutter_plugin/src/data/trend/providers/trend_provider.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../../mappers/time_series/time_series_stream_mapper.dart';

class TrendRepositoryImpl implements TrendRepository {
  final TrendProvider _trendProvider;

  TrendRepositoryImpl({
    required TrendProvider trendProvider,
  }) : _trendProvider = trendProvider;

  @override
  Stream<TimeSeries<TrendHolder>> getByTrend(Trend trend) {
    return TimeSeriesStreamMapper.getTrendHolder(
      _trendProvider.getTrendStream(trend),
    );
  }
}
