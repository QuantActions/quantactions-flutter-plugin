import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

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
  late Stream<TimeSeries<dynamic>> _stream1;
  late Stream<TimeSeries<dynamic>> _stream2;
  late Stream<TimeSeries<dynamic>> _stream3;

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
          title: const Text('QuantActions Plugin Example'),
        ),
        body: errorText != null
            ? Text(errorText!)
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    targetPlatform == TargetPlatform.android
                        ? const Text('Platform: Android')
                        : targetPlatform == TargetPlatform.iOS
                            ? const Text('Platform: iOS')
                            : const Text('Platform: Web'),

                    Text('Cognitive Fitness:', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _stream1,
                        builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.timestamps.length,
                              itemBuilder: (_, int index) {
                                // final DateTime item = snapshot.data!.timestamps[index];
                                final double item = snapshot.data!.values[index];
                                final date = snapshot.data!.timestamps[index].toString();
                                return Text('$date: $item');
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return Text('error: ${snapshot.error.toString()}');
                          }

                          return Text('status: ${snapshot.connectionState.name}');
                        },
                      ),
                    ),
                    Text('Screen Time:', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _stream2,
                        builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.timestamps.length,
                              itemBuilder: (_, int index) {
                                // final DateTime item = snapshot.data!.timestamps[index];
                                final ScreenTimeAggregate item = snapshot.data!.values[index];
                                final timeInMinutes = item.totalScreenTime / 1000 / 60;
                                final date = snapshot.data!.timestamps[index].toString();
                                return Text('$date: ${timeInMinutes} minutes');
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return Text('error: ${snapshot.error.toString()}');
                          }

                          return Text('status: ${snapshot.connectionState.name}');
                        },
                      ),
                    ),
                    Text('Sleep Summary:', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _stream3,
                        builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.timestamps.length,
                              itemBuilder: (_, int index) {
                                // final DateTime item = snapshot.data!.timestamps[index];
                                final SleepSummary item = snapshot.data!.values[index];
                                return Text('Sleep start: ${item.sleepStart}');
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return Text('error: ${snapshot.error.toString()}');
                          }

                          return Text('status: ${snapshot.connectionState.name}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _initDependencies() async {

    _stream1 = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.cognitiveFitness,
      interval: MetricInterval.day,
    );

    _stream2 = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.screenTimeAggregate,
      interval: MetricInterval.day,
    );

    _stream3 = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Metric.sleepSummary,
      interval: MetricInterval.day,
    );

  }
}
