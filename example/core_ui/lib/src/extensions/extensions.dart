import 'package:sugar/sugar.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

extension GetMetricDisplayName on Metric {
  String get displayName {
    switch (this) {
      case Metric.cognitiveFitness:
        return 'Cognitive Fitness';
      case Metric.sleepScore:
        return 'Sleep Score';
      case Metric.socialEngagement:
        return 'Social Engagement';
      default:
        return 'Unknown';
    }
  }
}

extension ZonedDateTimeNaN on ZonedDateTime {
  ZonedDateTime get nan => ZonedDateTime.fromEpochMilliseconds(Timezone('UTC'), 0);
}
