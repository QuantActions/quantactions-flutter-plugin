import 'dart:convert';

import 'package:core/core.dart';

import '../mappers/time_series/time_series_mapper.dart';

part 'qa_parser_helper.dart';

class QAParser {
  Stream<TimeSeries<dynamic>> parseStreamBy({
    required Stream<dynamic> stream,
    required MetricOrTrend metricOrTrend,
  }) {
    switch (metricOrTrend) {
      case Trend.sleepScore:
      case Trend.cognitiveFitness:
      case Trend.socialEngagement:
      case Trend.actionSpeed:
      case Trend.typingSpeed:
      case Trend.sleepLength:
      case Trend.sleepInterruptions:
      case Trend.socialScreenTime:
      case Trend.socialTaps:
      case Trend.theWave:
        return _QAParserImplHelper.getTheWave(stream);
      // case Metric.sleepScore:
      // case Metric.cognitiveFitness:
      // case Metric.socialEngagement:
      // case Metric.actionSpeed:
      // case Metric.typingSpeed:
      case Metric.sleepSummary:
        return _QAParserImplHelper.getSleepSummary(stream);
      case Metric.screenTimeAggregate:
        return _QAParserImplHelper.getScreenTimeAggregate(stream);
      // case Metric.socialTaps:
      default:
        return _QAParserImplHelper.getDefault(stream);
    }
  }
}
