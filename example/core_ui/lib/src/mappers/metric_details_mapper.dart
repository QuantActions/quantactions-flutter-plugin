import 'package:charts/charts.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

import 'average_mapper.dart';


class MetricDetailsMapper {
  static int getMainValueDif({
    required ChartMode chartMode,
    required TrendHolder mainCardDif,
  }) {
    return switch (chartMode) {
      ChartMode.days =>
        mainCardDif.difference2Weeks.isNaN ? 0 : mainCardDif.difference2Weeks.round(),
      ChartMode.weeks =>
        mainCardDif.difference6Weeks.isNaN ? 0 : mainCardDif.difference6Weeks.round(),
      ChartMode.months =>
        mainCardDif.difference1Year.isNaN ? 0 : mainCardDif.difference1Year.round(),
    };
  }

  static int getAdditionalValueDif({
    required ChartMode chartMode,
    required TrendHolder additionalCardDif,
  }) {
    return switch (chartMode) {
      ChartMode.days =>
        additionalCardDif.difference2Weeks.isNaN ? 0 : additionalCardDif.difference2Weeks.round(),
      ChartMode.weeks =>
        additionalCardDif.difference6Weeks.isNaN ? 0 : additionalCardDif.difference6Weeks.round(),
      ChartMode.months =>
        additionalCardDif.difference1Year.isNaN ? 0 : additionalCardDif.difference1Year.round(),
    };
  }

  static int getScoreCardDif({
    required ChartMode chartMode,
    required TrendHolder scoreCardDif,
  }) {
    return switch (chartMode) {
      ChartMode.days =>
        scoreCardDif.difference2Weeks.isNaN ? 0 : scoreCardDif.difference2Weeks.round(),
      ChartMode.weeks =>
        scoreCardDif.difference6Weeks.isNaN ? 0 : scoreCardDif.difference6Weeks.round(),
      ChartMode.months =>
        scoreCardDif.difference1Year.isNaN ? 0 : scoreCardDif.difference1Year.round(),
    };
  }

  static String getPercentStringValue(int percent) {
    if (percent <= 33) {
      return "Low";
    } else if (percent <= 66) {
      return "Medium";
    } else {
      return "High";
    }
  }

  static int getIndicatorValue({
    required TimeSeries<double> timeSeries,
    required ChartMode chartMode,
  }) {
    final List<double> periodValues = GroupDataMapper.groupTimeSeriesByChartMode(
      chartMode: chartMode,
      timeSeries: timeSeries,
    ).values;

    final double average = AverageMapper.getListAverageDouble(periodValues);
    return average.isNaN ? 0 : average.round();
  }

  static int getAverageDoubleValue({
    required TimeSeries<double> timeSeries,
    required ChartMode chartMode,
  }) {
    final List<double> periodValues = GroupDataMapper.returnLinearListByChartMode(
      chartMode: chartMode,
      timeSeries: timeSeries,
    ).values;

    final double average = AverageMapper.getListAverageDouble(periodValues);
    return average.isNaN ? 0 : average.round();
  }

  static int getAverageSleepDuration({
    required TimeSeries<SleepSummary> timeSeries,
    required ChartMode chartMode,
  }) {
    final List<SleepSummary> periodValues = GroupDataMapper.returnLinearListByChartMode(
      chartMode: chartMode,
      timeSeries: timeSeries,
    ).values;

    final List<double> sleepDurationList = periodValues.map((SleepSummary sleepSummary) {
      final int sleepStart = sleepSummary.sleepStart.epochMilliseconds;
      final int sleepEnd = sleepSummary.sleepEnd.epochMilliseconds;

      return (sleepEnd - sleepStart).toDouble();
    }).toList();

    final double average = AverageMapper.getListAverageDouble(sleepDurationList.where((double element) => element > 0).toList());
    return average.isNaN ? 0 : average.round();
  }

  static int getAverageSocialScreenTime({
    required TimeSeries<ScreenTimeAggregate> timeSeries,
    required ChartMode chartMode,
  }) {
    final List<ScreenTimeAggregate> periodValues = GroupDataMapper.returnLinearListByChartMode(
      chartMode: chartMode,
      timeSeries: timeSeries,
    ).values;

    final List<double> socialScreenTime = periodValues.map((ScreenTimeAggregate screenTime) {
      return screenTime.socialScreenTime;
    }).toList();

    final double average = AverageMapper.getListAverageDouble(socialScreenTime);
    return average.isNaN ? 0 : average.ceil().coerceAtLeast(60 * 1000);
  }

  static int getAverageInterruption({
    required TimeSeries<SleepSummary> timeSeries,
    required ChartMode chartMode,
  }) {
    final List<SleepSummary> periodValues = GroupDataMapper.returnLinearListByChartMode(
      chartMode: chartMode,
      timeSeries: timeSeries,
    ).values;

    final List<int> interruptionsCounts = periodValues.map((SleepSummary sleepSummary) {
      return sleepSummary.interruptionsStart.length;
    }).toList();

    final int average = AverageMapper.getListAverageInt(interruptionsCounts);
    return average.isNaN ? 0 : average;
  }

  static double? getTrendHolderDifference({
    required ChartMode chartMode,
    required TrendHolder? trendHolder,
  }) {
    // returns 3 possible values:
    // 1. null if trendHolder is null
    // 2. nan is diff is nan
    // 3. value is it's not nan

    if (trendHolder == null) return null;
    return switch (chartMode) {
      ChartMode.days => trendHolder.difference2Weeks,
      ChartMode.weeks => trendHolder.difference6Weeks,
      ChartMode.months => trendHolder.difference1Year,
    };
  }

  // now I want it in dart
  static String millisecondsToHourMinutes(int preAmount) {
    final int amount = preAmount.abs();

    final int hours = (amount / 3600 / 1000).toInt();
    final int minutes = ((amount - hours * 3600 * 1000) / 60 / 1000).toInt();
    return hours == 0
        ? '${minutes}min'
        :'${hours}h ${minutes}min';
  }



}
