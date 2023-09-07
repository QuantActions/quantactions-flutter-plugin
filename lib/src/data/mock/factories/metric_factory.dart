import '../../../domain/domain.dart';
import 'mock_model_factory.dart';
import 'screen_time_aggregate_factory.dart';
import 'sleep_summary_factory.dart';
import 'trend_holder_factory.dart';

class MetricFactory<T> extends MockModelFactory<TimeSeries<T>> {
  @override
  TimeSeries<T> generateFake() {
    return TimeSeries<T>(
      values: List<T>.generate(10, (int index) => generateData()),
      timestamps: List<DateTime>.generate(10, (int index) => generateDateTime),
      confidenceIntervalLow: List<T>.generate(10, (int index) => generateData()),
      confidenceIntervalHigh: List<T>.generate(10, (int index) => generateData()),
      confidence: List<double>.generate(10, (int index) => generateDouble),
    );
  }

  T generateData() {
    if (T == TrendHolder) {
      return TrendHolderFactory().generateFake() as T;
    } else if (T == SleepSummary) {
      return SleepSummaryFactory().generateFake() as T;
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
