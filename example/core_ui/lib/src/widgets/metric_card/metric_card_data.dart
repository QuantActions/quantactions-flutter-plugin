import 'package:flutter/cupertino.dart';
import 'package:dartx/dartx.dart';
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

import 'metric_summary_info.dart';
import 'score_waiting_info.dart';

class MetricCardData extends StatelessWidget {
  final bool isMetricScoreReady;
  final int metricETA;
  final int metricScoreReadyIn;

  final bool isDataLoading;
  final Metric metric;
  final Pair<String, String> shortMetricValue;

  const MetricCardData({super.key, 
    required this.isMetricScoreReady,
    required this.metricETA,
    required this.metricScoreReadyIn,
    required this.isDataLoading,
    required this.metric,
    required this.shortMetricValue,
  });

  @override
  Widget build(BuildContext context) {
    if (isMetricScoreReady) {
      return MetricSummaryInfo(
        isDataLoading: isDataLoading,
        metric: metric,
        shortMetricValue: shortMetricValue,
      );
    } else {
      return ScoreWaitingInfo(
        metricETA: metricETA,
        metricScoreReadyIn: metricScoreReadyIn,
      );
    }
  }
}
