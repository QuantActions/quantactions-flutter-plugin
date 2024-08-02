import 'package:charts/charts.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';

import 'metrics_bloc/metrics_bloc.dart';

class MyScaffold extends StatelessWidget {
  final targetPlatform = defaultTargetPlatform;
  final String? errorText;

  MyScaffold({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<MetricsBloc, MetricsState>(
        builder: (BuildContext content, MetricsState state) {
      return Scaffold(
        appBar: AppBar(
          title: const PoweredByQuantActions(),
        ),
        body: errorText != null
            ? Text(errorText!)
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RadioExample(
                      onChange: ({ChartMode mode = ChartMode.days}) {
                        BlocProvider.of<MetricsBloc>(context).add(
                          ChangeChartMode(mode),
                        );
                      },
                    ),
                    ColoredTitle(
                        title: 'Cognitive Fitness',
                        color: Metric.cognitiveFitness
                            .getPrimaryColor(colors: context.theme.colors)),
                    Indicator.big(
                      percentValue:
                          state.isScoreLoading[Metric.cognitiveFitness]!
                              ? 0
                              : MetricDetailsMapper.getIndicatorValue(
                            timeSeries: state.score(Metric.cognitiveFitness, state.chartMode),
                            chartMode: state.chartMode,
                          ),
                      metric: Metric.cognitiveFitness,
                      child: IndicatorData(
                          percent: state
                                  .isScoreLoading[Metric.cognitiveFitness]!
                              ? 0
                              : MetricDetailsMapper.getIndicatorValue(
                            timeSeries: state.score(Metric.cognitiveFitness, state.chartMode),
                            chartMode: state.chartMode,
                          )),
                    ),
                    // : const SizedBox.shrink(),
                    ScoreMetricCardTile(
                      isMetricScoreReady: true,
                      isDataLoading:
                          state.isScoreLoading[Metric.cognitiveFitness]!,
                      metricScoreReadyIn: 0,
                      metric: Metric.cognitiveFitness,
                      indicatorValue:
                          MetricCardsMapper.getCircleIndicatorValue(
                        state.doubleMetrics[Metric.socialEngagement]!,
                      ),
                      shortScoreValue: MetricCardsMapper.getScoreShortValue(
                        trendHolder: state.trends[Trend.cognitiveFitness],
                        metric: Metric.cognitiveFitness,
                        indicatorValue: MetricCardsMapper.getCircleIndicatorValue(
                          state.doubleMetrics[Metric.cognitiveFitness]!,
                        ),
                      ),
                      scoreChartData: state
                                  .doubleMetrics[Metric.cognitiveFitness]!
                                  .values
                                  .takeLast(8),
                    ),
                    const Divider(),
                    LinePlot.withUncertainty(
                      data: state
                          .score(
                              Metric.cognitiveFitness, state.chartMode)
                          .values,
                      timestamps: state
                          .score(
                              Metric.cognitiveFitness, state.chartMode)
                          .timestamps,
                      confidenceIntervalLow: state
                          .score(
                              Metric.cognitiveFitness, state.chartMode)
                          .confidenceIntervalLow,
                      confidenceIntervalHigh: state
                          .score(
                              Metric.cognitiveFitness, state.chartMode)
                          .confidenceIntervalHigh,
                      metric: Metric.cognitiveFitness,
                      chartMode: state.chartMode,
                      journal: const [],
                      populationRange: Metric
                          .cognitiveFitness.populationRange
                          .getPopulationRange(),
                    ),
                    ColoredTitle(
                        title: 'Screen Time',
                        color: Metric.socialEngagement
                            .getPrimaryColor(colors: context.theme.colors)),
                    CumulativeBarPlot(
                        totalData: state
                            .groupedScreenTimeAggregate(state.chartMode)
                            .values
                            .map((ScreenTimeAggregate element) =>
                                element.totalScreenTime)
                            .toList(),
                        data: state
                            .groupedScreenTimeAggregate(state.chartMode)
                            .values
                            .map((ScreenTimeAggregate element) =>
                                element.socialScreenTime)
                            .toList(),
                        timestamps: state
                            .groupedScreenTimeAggregate(state.chartMode)
                            .timestamps,
                        chartMode: state.chartMode,
                        scores: state.score(Metric.socialEngagement, state.chartMode).values,
                        journal: const [],
                        metric: Metric.screenTimeAggregate),
                    ColoredTitle(
                        title: 'Sleep Summary',
                        color: Metric.sleepScore
                            .getPrimaryColor(colors: context.theme.colors)),
                    InterruptedBarPlot(
                        timeSeries: GroupDataMapper
                            .groupTimeSeriesByChartMode<SleepSummary>(
                          chartMode: state.chartMode,
                          timeSeries: state.sleepSummary,
                        ),
                        scores: state.score(Metric.sleepScore, state.chartMode).values,
                        chartMode: state.chartMode,
                        metric: Metric.sleepScore),
                    ColoredTitle(
                        title: 'Action Time',
                        color: Metric.cognitiveFitness
                            .getPrimaryColor(colors: context.theme.colors)),
                    AdjustableBarPlot(
                      data: state
                          .groupedDoubleMetrics(
                              Metric.actionSpeed, state.chartMode)
                          .values,
                      timestamps: state
                          .groupedDoubleMetrics(
                              Metric.actionSpeed, state.chartMode)
                          .timestamps,
                      chartMode: state.chartMode,
                      scores: state.score(Metric.cognitiveFitness, state.chartMode).values,
                      metric: Metric.cognitiveFitness,
                      journal: const [],
                    ),
                    ColoredTitle(
                        title: 'Relations',
                        color: context.theme.colors.accent),
                    RelationsChart(scores:
                        [
                          state.score(Metric.cognitiveFitness, state.chartMode),
                          state.score(Metric.sleepScore, state.chartMode),
                          state.score(Metric.socialEngagement, state.chartMode),
                        ]
                        , chartMode: state.chartMode),
                    const Divider(height: 8)
                  ],
                ),
              ),
      );
    });
  }
}

class ColoredTitle extends StatelessWidget {
  final String title;
  final Color color;

  const ColoredTitle({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: context.theme.colors.textWhite,
                        )),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class RadioExample extends StatefulWidget {
  
  final Function({ChartMode mode}) onChange;
  
  const RadioExample({
    super.key,
    required this.onChange,
  });

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  ChartMode? _mode = ChartMode.days;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [

            Radio<ChartMode>(
              activeColor: Colors.black87,
              value: ChartMode.days,
              groupValue: _mode,
              onChanged: (ChartMode? value) {
                setState(() {
                  _mode = value;
                });
                widget.onChange(mode: value!);
              },
            ),
            const Text('14 Days'),
          ],
        ),
        Row(
          children: [
            Radio<ChartMode>(
              activeColor: Colors.black87,
              value: ChartMode.weeks,
              groupValue: _mode,
              onChanged: (ChartMode? value) {
                setState(() {
                  _mode = value;
                });
                widget.onChange(mode: value!);
              },
            ),
            const Text('6 weeks'),
          ],
        ),
        Row(
          children: [
            Radio<ChartMode>(
              activeColor: Colors.black87,
              value: ChartMode.months,
              groupValue: _mode,
              onChanged: (ChartMode? value) {
                setState(() {
                  _mode = value;
                });
                widget.onChange(mode: value!);
              },
            ),
            const Text('12 Months'),
          ],
        ),
      ],
    );
  }
}

class RelationsChart extends StatelessWidget {
  final List<TimeSeries<double>> scores;
  final ChartMode chartMode;

  const RelationsChart({
    super.key,
    required this.scores,
    required this.chartMode
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MultiLinePlot(
          journal: const [],
          colors: <Color>[
            context.theme.colors.fitnessPrimary,
            context.theme.colors.sleepPrimary,
            context.theme.colors.socialPrimary,
          ],
          titles: const ["Cognitive Fitness", "Sleep Quality", "Social Engagement"],
          data: scores.map((TimeSeries<double> e) => e.values).toList(),
          timestamps: scores.map((TimeSeries<double> e) => e.timestamps).toList(),
          confidenceIntervalHigh: scores.map((TimeSeries<double> e) => e.confidenceIntervalHigh).toList(),
          confidenceIntervalLow: scores.map((TimeSeries<double> e) => e.confidenceIntervalLow).toList(),
          chartMode: chartMode,
        ),
      ],
    );
  }
}
