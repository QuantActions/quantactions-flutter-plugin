import 'package:core_ui/core_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin_example/scaffold.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final String tempApiKey = dotenv.env['qa_sdk_api_key'] ?? '';

  // check the platform type

  final targetPlatform = defaultTargetPlatform;

  final _qa = QAFlutterPlugin();
  late Stream<TimeSeries<dynamic>> _cognitiveFitnessStream;
  late Stream<TimeSeries<dynamic>> _screenTimeStream;
  late Stream<TimeSeries<dynamic>> _sleepSummaryStream;
  late Stream<TimeSeries<dynamic>> _actionTimeStream;

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
      theme: lightTheme,
      darkTheme: darkTheme,
      builder: (context, child) {
        return Theme(
          data: context.theme,
          child: child!,
        );
      },
      home: MyScaffold(
        cognitiveFitnessStream: _cognitiveFitnessStream,
        screenTimeStream: _screenTimeStream,
        sleepSummaryStream: _sleepSummaryStream,
        actionTimeStream: _actionTimeStream,
        errorText: errorText,
      ),
    );
  }

  void _initDependencies() async {
    _cognitiveFitnessStream = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.cognitiveFitness,
      interval: MetricInterval.week,
    );

    _screenTimeStream = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.screenTimeAggregate,
      interval: MetricInterval.week,
    );

    _sleepSummaryStream = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.sleepSummary,
      interval: MetricInterval.week,
    );

    _actionTimeStream = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.actionSpeed,
      interval: MetricInterval.week,
    );
  }
}
