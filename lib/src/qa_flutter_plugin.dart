import 'package:qa_method_channel/qa_method_channel.dart';

import '../qa_flutter_plugin.dart';

class QA {
  Future<String?> getPlatformVersion() {
    return QAMethodChannel.instance.getPlatformVersion();
  }

  Future<String?> someOtherMethod(Map<String, String> map) {
    return QAMethodChannel.instance.someOtherMethod(map);
  }

  Stream<TimeSeries<dynamic>> getMetric(MetricOrTrend metricOrTrend) {
    return QAMethodChannel.instance.getBy(metricOrTrend: metricOrTrend);
  }
}
