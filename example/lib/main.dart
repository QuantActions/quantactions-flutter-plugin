import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String tempApiKey = "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9";
  final _qa = QAFlutterPlugin();
  late Stream<TimeSeries<dynamic>> _stream;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _stream,
                        builder: (_, AsyncSnapshot<TimeSeries<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.timestamps.length,
                              itemBuilder: (_, int index) {
                                final DateTime item = snapshot.data!.timestamps[index];
                                return Text(item.toString());
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
    _stream = _qa.getMetricSample(
      apiKey: tempApiKey,
      metric: Trend.theWave,
      interval: MetricInterval.day,
    );
  }
}
