import 'package:core/core.dart';
import 'package:qa_parser/qa_parser.dart';

import 'qa_method_channel.dart';
import '../qa_flutter_plugin/qa_flutter_plugin_platform.dart';

class QAMethodChannelImpl implements QAMethodChannel {
  final QAFlutterPluginPlatform qaFlutterPluginPlatform =
      QAFlutterPluginPlatform.instance;

  @override
  Future<String?> getPlatformVersion() {
    return qaFlutterPluginPlatform.getPlatformVersion();
  }

  @override
  Future<String?> someOtherMethod(Map<String, String> map) {
    return QAFlutterPluginPlatform.instance.someOtherMethod(map);
  }

  @override
  Stream<TimeSeries<dynamic>> getBy({
    required MetricOrTrend metricOrTrend,
  }) {
    final Stream<dynamic> stream = qaFlutterPluginPlatform.getStreamBy(
      metricOrTrend: metricOrTrend,
    );

    return QAParser().parseStreamBy(
      stream: stream,
      metricOrTrend: metricOrTrend,
    );
  }
}
