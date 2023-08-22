import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _qa = QAFlutterPlugin();
  late HashMap<Metric, Stream<TimeSeries>> _metricStreams;
  late HashMap<Trend, Stream<TimeSeries>> _trendStreams;

  String? errorText;

  @override
  void initState() {
    super.initState();
    try {
      _initDependencies();
    } catch (e) {
      errorText = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: errorText != null
            ? Text(errorText!)
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('metrics'),
                    for (var stream in _metricStreams.entries)
                      StreamBuilder(
                        stream: stream.value,
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            TimeSeries data = snapshot.data;

                            return Text(
                                '${stream.key}: ${data.values.last} @ ${data.timestamps.last} & ${data.confidenceIntervalHigh.last}\n'
                                '${data.values.last.runtimeType}');
                          } else {
                            return const Text('No data');
                          }
                        },
                      ),
                    const Divider(),
                    const Text('trends'),
                    for (var stream in _trendStreams.entries)
                      StreamBuilder(
                        stream: stream.value,
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            TimeSeries data = snapshot.data;

                            return Text(
                                '${stream.key}: ${data.values.last} @ ${data.timestamps.last} & ${data.confidenceIntervalHigh.last}\n'
                                '${data.values.last.runtimeType}');
                          } else {
                            return const Text('No data');
                          }
                        },
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  void _initDependencies() {
    _metricStreams = HashMap<Metric, Stream<TimeSeries>>();
    _metricStreams[Metric.actionSpeed] = _qa.getMetric(Metric.actionSpeed);
    _metricStreams[Metric.cognitiveFitness] =
        _qa.getMetric(Metric.cognitiveFitness);
    _metricStreams[Metric.screenTimeAggregate] =
        _qa.getMetric(Metric.screenTimeAggregate);
    _metricStreams[Metric.sleepScore] = _qa.getMetric(Metric.sleepScore);
    _metricStreams[Metric.sleepSummary] = _qa.getMetric(Metric.sleepSummary);
    _metricStreams[Metric.socialEngagement] =
        _qa.getMetric(Metric.socialEngagement);
    _metricStreams[Metric.socialTaps] = _qa.getMetric(Metric.socialTaps);
    _metricStreams[Metric.typingSpeed] = _qa.getMetric(Metric.typingSpeed);

    _trendStreams = HashMap<Trend, Stream<TimeSeries>>();
    _trendStreams[Trend.typingSpeed] = _qa.getTrend(Trend.typingSpeed);
    _trendStreams[Trend.socialTaps] = _qa.getTrend(Trend.socialTaps);
    _trendStreams[Trend.socialEngagement] =
        _qa.getTrend(Trend.socialEngagement);
    _trendStreams[Trend.sleepScore] = _qa.getTrend(Trend.sleepScore);
    _trendStreams[Trend.cognitiveFitness] =
        _qa.getTrend(Trend.cognitiveFitness);
    _trendStreams[Trend.actionSpeed] = _qa.getTrend(Trend.actionSpeed);
    _trendStreams[Trend.sleepInterruptions] =
        _qa.getTrend(Trend.sleepInterruptions);
    _trendStreams[Trend.sleepLength] = _qa.getTrend(Trend.sleepLength);
    _trendStreams[Trend.socialScreenTime] =
        _qa.getTrend(Trend.socialScreenTime);
    _trendStreams[Trend.theWave] = _qa.getTrend(Trend.theWave);
  }
}
