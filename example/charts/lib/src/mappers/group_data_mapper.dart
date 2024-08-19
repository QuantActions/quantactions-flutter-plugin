import 'package:charts/charts.dart';
import 'package:charts/src/utils/date_time_utils.dart';
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

class GroupDataMapper {

  static TimeSeries<T> returnLinearListByChartMode<T>({
    required ChartMode chartMode,
    required TimeSeries<T> timeSeries,
  }) {
    switch (chartMode){
      case ChartMode.days:
        return timeSeries.takeLast(14);
      case ChartMode.weeks:
        return timeSeries.takeLast(6 * 7);
     case ChartMode.months:
        return timeSeries.takeLast(365);
    }
  }

  static TimeSeries<T> groupTimeSeriesByChartMode<T>({
    required ChartMode chartMode,
    required TimeSeries<T> timeSeries,
  }) {
    switch (chartMode) {
      case ChartMode.days:
        return timeSeries.takeLast(14);
      case ChartMode.weeks:
        if (T == SleepSummary) {
          return _groupSleepSummary(
            timeSeries: timeSeries as TimeSeries<SleepSummary>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.weekNumber() == date.weekNumber() && currentDate.year == date.year;
            },
          ) as TimeSeries<T>;
        } else if (T == ScreenTimeAggregate) {
          return _groupScreenTimeAggregate(
            timeSeries: timeSeries as TimeSeries<ScreenTimeAggregate>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.weekNumber() == date.weekNumber() && currentDate.year == date.year;
            },
          ) as TimeSeries<T>;
        } else {
          return _groupDouble(
            timeSeries: timeSeries as TimeSeries<double>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.weekNumber() == date.weekNumber();
            },
          ) as TimeSeries<T>;
        }
      case ChartMode.months:
        if (T == SleepSummary) {
          return _groupSleepSummary(
            timeSeries: timeSeries as TimeSeries<SleepSummary>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.year == date.year && currentDate.month == date.month;
            },
          ) as TimeSeries<T>;
        } else if (T == ScreenTimeAggregate) {
          return _groupScreenTimeAggregate(
            timeSeries: timeSeries as TimeSeries<ScreenTimeAggregate>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.year == date.year && currentDate.month == date.month;
            },
          ) as TimeSeries<T>;
        } else {
          return _groupDouble(
            timeSeries: timeSeries as TimeSeries<double>,
            chartMode: chartMode,
            condition: ({required DateTime date, required DateTime currentDate}) {
              return currentDate.year == date.year && currentDate.month == date.month;
            },
          ) as TimeSeries<T>;
        }
    }
  }

  static TimeSeries<double> _groupDouble({
    required TimeSeries<double> timeSeries,
    required bool Function({
      required DateTime date,
      required DateTime currentDate,
    }) condition,
    required ChartMode chartMode,
  }) {
    if (chartMode == ChartMode.weeks) {
      return timeSeries.extractWeeklyAverages().takeLast(chartMode.length);
    } else {
      return timeSeries.extractMonthlyAverages().takeLast(chartMode.length);
    }
  }

  static TimeSeries<ScreenTimeAggregate> _groupScreenTimeAggregate({
    required TimeSeries<ScreenTimeAggregate> timeSeries,
    required bool Function({
      required DateTime date,
      required DateTime currentDate,
    }) condition,
    required ChartMode chartMode,
  }) {

    if (chartMode == ChartMode.weeks) {
      return timeSeries.extractWeeklyAverages().takeLast(chartMode.length);
    } else {
      return timeSeries.extractMonthlyAverages().takeLast(chartMode.length);
    }
  }

  static TimeSeries<SleepSummary> _groupSleepSummary({
    required TimeSeries<SleepSummary> timeSeries,
    required bool Function({
      required DateTime date,
      required DateTime currentDate,
    }) condition,
    required ChartMode chartMode,
  }) {
    if (chartMode == ChartMode.weeks) {
      return timeSeries.extractWeeklyAverages().takeLast(chartMode.length);
    } else {
      return timeSeries.extractMonthlyAverages().takeLast(chartMode.length);
    }
  }
}
