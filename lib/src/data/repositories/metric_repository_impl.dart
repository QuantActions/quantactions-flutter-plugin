import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../mappers/time_series_stream_mapper.dart';
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
        return TimeSeriesStreamMapper.getActionSpeed(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.cognitiveFitness:
        return TimeSeriesStreamMapper.getCognitiveFitness(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.sleepScore:
        return TimeSeriesStreamMapper.getScreenScope(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.socialEngagement:
        return TimeSeriesStreamMapper.getSocialEngagement(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.socialTaps:
        return TimeSeriesStreamMapper.getSocialTap(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.typingSpeed:
        return TimeSeriesStreamMapper.getTypingSpeed(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.sleepSummary:
        return TimeSeriesStreamMapper.getSleepSummary(
          _sdkMethodChannel.getMetricStream(metric),
        );
      case Metric.screenTimeAggregate:
        return TimeSeriesStreamMapper.getScreenTimeAggregate(
          _sdkMethodChannel.getMetricStream(metric),
        );
      default:
        return TimeSeriesStreamMapper.getDefault(
          _sdkMethodChannel.getMetricStream(metric),
        );
    }
  }
}
