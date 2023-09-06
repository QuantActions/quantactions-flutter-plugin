import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final eventChannels = HashMap<MetricType, EventChannel>.fromIterables(
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    ),
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    ).map((metricOrTrend) => EventChannel('qa_flutter_plugin_stream/${metricOrTrend.id}')).toList(),
  );
  const methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);
  final binaryMessenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    eventChannels.forEach((key, value) {
      binaryMessenger.setMockStreamHandler(value, MetricHandler());
    });
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'getMetricAsync' || 'getStatSampleAsync':
          return Future(
            () => jsonEncode(
              TimeSeries(
                values: <dynamic>[],
                timestamps: <DateTime>[],
                confidenceIntervalLow: <dynamic>[],
                confidenceIntervalHigh: <dynamic>[],
                confidence: <double>[],
              ),
            ),
          );
      }

      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, null);
    eventChannels.forEach((key, value) {
      binaryMessenger.setMockStreamHandler(value, null);
    });
  });

  test('getMetric', () {
    eventChannels.forEach((key, value) {
      expect(
        qaFlutterPlugin.getMetric(key),
        const TypeMatcher<Stream<TimeSeries>>(),
      );
    });
  });

  test('getMetricAsync', () {
    eventChannels.forEach((key, value) async {
      expect(
        await qaFlutterPlugin.getMetricAsync(key),
        const TypeMatcher<TimeSeries>(),
      );
    });
  });

  test('getMetricSample', () {
    eventChannels.forEach((key, value) {
      expect(
        qaFlutterPlugin.getMetricSample(apiKey: '', metric: key),
        const TypeMatcher<Stream<TimeSeries>>(),
      );
    });
  });

  test('getStatSampleAsync', () {
    eventChannels.forEach((key, value) async {
      expect(
        await qaFlutterPlugin.getStatSampleAsync(apiKey: '', metric: key),
        const TypeMatcher<TimeSeries>(),
      );
    });
  });
}

class MetricHandler implements MockStreamHandler {
  MockStreamHandlerEventSink? eventSink;

  @override
  void onCancel(Object? arguments) {
    eventSink = null;
  }

  @override
  void onListen(Object? arguments, MockStreamHandlerEventSink events) {
    eventSink = events;

    final params = arguments as Map<String, dynamic>;

    switch (params['method']) {
      case 'getMetric' || 'getMetricSample':
        expect(arguments['metric'], const TypeMatcher<String>());

        eventSink?.success(
          TimeSeries(
            values: <dynamic>[],
            timestamps: <DateTime>[],
            confidenceIntervalLow: <dynamic>[],
            confidenceIntervalHigh: <dynamic>[],
            confidence: <double>[],
          ),
        );
    }
  }
}
