import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../mappers/stream_mapper.dart';
import '../providers/sdk_method_channel.dart';

class TrendRepositoryImpl implements TrendRepository {
  final SDKMethodChannel _sdkMethodChannel;

  TrendRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<TimeSeries<dynamic>> getByTrend(Trend trend) {
    switch (trend) {
      case Trend.typingSpeed:
      case Trend.socialTaps:
      case Trend.socialEngagement:
      case Trend.sleepScore:
      case Trend.cognitiveFitness:
      case Trend.actionSpeed:
      case Trend.theWave:
        return StreamMapper.getTheWave(
          _sdkMethodChannel.getTrendStream(trend),
        );
      case Trend.socialScreenTime:
      case Trend.sleepLength:
      case Trend.sleepInterruptions:
      default:
        return StreamMapper.getDefault(
          _sdkMethodChannel.getTrendStream(trend),
        );
    }
  }
}
