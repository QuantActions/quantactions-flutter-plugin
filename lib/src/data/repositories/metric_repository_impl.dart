import 'package:qa_flutter_plugin/src/data/mappers/stream_mapper.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../providers/sdk_method_channel.dart';

class MetricRepositoryImpl implements MetricRepository {
  final SDKMethodChannel _sdkMethodChannel;

  MetricRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<TimeSeries<dynamic>> getByMetric(Metric metric) {
    switch (metric) {
      case Metric.actionSpeed:
      case Metric.cognitiveFitness:
      case Metric.sleepScore:
      case Metric.socialEngagement:
      case Metric.socialTaps:
      case Metric.typingSpeed:
      case Metric.sleepSummary:
        return StreamMapper.getSleepSummary(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.screenTimeAggregate:
        return StreamMapper.getScreenTimeAggregate(
          _sdkMethodChannel.getMetricStream(metric),
        );
      default:
        return StreamMapper.getDefault(
          _sdkMethodChannel.getMetricStream(metric),
        );
    }
  }
}
