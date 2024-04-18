import 'dart:math';

import 'package:sugar/sugar.dart';

import '../../../domain/domain.dart';
import 'mock_model_factory.dart';
import 'screen_time_aggregate_factory.dart';
import 'sleep_summary_factory.dart';
import 'trend_holder_factory.dart';

class MetricFactory<T> extends MockModelFactory<TimeSeries<T>> {
  @override
  TimeSeries<T> generateFake([dynamic data]) {
    final DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final List<T> values = List<T>.generate(
      365,
      (int index) => generateData(now.subtract(Duration(days: index))),
    ).reversed.toList();

    return TimeSeries<T>(
      values: values,
      timestamps: List<ZonedDateTime>.generate(365, (int index) => ZonedDateTime.now().subtract(Duration(days: index)))
          .reversed
          .toList(),
      confidenceIntervalLow: (T == double)
          ? values.map((T e) => (e as double) - Random().nextInt(10)).cast<T>().toList()
          : values,
      confidenceIntervalHigh: (T == double)
          ? values.map((T e) => (e as double) + Random().nextInt(10)).cast<T>().toList()
          : values,
      confidence: List<double>.generate(365, (int index) => generateDouble),
    );
  }

  T generateData(DateTime dateTime) {
    if (T == TrendHolder) {
      return TrendHolderFactory().generateFake() as T;
    } else if (T == SleepSummary) {
      return SleepSummaryFactory().generateFake(dateTime) as T;
    } else if (T == ScreenTimeAggregate) {
      return ScreenTimeAggregateFactory().generateFake() as T;
    } else {
      return generateDouble as T;
    }
  }

  @override
  List<TimeSeries<T>> generateListFake({required int length}) {
    return List<TimeSeries<T>>.generate(length, (int index) => generateFake());
  }
}
