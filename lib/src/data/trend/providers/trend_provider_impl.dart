import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import 'trend_provider.dart';

class TrendProviderImpl implements TrendProvider {
  final SDKMethodChannel _sdkMethodChannel;

  TrendProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getTrendStream(Trend trend) {
    return _sdkMethodChannel.callTrendEventChannel(trend);
  }
}
