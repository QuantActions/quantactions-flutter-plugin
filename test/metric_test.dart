import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final HashMap<MetricType, EventChannel> eventChannels =
      HashMap<MetricType, EventChannel>.fromIterables(
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (int index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    ),
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (int index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    )
        .map((MetricType metricType) => EventChannel('qa_flutter_plugin_stream/${metricType.id}'))
        .toList(),
  );

  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    eventChannels.forEach((MetricType key, EventChannel value) {
      binaryMessenger.setMockStreamHandler(value, MetricHandler());
    });
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'getMetricAsync' || 'getStatSampleAsync':
          return Future<String>(
            () => jsonEncode(
              TimeSeries<dynamic>(
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
    eventChannels.forEach((MetricType key, EventChannel value) {
      binaryMessenger.setMockStreamHandler(value, null);
    });
  });

  test('getMetric', () {
    eventChannels.forEach((MetricType key, EventChannel value) {
      expect(
        qaFlutterPlugin.getMetric(metric: key, interval: MetricInterval.month),
        const TypeMatcher<Stream<TimeSeries<dynamic>>>(),
      );
    });
  });

  test('getMetricSample', () {
    eventChannels.forEach((MetricType key, EventChannel value) {
      expect(
        qaFlutterPlugin.getMetricSample(apiKey: '', metric: key, interval: MetricInterval.month),
        const TypeMatcher<Stream<TimeSeries<dynamic>>>(),
      );
    });
  });

  test('getStatSampleAsync', () {
    eventChannels.forEach((MetricType key, EventChannel value) async {
      expect(
        await qaFlutterPlugin.getStatSampleAsync(apiKey: '', metric: key),
        const TypeMatcher<TimeSeries<dynamic>>(),
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

    if (arguments != null) {
      final Map<String, dynamic> params = arguments as Map<String, dynamic>;

      switch (params['method']) {
        case 'getMetric' || 'getMetricSample':
          expect(arguments['metric'], const TypeMatcher<String>());

          eventSink?.success(
            TimeSeries<dynamic>(
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
}
