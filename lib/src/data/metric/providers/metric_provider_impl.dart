import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import 'metric_provider.dart';

class MetricProviderImpl implements MetricProvider {
  final SDKMethodChannel _sdkMethodChannel;

  MetricProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getMetricStream(Metric metric) {
    return _sdkMethodChannel.callMetricEventChannel(metric);
  }
}
