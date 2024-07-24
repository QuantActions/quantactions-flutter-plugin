import 'package:charts/charts.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/extensions/extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

import 'metric_card_data.dart';

class ScoreMetricCardTile extends StatelessWidget {
  final bool isMetricScoreReady;
  final bool isDataLoading;
  final int metricScoreReadyIn;
  final Metric metric;
  final int indicatorValue;
  final Pair<String, String>shortScoreValue;
  final List<double> scoreChartData;

  const ScoreMetricCardTile({
    super.key,
    required this.isMetricScoreReady,
    required this.isDataLoading,
    required this.metricScoreReadyIn,
    required this.metric,
    required this.indicatorValue,
    required this.shortScoreValue,
    required this.scoreChartData,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 167,
        child: AppCard(
          shouldBorder: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox.shrink(),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Center(
                      child: Indicator.small(
                        percentValue: indicatorValue,
                        metric: metric,
                        child: PreviewChart(
                          data: scoreChartData,
                          color: metric.getPrimaryColor(colors: context.theme.colors),
                          width: 85,
                          padding: 33,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(metric.displayName.toUpperCase(),
                          style: AppFonts.roboto16Normal,
                        ),
                        const SizedBox(height: 16),
                        MetricCardData(
                          isMetricScoreReady: isMetricScoreReady,
                          metricETA: metric.eta,
                          metricScoreReadyIn: metricScoreReadyIn,
                          isDataLoading: isDataLoading,
                          metric: metric,
                          shortMetricValue: shortScoreValue,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
