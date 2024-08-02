import 'package:charts/charts.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';
import 'package:quantactions_flutter_plugin_example/scaffold.dart';

import 'metrics_bloc/metrics_bloc.dart';

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
  final QAFlutterPlugin _qa = QAFlutterPlugin();

  final targetPlatform = defaultTargetPlatform;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    final MetricsBloc sharedBloc = MetricsBloc(
      apiKey: tempApiKey,
      qaFlutterPlugin: _qa,
      chartMode: ChartMode.days,
      initialMetrics: <Metric, TimeSeries<double>>{},
      initialTrends: <Trend, TrendHolder>{},
    );

    return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: (context, child) {
          return Theme(
            data: context.theme,
            child: child!,
          );
        },
        home: BlocProvider(
          create: (BuildContext context) => sharedBloc,
          child: MyScaffold(
            errorText: errorText,
          ),
        ));
  }
}
