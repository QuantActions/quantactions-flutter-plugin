import 'package:charts/charts.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';


class MyScaffold extends StatelessWidget {
  static final String tempApiKey = dotenv.env['qa_sdk_api_key'] ?? '';
  final Stream<TimeSeries<dynamic>> cognitiveFitnessStream;
  final Stream<TimeSeries<dynamic>> screenTimeStream;
  final Stream<TimeSeries<dynamic>> sleepSummaryStream;
  final Stream<TimeSeries<dynamic>> actionTimeStream;
  final targetPlatform = defaultTargetPlatform;
  final String? errorText;

  MyScaffold(
      {Key? key,
      required this.cognitiveFitnessStream,
      required this.screenTimeStream,
      required this.sleepSummaryStream,
      required this.actionTimeStream,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('QuantActions UI Guide'),
      ),
      body: errorText != null
          ? Text(errorText!)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PoweredByQuantActions(),
                  Container(
                    color: Metric.cognitiveFitness.getPrimaryColor(colors: context.theme.colors),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Cognitive Fitness',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: context.theme.colors.textWhite,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  StreamBuilder(
                    stream: cognitiveFitnessStream,
                    builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        final TimeSeries<double> timeSeries =
                            snapshot.data! as TimeSeries<double>;
                        final int scorePercent =
                            timeSeries.values.safeAverage().round();

                        final TimeSeries<double> groupedTimeSeries =
                            GroupDataMapper.groupTimeSeriesByChartMode(
                          chartMode: ChartMode.weeks,
                          timeSeries: timeSeries,
                        );
                        return Column(
                          children: [
                            Indicator.big(
                              percentValue: scorePercent,
                              metric: Metric.cognitiveFitness,
                              child: IndicatorData(percent: scorePercent),
                            ),
                            ScoreMetricCardTile(
                              isMetricScoreReady: true,
                              isDataLoading: false,
                              metricScoreReadyIn: 0,
                              metric: Metric.cognitiveFitness,
                              indicatorValue:
                                  snapshot.data!.values.last.round(),
                              shortScoreValue: Pair(
                                  '${snapshot.data!.values.last.round()}',
                                  '--'),
                              scoreChartData: snapshot.data!.values.takeLast(8)
                                  as List<double>,
                            ),
                            const Divider(),
                            LinePlot.withUncertainty(
                              data: groupedTimeSeries.values,
                              timestamps: groupedTimeSeries.timestamps,
                              confidenceIntervalLow:
                                  groupedTimeSeries.confidenceIntervalLow,
                              confidenceIntervalHigh:
                                  groupedTimeSeries.confidenceIntervalHigh,
                              metric: Metric.cognitiveFitness,
                              chartMode: ChartMode.weeks,
                              journal: const [],
                              populationRange: Metric
                                  .cognitiveFitness.populationRange
                                  .getPopulationRange(),
                            )
                          ],
                        );
                      } else {
                        return const ScoreMetricCardTile(
                          isMetricScoreReady: true,
                          isDataLoading: false,
                          metricScoreReadyIn: 3,
                          metric: Metric.cognitiveFitness,
                          indicatorValue: 0,
                          shortScoreValue: Pair('0', '--'),
                          scoreChartData: [],
                        );
                      }
                    },
                  ),
                  const Divider(),
                  Container(
                    color: Metric.socialEngagement.getPrimaryColor(colors: context.theme.colors),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Screen Time',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: context.theme.colors.textWhite,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  StreamBuilder(
                    stream: screenTimeStream,
                    builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        final TimeSeries<ScreenTimeAggregate> timeSeries =
                            snapshot.data! as TimeSeries<ScreenTimeAggregate>;
                        final groupedTimeSeries =
                            GroupDataMapper.groupTimeSeriesByChartMode(
                          chartMode: ChartMode.weeks,
                          timeSeries: timeSeries,
                        );
                        return CumulativeBarPlot(
                            totalData: groupedTimeSeries.values
                                .map((ScreenTimeAggregate element) =>
                                    element.totalScreenTime)
                                .toList(),
                            data: groupedTimeSeries.values
                                .map((ScreenTimeAggregate element) =>
                                    element.socialScreenTime)
                                .toList(),
                            timestamps: groupedTimeSeries.timestamps,
                            chartMode: ChartMode.weeks,
                            scores: const [],
                            journal: const [],
                            metric: Metric.screenTimeAggregate);
                      }

                      if (snapshot.hasError) {
                        return Text('error: ${snapshot.error.toString()}');
                      }

                      return Text('status: ${snapshot.connectionState.name}');
                    },
                  ),
                  const Divider(),
                  Container(
                    color: Metric.sleepScore.getPrimaryColor(colors: context.theme.colors),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Sleep Summary',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: context.theme.colors.textWhite,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  StreamBuilder(
                    stream: sleepSummaryStream,
                    builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        final TimeSeries<SleepSummary> timeSeries =
                            snapshot.data! as TimeSeries<SleepSummary>;
                        return InterruptedBarPlot(
                            timeSeries: GroupDataMapper
                                .groupTimeSeriesByChartMode<SleepSummary>(
                              chartMode: ChartMode.days,
                              timeSeries: timeSeries,
                            ),
                            scores: const [],
                            chartMode: ChartMode.days,
                            metric: Metric.sleepScore);
                      }

                      if (snapshot.hasError) {
                        return Text('error: ${snapshot.error.toString()}');
                      }

                      return Text('status: ${snapshot.connectionState.name}');
                    },
                  ),
                  const Divider(),
                  Container(
                    color: Metric.cognitiveFitness.getPrimaryColor(colors: context.theme.colors),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Action Time',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: context.theme.colors.textWhite,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  StreamBuilder(
                    stream: actionTimeStream,
                    builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        final TimeSeries<double> timeSeries =
                            snapshot.data! as TimeSeries<double>;
                        final groupedTimeSeries =
                            GroupDataMapper.groupTimeSeriesByChartMode(
                          chartMode: ChartMode.weeks,
                          timeSeries: timeSeries,
                        );
                        return AdjustableBarPlot(
                          data: groupedTimeSeries.values,
                          timestamps: groupedTimeSeries.timestamps,
                          chartMode: ChartMode.weeks,
                          scores: const [],
                          metric: Metric.cognitiveFitness,
                          journal: const [],
                        );
                      }

                      if (snapshot.hasError) {
                        return Text('error: ${snapshot.error.toString()}');
                      }

                      return Text('status: ${snapshot.connectionState.name}');
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
