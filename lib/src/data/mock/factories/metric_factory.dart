import '../../../domain/domain.dart';
import 'mock_model_factory.dart';
import 'screen_time_aggregate_factory.dart';
import 'sleep_summary_factory.dart';
import 'trend_holder_factory.dart';

class MetricFactory<T> extends MockModelFactory<TimeSeries<T>> {
  @override
  TimeSeries<T> generateFake() {
    return TimeSeries(
      values: List.generate(10, (index) => generateData()),
      timestamps: List.generate(10, (index) => generateDateTime),
      confidenceIntervalLow: List.generate(10, (index) => generateData()),
      confidenceIntervalHigh: List.generate(10, (index) => generateData()),
      confidence: List.generate(10, (index) => generateDouble),
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
  List<TimeSeries<T>> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
