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
  late HashMap<Metric, Stream<TimeSeries>> _streams;



  @override
  void initState() {
    super.initState();
    initPlatformState();
    _streams = HashMap<Metric, Stream<TimeSeries>>();
    _streams[Metric.socialEngagement] = _qa.getMetric(Metric.socialEngagement);
    _streams[Metric.sleepScore] = _qa.getMetric(Metric.sleepScore);
    _streams[Metric.cognitiveFitness] = _qa.getMetric(Metric.cognitiveFitness);
    // _streams[Metric.cognitiveFitness] = _qa.getMetric(Trend.cognitiveFitness);
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
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Passing args: $_passingArgs\n'),
              for (var stream in _streams.entries)
              StreamBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  TimeSeries data = snapshot.data;
                  return Text('${stream.key}: ${data.values.last} @ ${data.timestamps.last} & ${data.confidenceIntervalHigh.last}\n'
                      '${data.values.last.runtimeType}');
                } else {
                  return const Text('No data');
                }
              }, stream: stream.value),
            ],
          ),
        ),
      ),
    );
  }

  // sleepStreamBuilder(Bloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.sleepScoreStream,
  //     builder: (context, AsyncSnapshot<StatisticCore> snapshot) {
  //       if (snapshot.hasData) {
  //         StatisticCore? data = snapshot.data;
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //           Text('The stream: ${data?.data.last} @ ${data?.timestamps.last}\n'),
  //           ],
  //         );
  //       } else if (snapshot.hasError) {
  //         return Column(
  //           children: <Widget>[
  //             Image.network("http://megatron.co.il/en/wp-content/uploads/sites/2/2017/11/out-of-stock.jpg",
  //                 fit: BoxFit.fill),
  //             const Text(
  //               "Error!",
  //               style: TextStyle(
  //                 fontSize: 20.0,
  //               ),
  //             ),
  //           ],
  //         );
  //       }
  //       return const Text("No item in collect office");
  //     },
  //   );
  // }
}



