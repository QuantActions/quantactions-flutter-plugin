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
    final Stream<dynamic> stream = _sdkMethodChannel.getMetricStream(metric);

    switch (metric) {
      case Metric.sleepSummary:
        return TimeSeriesStreamMapper.getSleepSummary(stream);
      case Metric.screenTimeAggregate:
        return TimeSeriesStreamMapper.getScreenTimeAggregate(stream);
      default:
        return TimeSeriesStreamMapper.getDouble(stream);
    }
  }
}
