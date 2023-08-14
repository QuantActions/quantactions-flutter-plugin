import 'package:core/core.dart';
import 'qa_method_channel_impl.dart';

abstract class QAMethodChannel {
  static QAMethodChannel instance = QAMethodChannelImpl();

  Future<String?> getPlatformVersion();

  Stream<TimeSeries<dynamic>> getBy({
    required MetricOrTrend metricOrTrend,
  });

  Future<String?> someOtherMethod(Map<String, String> map);
}
