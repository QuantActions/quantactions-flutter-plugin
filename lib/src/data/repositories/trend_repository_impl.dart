import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../mappers/time_series_stream_mapper.dart';
import '../providers/sdk_method_channel.dart';

class TrendRepositoryImpl implements TrendRepository {
  final SDKMethodChannel _sdkMethodChannel;

  TrendRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<TimeSeries<TrendHolder>> getByTrend(Trend trend) {
    return TimeSeriesStreamMapper.getTrendHolder(
      _sdkMethodChannel.getTrendStream(trend),
    );
  }
}
