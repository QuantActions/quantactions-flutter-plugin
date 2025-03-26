part of 'time_series.dart';

/// Extension methods for [TimeSeries] objects.
extension TimeSeriesExtension<T> on TimeSeries<T> {
  /// Returns the last [n] elements of the time series.
  TimeSeries<T> takeLast(int n) {
    if (n > values.length) {
      return this;
    }
    return TimeSeries<T>(
      values: values.sublist(values.length - n),
      timestamps: timestamps.sublist(timestamps.length - n),
      confidenceIntervalLow:
          confidenceIntervalLow.sublist(confidenceIntervalLow.length - n),
      confidenceIntervalHigh:
          confidenceIntervalHigh.sublist(confidenceIntervalHigh.length - n),
      confidence: confidence.sublist(confidence.length - n),
    );
  }

  /// Reverses the time series in time.
  TimeSeries<T> reverse() {
    return TimeSeries<T>(
      values: values.reversed.toList(),
      timestamps: timestamps.reversed.toList(),
      confidenceIntervalLow: confidenceIntervalLow.reversed.toList(),
      confidenceIntervalHigh: confidenceIntervalHigh.reversed.toList(),
      confidence: confidence.reversed.toList(),
    );
  }
}

/// Extension methods for [TimeSeries] objects with [double] values.
extension DoubleTimeSeiresExtension on TimeSeries<double> {
  /// Check if the time series is empty (ignores nans).
  bool isEmpty() {
    return values.where((double element) => !element.isNaN).isEmpty;
  }

  /// Check if the time series is not empty (ignores nans).
  bool isNotEmpty() {
    return !isEmpty();
  }

  /// Drop all nan values from the time series.
  TimeSeries<double> dropna() {
    final List<double> newValues = values
        .whereIndexed((int index, double element) => !values[index].isNaN)
        .toList();
    final List<ZonedDateTime> newTimestamps = timestamps
        .whereIndexed(
            (int index, ZonedDateTime element) => !values[index].isNaN)
        .toList();
    final List<double> newConfidenceIntervalLow = confidenceIntervalLow
        .whereIndexed((int index, double element) => !values[index].isNaN)
        .toList();
    final List<double> newConfidenceIntervalHigh = confidenceIntervalHigh
        .whereIndexed((int index, double element) => !values[index].isNaN)
        .toList();
    final List<double> newConfidence = confidence
        .whereIndexed((int index, double element) => !values[index].isNaN)
        .toList();

    return TimeSeries<double>(
      values: newValues,
      timestamps: newTimestamps,
      confidenceIntervalLow: newConfidenceIntervalLow,
      confidenceIntervalHigh: newConfidenceIntervalHigh,
      confidence: newConfidence,
    );
  }
}

/// Extension methods for [TimeSeries] objects with [SleepSummary] values.
extension SleepSummaryTimeSeiresExtension on TimeSeries<SleepSummary> {
  /// Check if the time series is empty (ignores nans).
  bool isEmpty() {
    return values
        .where((SleepSummary element) => !element.sleepStart.isNaN)
        .isEmpty;
  }

  /// Check if the time series is not empty (ignores nans).
  bool isNotEmpty() {
    return !isEmpty();
  }

  /// Drop all nan values from the time series.
  TimeSeries<SleepSummary> dropna() {
    final List<SleepSummary> newValues = values
        .whereIndexed((int index, SleepSummary element) =>
            values[index].sleepStart != ZonedDateTime.now().nan)
        .toList();
    final List<ZonedDateTime> newTimestamps = timestamps
        .whereIndexed((int index, ZonedDateTime element) =>
            values[index].sleepStart != ZonedDateTime.now().nan)
        .toList();
    final List<SleepSummary> newConfidenceIntervalLow = confidenceIntervalLow
        .whereIndexed((int index, SleepSummary element) =>
            values[index].sleepStart != ZonedDateTime.now().nan)
        .toList();
    final List<SleepSummary> newConfidenceIntervalHigh = confidenceIntervalHigh
        .whereIndexed((int index, SleepSummary element) =>
            values[index].sleepStart != ZonedDateTime.now().nan)
        .toList();
    final List<double> newConfidence = confidence
        .whereIndexed((int index, double element) =>
            values[index].sleepStart != ZonedDateTime.now().nan)
        .toList();

    return TimeSeries<SleepSummary>(
      values: newValues,
      timestamps: newTimestamps,
      confidenceIntervalLow: newConfidenceIntervalLow,
      confidenceIntervalHigh: newConfidenceIntervalHigh,
      confidence: newConfidence,
    );
  }
}

/// Extension methods for [TimeSeries] objects with [ScreenTimeAggregate] values.
extension ScreenTimeAggregateTimeSeiresExtension
    on TimeSeries<ScreenTimeAggregate> {
  /// Check if the time series is empty (ignores nans).
  bool isEmpty() {
    return values
        .where((ScreenTimeAggregate element) => !element.isNaN)
        .isEmpty;
  }

  /// Check if the time series is not empty (ignores nans).
  bool isNotEmpty() {
    return !isEmpty();
  }

  /// Drop all nan values from the time series.
  TimeSeries<ScreenTimeAggregate> dropna() {
    final List<ScreenTimeAggregate> newValues = values
        .whereIndexed(
            (int index, ScreenTimeAggregate element) => !values[index].isNaN)
        .toList();
    final List<ZonedDateTime> newTimestamps = timestamps
        .whereIndexed(
            (int index, ZonedDateTime element) => !values[index].isNaN)
        .toList();
    final List<ScreenTimeAggregate> newConfidenceIntervalLow =
        confidenceIntervalLow
            .whereIndexed((int index, ScreenTimeAggregate element) =>
                !values[index].isNaN)
            .toList();
    final List<ScreenTimeAggregate> newConfidenceIntervalHigh =
        confidenceIntervalHigh
            .whereIndexed((int index, ScreenTimeAggregate element) =>
                !values[index].isNaN)
            .toList();
    final List<double> newConfidence = confidence
        .whereIndexed((int index, double element) => !values[index].isNaN)
        .toList();

    return TimeSeries<ScreenTimeAggregate>(
      values: newValues,
      timestamps: newTimestamps,
      confidenceIntervalLow: newConfidenceIntervalLow,
      confidenceIntervalHigh: newConfidenceIntervalHigh,
      confidence: newConfidence,
    );
  }
}

/// Extension methods for [TimeSeries] objects with [TrendHolder] values.
extension TrendHolderTimeSeiresExtension on TimeSeries<TrendHolder> {
  /// Check if the time series is empty (ignores nans).
  bool isEmpty() {
    return values.where((TrendHolder element) => !element.isNaN).isEmpty;
  }

  /// Check if the time series is not empty (ignores nans).
  bool isNotEmpty() {
    return !isEmpty();
  }

  /// Drop all nan values from the time series.
  TimeSeries<TrendHolder> dropna() {
    final List<TrendHolder> newValues = values
        .whereIndexed((int i, TrendHolder element) => !values[i].isNaN)
        .toList();
    final List<ZonedDateTime> newTimestamps = timestamps
        .whereIndexed((int i, ZonedDateTime element) => !values[i].isNaN)
        .toList();
    final List<TrendHolder> newConfidenceIntervalLow = confidenceIntervalLow
        .whereIndexed((int i, TrendHolder element) => !values[i].isNaN)
        .toList();
    final List<TrendHolder> newConfidenceIntervalHigh = confidenceIntervalHigh
        .whereIndexed((int i, TrendHolder element) => !values[i].isNaN)
        .toList();
    final List<double> newConfidence = confidence
        .whereIndexed((int i, double element) => !values[i].isNaN)
        .toList();
    return TimeSeries<TrendHolder>(
      values: newValues,
      timestamps: newTimestamps,
      confidenceIntervalLow: newConfidenceIntervalLow,
      confidenceIntervalHigh: newConfidenceIntervalHigh,
      confidence: newConfidence,
    );
  }
}

/// Calculates the mean for a series on date objects
ZonedDateTime periodicMean(List<ZonedDateTime> dateTimes,
    List<ZonedDateTime> references, LocalDateTime reference) {
  // remove nan
  final ZonedDateTime placeholder = ZonedDateTime.now().nan;

  // rewrite using expand instead of zip
  final List<int> rawShifts = zip(<List<ZonedDateTime>>[dateTimes, references])
      .where((List<ZonedDateTime> element) => element[0] != placeholder)
      .map((List<ZonedDateTime> pair) => pair[0].difference(pair[1]).inSeconds)
      .toList();
  if (rawShifts.isEmpty) {
    return ZonedDateTime.now().nan;
  }
  ;

  return ZonedDateTimeNaN.fromLocalDateTime(
      reference.add(Duration(seconds: rawShifts.average.toInt())));
}

/// Extension methods for [TimeSeries] objects with [double] values.
extension ExtractWeeklyAverages on TimeSeries<double> {
  /// Extracts the weekly averages from the time series.
  TimeSeries<double> extractWeeklyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();
    final List<List<Object>> zippedCIH =
        IterableZip<Object>(<List<Object>>[timestamps, confidenceIntervalHigh])
            .toList();
    final List<List<Object>> zippedCIL =
        IterableZip<Object>(<List<Object>>[timestamps, confidenceIntervalLow])
            .toList();
    final List<List<Object>> zippedConfidence =
        IterableZip<Object>(<List<Object>>[timestamps, confidence]).toList();

    final Map<ZonedDateTime, List<double>> newValues = zippedValues
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfWeek)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));

    final Map<ZonedDateTime, List<double>> newCIH = zippedCIH
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfWeek)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));
    final Map<ZonedDateTime, List<double>> newCIL = zippedCIL
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfWeek)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));
    final Map<ZonedDateTime, List<double>> newConfidence = zippedConfidence
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfWeek)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));

    return TimeSeries<double>(
      values: newValues.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      timestamps: newValues.keys.toList(),
      confidenceIntervalLow: newCIL.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      confidenceIntervalHigh: newCIH.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      confidence: newConfidence.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
    );
  }

  /// Extracts the monthly averages from the time series.
  TimeSeries<double> extractMonthlyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();
    final List<List<Object>> zippedCIH =
        IterableZip<Object>(<List<Object>>[timestamps, confidenceIntervalHigh])
            .toList();
    final List<List<Object>> zippedCIL =
        IterableZip<Object>(<List<Object>>[timestamps, confidenceIntervalLow])
            .toList();
    final List<List<Object>> zippedConfidence =
        IterableZip<Object>(<List<Object>>[timestamps, confidence]).toList();

    final Map<ZonedDateTime, List<double>> newValues = zippedValues
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).copyWith(timezone: Timezone.now()).firstDayOfMonth)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));

    final Map<ZonedDateTime, List<double>> newCIH = zippedCIH
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfMonth)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));
    final Map<ZonedDateTime, List<double>> newCIL = zippedCIL
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfMonth)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));
    final Map<ZonedDateTime, List<double>> newConfidence = zippedConfidence
        .groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfMonth)
        .map((ZonedDateTime key, List<List<Object>> value) =>
            MapEntry<ZonedDateTime, List<double>>(
                key,
                value
                    .map((List<Object> element) => element[1] as double)
                    .toList()));

    return TimeSeries<double>(
      values: newValues.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      timestamps: newValues.keys.toList(),
      confidenceIntervalLow: newCIL.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      confidenceIntervalHigh: newCIH.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
      confidence: newConfidence.values
          .toList()
          .map((List<double> element) => element.toList().safeAverage())
          .toList(),
    );
  }
}

/// Extension methods for [List] objects with [double] values.
extension SafeAverage on List<double> {
  /// Calculates the average of the list, ignoring nan values.
  double safeAverage() {
    if (isEmpty) return double.nan;
    final List<double> nanSafe = where((double e) => !e.isNaN).toList();
    if (nanSafe.isEmpty) return double.nan;
    return nanSafe.average;
  }
}

/// Extension methods for [List] objects with [int] values.
/// Find the date of the monday of the week
DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

/// Extension methods for [List] objects with [int] values.
extension ExtractSleepSummaryWeeklyAverages on TimeSeries<SleepSummary> {
  /// Extracts the weekly averages from the time series.
  TimeSeries<SleepSummary> extractWeeklyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();

    final Map<LocalDateTime, List<List<Object>>> newZippedValues = zippedValues
        .groupListsBy((List<Object> element) => (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now())
            .firstDayOfWeek
            .truncate(to: DateUnit.days)
            .toLocal());
    final List<SleepSummary> newValues = newZippedValues.entries
        .map((MapEntry<LocalDateTime, List<List<Object>>> element) => SleepSummary(
            sleepStart: periodicMean(
                element.value
                    .map((List<Object> element) =>
                        (element[1] as SleepSummary).sleepStart)
                    .toList(),
                element.value
                    .map((List<Object> element) => element[0] as ZonedDateTime)
                    .toList(),
                element.key),
            sleepEnd: periodicMean(
                element.value
                    .map((List<Object> element) =>
                        (element[1] as SleepSummary).sleepEnd)
                    .toList(),
                element.value
                    .map((List<Object> element) => element[0] as ZonedDateTime)
                    .toList(),
                element.key),
            interruptionsStart:
                List<ZonedDateTime>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), ZonedDateTime.now().nan),
            interruptionsEnd: List<ZonedDateTime>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), ZonedDateTime.now().nan),
            interruptionsNumberOfTaps: List<int>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), 0)))
        .toList();

    final List<ZonedDateTime> newKeys =
        newZippedValues.keys.map(ZonedDateTimeNaN.fromLocalDateTime).toList();

    return TimeSeries<SleepSummary>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newKeys,
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }

  /// Extracts the monthly averages from the time series.
  TimeSeries<SleepSummary> extractMonthlyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();

    final Map<LocalDateTime, List<List<Object>>> newZippedValues = zippedValues
        .groupListsBy((List<Object> element) => (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now())
            .firstDayOfMonth
            .truncate(to: DateUnit.days)
            .toLocal());
    final List<SleepSummary> newValues = newZippedValues.entries
        .map((MapEntry<LocalDateTime, List<List<Object>>> element) => SleepSummary(
            sleepStart: periodicMean(
                element.value
                    .map((List<Object> element) =>
                        (element[1] as SleepSummary).sleepStart)
                    .toList(),
                element.value
                    .map((List<Object> element) => element[0] as ZonedDateTime)
                    .toList(),
                element.key),
            sleepEnd: periodicMean(
                element.value
                    .map((List<Object> element) =>
                        (element[1] as SleepSummary).sleepEnd)
                    .toList(),
                element.value
                    .map((List<Object> element) => element[0] as ZonedDateTime)
                    .toList(),
                element.key),
            interruptionsStart:
                List<ZonedDateTime>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), ZonedDateTime.now().nan),
            interruptionsEnd: List<ZonedDateTime>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), ZonedDateTime.now().nan),
            interruptionsNumberOfTaps: List<int>.filled(element.value.map((List<Object> element) => (element[1] as SleepSummary).interruptionsNumberOfTaps.length).toList().average.ceil(), 0)))
        .toList();

    final List<ZonedDateTime> newKeys =
        newZippedValues.keys.map(ZonedDateTimeNaN.fromLocalDateTime).toList();

    return TimeSeries<SleepSummary>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newKeys,
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }
}

/// Extension methods for [TimeSeries] objects with [ScreenTimeAggregate] values.
extension ExtractScreenTimeAggregateWeeklyAverages
    on TimeSeries<ScreenTimeAggregate> {
  /// Extracts the weekly averages from the time series.
  TimeSeries<ScreenTimeAggregate> extractWeeklyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();

    final Map<ZonedDateTime, List<List<Object>>> newZippedValues =
        zippedValues.groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfWeek);
    final List<ScreenTimeAggregate> newValues = newZippedValues.entries
        .map((MapEntry<ZonedDateTime, List<List<Object>>> element) =>
            ScreenTimeAggregate(
                totalScreenTime: element.value
                    .map((List<Object> element) =>
                        (element[1] as ScreenTimeAggregate).totalScreenTime)
                    .toList()
                    .safeAverage(),
                socialScreenTime: element.value
                    .map((List<Object> element) =>
                        (element[1] as ScreenTimeAggregate).socialScreenTime)
                    .toList()
                    .safeAverage()))
        .toList();

    return TimeSeries<ScreenTimeAggregate>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newZippedValues.keys.toList(),
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }

  /// Extracts the monthly averages from the time series.
  TimeSeries<ScreenTimeAggregate> extractMonthlyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip<Object>(<List<Object>>[timestamps, values]).toList();

    final Map<ZonedDateTime, List<List<Object>>> newZippedValues =
        zippedValues.groupListsBy((List<Object> element) =>
            (element[0] as ZonedDateTime).copyWith(timezone: Timezone.now()).firstDayOfMonth);
    final List<ScreenTimeAggregate> newValues = newZippedValues.entries
        .map((MapEntry<ZonedDateTime, List<List<Object>>> element) =>
            ScreenTimeAggregate(
                totalScreenTime: element.value
                    .map((List<Object> element) =>
                        (element[1] as ScreenTimeAggregate).totalScreenTime)
                    .toList()
                    .safeAverage(),
                socialScreenTime: element.value
                    .map((List<Object> element) =>
                        (element[1] as ScreenTimeAggregate).socialScreenTime)
                    .toList()
                    .safeAverage()))
        .toList();

    return TimeSeries<ScreenTimeAggregate>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newZippedValues.keys.toList(),
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }
}
