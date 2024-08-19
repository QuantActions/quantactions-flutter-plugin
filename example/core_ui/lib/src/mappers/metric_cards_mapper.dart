import 'package:charts/charts.dart';

import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

import 'metric_details_mapper.dart';
import 'package:dartx/dartx.dart';


class MetricCardsMapper {


  static int getCircleIndicatorValue(TimeSeries<double> timeSeries) {
    if (timeSeries.timestamps.isEmpty) {
      return 0;
    } else {
      return MetricDetailsMapper.getIndicatorValue(
        timeSeries: timeSeries,
        chartMode: ChartMode.days,
      );
    }
  }

  static Pair<String, String> getScoreShortValue({
    required TrendHolder? trendHolder,
    required Metric metric,
    required int indicatorValue,
  }) {

    final String scoreBucketValue = MetricDetailsMapper.getPercentStringValue(indicatorValue);
    String trendValue = '--';

    if (trendHolder == null || trendHolder.significance2Weeks.isNaN) {
      return Pair<String, String>(scoreBucketValue, trendValue);
    }

    final double dif = trendHolder.significance2Weeks;
    trendValue = dif > 0
        ? "Uptrend"
        : dif < 0
        ? "Downtrend"
        : "Stable";

    return Pair<String, String>(scoreBucketValue, trendValue);
  }

  static Pair<String, String> getAverageShortValue<T>({
    required TrendHolder? trendHolder,
    required TimeSeries<T> timeSeries,
    required Metric metric,
    required int indicatorValue,
  }) {

    // handle empty/null/nan cases

    String scoreBucket = 'n/A';
    String trendValue = '--';

    if (timeSeries.timestamps.isEmpty) {
      return Pair<String, String>(scoreBucket, trendValue);
    }

    if (T == SleepSummary) {
      final int valueInMilliseconds =
      MetricDetailsMapper.getAverageSleepDuration(
        timeSeries: timeSeries as TimeSeries<SleepSummary>,
        chartMode: ChartMode.days,
      );
      scoreBucket = DateTimeUtils.getHourAndMin(
        DateTimeUtils.fromMillisecondsSinceEpoch(valueInMilliseconds),
      );
    } else if (T == ScreenTimeAggregate) {
      final int valueInMilliseconds =
      MetricDetailsMapper.getAverageSocialScreenTime(
        timeSeries: timeSeries as TimeSeries<ScreenTimeAggregate>,
        chartMode: ChartMode.days,
      );
      scoreBucket = DateTimeUtils.getHourAndMin(
        DateTimeUtils.fromMillisecondsSinceEpoch(valueInMilliseconds),
      );
    } else {
      final int valueInMilliseconds = MetricDetailsMapper.getAverageDoubleValue(
        timeSeries: timeSeries as TimeSeries<double>,
        chartMode: ChartMode.days,
      );
      scoreBucket = '$valueInMilliseconds';
    }

    if (trendHolder == null || trendHolder.significance2Weeks.isNaN) {
      return Pair<String, String>(scoreBucket, trendValue);
    }

    final double dif = trendHolder.significance2Weeks;
    trendValue = dif > 0
        ? "Uptrend"
        : dif < 0
        ? "Downtrend"
        : "Stable";

    return Pair<String, String>(scoreBucket, trendValue);
  }


  static List<double> getSleepLengthListFromSleepSummaryList(
      List<SleepSummary> sleepSummaryList) {
    return sleepSummaryList.map((SleepSummary sleepSummary) {
      final int sleepStart = sleepSummary.sleepStart.epochMilliseconds;
      final int sleepEnd = sleepSummary.sleepEnd.epochMilliseconds;
      final int sleepLength = sleepEnd - sleepStart;
      if (sleepLength > 0) {
        return sleepLength.toDouble();
      } else {
        return double.nan;
      }
    }).toList();
  }

  static List<double> getScreenTimeListFromScreenTimeAggregateList(
    List<ScreenTimeAggregate> screenTimeAggregateList,
  ) {
    return screenTimeAggregateList
        .map((ScreenTimeAggregate screenTimeAggregate) =>
            screenTimeAggregate.socialScreenTime)
        .toList();
  }
}
