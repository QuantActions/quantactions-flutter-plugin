import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_text_patterns.dart';

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
  String _someStream = "No stream";
  final _qa = QA();

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
    final socialEngagementStream = _qa.getStat(Metric.socialEngagementScore);
    final sleepScoreStream = _qa.getStat(Metric.sleepScore);
    // final cognitiveFitnessStream = _qa.getStat(Metric.cognitiveFitness);

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
              StreamBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  StatisticCore data = snapshot.data;
                  return Text('The stream: ${data.data.last} @ ${data.timestamps.last}\n');
                } else {
                  return const Text('No data');
                }
              }, stream: socialEngagementStream),
              StreamBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  StatisticCore data = snapshot.data;
                  return Text('The stream: ${data.data.last} @ ${data.timestamps.last}\n');
                } else {
                  return const Text('No data');
                }
              }, stream: sleepScoreStream),
              // StreamBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //   if (snapshot.hasData) {
              //     StatisticCore data = snapshot.data;
              //     return Text('The stream: ${data.data.last} @ ${data.timestamps.last}\n');
              //   } else {
              //     return const Text('No data');
              //   }
              // }, stream: cognitiveFitnessStream),
            ],
          ),
        ),
      ),
    );
  }
}
