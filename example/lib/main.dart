import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
  String _platformVersion = 'Unknown';
  String _passingArgs = "No args passed";
  final _qa = QA();
  late HashMap<MetricOrTrend, Stream<TimeSeries>> _streams;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _streams = HashMap<MetricOrTrend, Stream<TimeSeries>>();
    _streams[Metric.sleepScore] = _qa.getMetric(Metric.sleepScore);
    _streams[Metric.cognitiveFitness] = _qa.getMetric(Metric.cognitiveFitness);
    _streams[Metric.socialEngagement] = _qa.getMetric(Metric.socialEngagement);
    _streams[Trend.actionSpeed] = _qa.getMetric(Trend.actionSpeed);
    _streams[Metric.typingSpeed] = _qa.getMetric(Metric.typingSpeed);
    _streams[Metric.sleepSummary] = _qa.getMetric(Metric.sleepSummary);
    _streams[Metric.screenTimeAggregate] =
        _qa.getMetric(Metric.screenTimeAggregate);
    _streams[Metric.socialTaps] = _qa.getMetric(Metric.socialTaps);

    _streams[Trend.sleepScore] = _qa.getMetric(Trend.sleepScore);
    _streams[Trend.cognitiveFitness] = _qa.getMetric(Trend.cognitiveFitness);
    _streams[Trend.socialEngagement] = _qa.getMetric(Trend.socialEngagement);
    _streams[Trend.actionSpeed] = _qa.getMetric(Trend.actionSpeed);
    _streams[Trend.typingSpeed] = _qa.getMetric(Trend.typingSpeed);
    _streams[Trend.sleepLength] = _qa.getMetric(Trend.sleepLength);
    _streams[Trend.sleepInterruptions] =
        _qa.getMetric(Trend.sleepInterruptions);
    _streams[Trend.socialScreenTime] = _qa.getMetric(Trend.socialScreenTime);
    _streams[Trend.socialTaps] = _qa.getMetric(Trend.socialTaps);
    _streams[Trend.theWave] = _qa.getMetric(Trend.theWave);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String passingArgs;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _qa.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      passingArgs =
          await _qa.someOtherMethod({'test': 'hello'}) ?? 'Unknown args';
    } on PlatformException {
      passingArgs = 'Failed to get passing args.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _passingArgs = passingArgs;
    });
  }

  @override
  Widget build(BuildContext context) {
    // now we listen to the event channel

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text('Running on: $_platformVersion\n'),
                Text('Passing args: $_passingArgs\n'),
                for (var stream in _streams.entries)
                  StreamBuilder(
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        TimeSeries data = snapshot.data;

                        return Text(
                          '${stream.key}: ${data.values.last} @ ${data.timestamps.last} & ${data.confidenceIntervalHigh.last}\n'
                          '${data.values.last.runtimeType}\n\n',
                        );
                      } else {
                        return const Text('No data');
                      }
                    },
                    stream: stream.value,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
