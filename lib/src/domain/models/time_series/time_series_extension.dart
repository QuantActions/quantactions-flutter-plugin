part of 'time_series.dart';

extension TimeSeriesExtension<T> on TimeSeries<T> {
  TimeSeries<T> takeLast(int n) {
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

extension DoubleTimeSeiresExtension on TimeSeries<double> {
  bool isEmpty() {
    return values.where((double element) => !element.isNaN).isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension SleepSummaryTimeSeiresExtension on TimeSeries<SleepSummary> {
  bool isEmpty() {
    return values
        .where(
            (SleepSummary element) => element.sleepStart != DateTime.now().nan)
        .isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension ScreenTimeAggregateTimeSeiresExtension
    on TimeSeries<ScreenTimeAggregate> {
  bool isEmpty() {
    return values
        .where((ScreenTimeAggregate element) => !element.totalScreenTime.isNaN)
        .isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension TrendHolderTimeSeiresExtension on TimeSeries<TrendHolder> {
  bool isEmpty() {
    return values.where((TrendHolder element) => !element.isNan()).isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}

// now I write an extension for the SleepSummary time series to extract the average over weeks
// the following is the kotlin version, I need to write the dart version
// override fun extractWeeklyAverages(): SleepSummaryTimeTimeSeries {
//
// val averagedValues = timestamps.zip(values).groupBy({
// it.first.with(TemporalAdjusters.previousOrSame(DayOfWeek.of(1)))
//     .truncatedTo(ChronoUnit.DAYS).toLocalDateTime()
// }, { Pair(it.first, it.second) }).mapValues { (k, v) ->
//
// val vFiltered = v.filter { it.second.sleepStart != ZonedDateTimePlaceholder }
// val vFilteredAverage = vFiltered.map { it.second.interruptionsStart.size }.average()
// val averageNumberOfInterruptions = if (vFilteredAverage.isNaN()) 0 else kotlin.math.ceil(
// vFilteredAverage
// ).toInt()
//
// SleepSummary(
// periodicMean(
// v.map { it.second.sleepStart }.dropna(),
// vFiltered.map { it.first },
// k
// ),
// periodicMean(
// v.map { it.second.sleepEnd }.dropna(),
// v.filter { it.second.sleepStart != ZonedDateTimePlaceholder }.map { it.first },
// k
// ),
// List(averageNumberOfInterruptions) { ZonedDateTimePlaceholder },
// List(averageNumberOfInterruptions) { ZonedDateTimePlaceholder },
// List(averageNumberOfInterruptions) { 0 },
// )
// }
//
// return SleepSummaryTimeTimeSeries(
// averagedValues.values.toList(),
// averagedValues.keys.toList().map { ZonedDateTime.of(it, ZoneId.systemDefault()) },
// averagedValues.values.toList(),
// averagedValues.values.toList(),
// List(averagedValues.size) { Double.NaN }
// )
// }

// this is the kotlin version of the periodicMean function
// @Keep
// fun periodicMean(
// zonedDateTimes: List<ZonedDateTime>,
// references: List<ZonedDateTime>,
// reference: LocalDateTime
// ): ZonedDateTime {
//
// if (zonedDateTimes.isEmpty()) return ZonedDateTimePlaceholder
// val rawShifts = zonedDateTimes.zip(references).map { (z, r) ->
// z.toEpochSecond() - r.toEpochSecond()
// }
// return ZonedDateTime.of(
// reference.plusSeconds(rawShifts.average().toLong()),
// ZoneId.systemDefault()
// )
// }

DateTime periodicMean(
    List<DateTime> dateTimes, List<DateTime> references, DateTime reference) {
  // remove nan
  final placeholder = DateTime.now().nan;

  // print all
  // for (final pair in zip([dateTimes, references])) {
  //   print('--> ${pair[0]} - ${pair[1]}');
  // }

  // rewrite using expand instead of zip
  final List<int> rawShifts = zip([dateTimes, references])
      .where((element) => element[0] != placeholder)
      .map((pair) => pair[0].difference(pair[1]).inSeconds)
      .toList();
  if (rawShifts.isEmpty) return DateTime.now().nan;
  print('periodic mean raw shifts: $rawShifts');
  print('periodic mean reference: $reference');
  print(
      'periodic mean: ${reference.add(Duration(seconds: rawShifts.average.toInt()))}');
  return reference.add(Duration(seconds: rawShifts.average.toInt()));
}

// this is the dart version of the periodicMean function

//
//
//
// extension ExtractWeeklyAverages on TimeSeries<SleepSummary>  {
//
//   TimeSeries<SleepSummary> extractWeeklyAverages() {
//     // Group timestamps and values by the start of the week (Sunday)
//     final List<List<Object>> a = IterableZip([timestamps, values]).toList();
//     // a.groupListsBy((element) => (element[0] as DateTime).subtract(Duration(days: (element[0] as DateTime).weekday - 1))).truncatedTo(ChronoUnit.days).toLocalDateTime());
//
//
//     final b = a.groupListsBy((element) => Jiffy.parseFromDateTime(element[0] as DateTime).startOf(Unit.week).startOf(Unit.day));
//     final b = a.groupFoldBy((element) => Jiffy.parseFromDateTime(element[0] as DateTime).startOf(Unit.week).startOf(Unit.day), (previous, element) => element[1])
//     final c = b.map((element) => elemnt[1][]);
//   }
// }

extension ExtractWeeklyAverages on TimeSeries<double> {
  TimeSeries<double> extractWeeklyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip([timestamps, values]).toList();
    final List<List<Object>> zippedCIH =
        IterableZip([timestamps, confidenceIntervalHigh]).toList();
    final List<List<Object>> zippedCIL =
        IterableZip([timestamps, confidenceIntervalLow]).toList();
    final List<List<Object>> zippedConfidence =
        IterableZip([timestamps, confidence]).toList();

    final newValues = zippedValues
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.week)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));

    final newCIH = zippedCIH
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.week)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));
    final newCIL = zippedCIL
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.week)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));
    final newConfidence = zippedConfidence
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.week)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));

    return TimeSeries<double>(
      values: newValues.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      timestamps: newValues.keys.toList(),
      confidenceIntervalLow: newCIL.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      confidenceIntervalHigh: newCIH.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      confidence: newConfidence.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
    );
  }

  TimeSeries<double> extractMonthlyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
        IterableZip([timestamps, values]).toList();
    final List<List<Object>> zippedCIH =
        IterableZip([timestamps, confidenceIntervalHigh]).toList();
    final List<List<Object>> zippedCIL =
        IterableZip([timestamps, confidenceIntervalLow]).toList();
    final List<List<Object>> zippedConfidence =
        IterableZip([timestamps, confidence]).toList();

    final newValues = zippedValues
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.month)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));

    final newCIH = zippedCIH
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.month)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));
    final newCIL = zippedCIL
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.month)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));
    final newConfidence = zippedConfidence
        .groupListsBy((element) =>
            Jiffy.parseFromDateTime(element[0] as DateTime)
                .startOf(Unit.month)
                .startOf(Unit.day)
                .dateTime)
        .map((key, value) => MapEntry(
            key, value.map((element) => element[1] as double).toList()));

    return TimeSeries<double>(
      values: newValues.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      timestamps: newValues.keys.toList(),
      confidenceIntervalLow: newCIL.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      confidenceIntervalHigh: newCIH.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
      confidence: newConfidence.values
          .toList()
          .map((element) => element.toList().safeAverage())
          .toList(),
    );
  }
}

extension SafeAverage on List<double> {
  double safeAverage() {
    if (isEmpty) return double.nan;
    final List<double> nanSafe = where((double e) => !e.isNaN).toList();
    if (nanSafe.isEmpty) return double.nan;
    return nanSafe.average;
  }
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

extension ExtractSleepSummaryWeeklyAverages on TimeSeries<SleepSummary> {
  TimeSeries<SleepSummary> extractWeeklyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
    IterableZip([timestamps, values]).toList();

    // for (final pair in zippedValues) {
    //   print('--> ${pair[0]} - ${pair[1]}');
    // }

    final newZippedValues = zippedValues.groupListsBy((element) =>
    Jiffy.parseFromDateTime(element[0] as DateTime)
        .startOf(Unit.week)
        .startOf(Unit.day)
        .dateTime);
    final newValues = newZippedValues.entries
        .map((element) => SleepSummary(
        sleepStart: periodicMean(
            element.value
                .map((element) => (element[1] as SleepSummary).sleepStart)
                .toList(),
            element.value.map((element) => (element[1] as SleepSummary).referenceDate).toList(),
            (element.key as DateTime)),
        sleepEnd: periodicMean(
            element.value
                .map((element) => (element[1] as SleepSummary).sleepEnd)
                .toList(),
            element.value.map((element) => (element[1] as SleepSummary).referenceDate).toList(),
            (element.key as DateTime)),
        interruptionsStart: List<DateTime>.filled(
            element.value
                .map((element) => (element[1] as SleepSummary)
                .interruptionsNumberOfTaps
                .length)
                .toList()
                .average
                .ceil(),
            DateTime.now().nan),
        interruptionsEnd: List<DateTime>.filled(
            element.value
                .map((element) => (element[1] as SleepSummary)
                .interruptionsNumberOfTaps
                .length)
                .toList()
                .average
                .ceil(),
            DateTime.now().nan),
        interruptionsNumberOfTaps: List<int>.filled(
            element.value
                .map((element) =>
            (element[1] as SleepSummary).interruptionsNumberOfTaps.length)
                .toList()
                .average
                .ceil(),
            0),
        referenceDate: (element.key as DateTime)))
        .toList();

    return TimeSeries<SleepSummary>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newZippedValues.keys.toList(),
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }

  TimeSeries<SleepSummary> extractMonthlyAverages() {
    // Group timestamps and values by the start of the week (Sunday)
    final List<List<Object>> zippedValues =
        IterableZip([timestamps, values]).toList();

    // for (final pair in zippedValues) {
    //   print('--> ${pair[0]} - ${pair[1]}');
    // }

    final newZippedValues = zippedValues.groupListsBy((element) =>
        Jiffy.parseFromDateTime(element[0] as DateTime)
            .startOf(Unit.month)
            .startOf(Unit.day)
            .dateTime);
    final newValues = newZippedValues.entries
        .map((element) => SleepSummary(
            sleepStart: periodicMean(
                element.value
                    .map((element) => (element[1] as SleepSummary).sleepStart)
                    .toList(),
                element.value.map((element) => (element[1] as SleepSummary).referenceDate).toList(),
                (element.key as DateTime)),
            sleepEnd: periodicMean(
                element.value
                    .map((element) => (element[1] as SleepSummary).sleepEnd)
                    .toList(),
                element.value.map((element) => (element[1] as SleepSummary).referenceDate).toList(),
                (element.key as DateTime)),
            interruptionsStart: List<DateTime>.filled(
                element.value
                    .map((element) => (element[1] as SleepSummary)
                        .interruptionsNumberOfTaps
                        .length)
                    .toList()
                    .average
                    .ceil(),
                DateTime.now().nan),
            interruptionsEnd: List<DateTime>.filled(
                element.value
                    .map((element) => (element[1] as SleepSummary)
                        .interruptionsNumberOfTaps
                        .length)
                    .toList()
                    .average
                    .ceil(),
                DateTime.now().nan),
            interruptionsNumberOfTaps: List<int>.filled(
                element.value
                    .map((element) =>
                        (element[1] as SleepSummary).interruptionsNumberOfTaps.length)
                    .toList()
                    .average
                    .ceil(),
                0),
            referenceDate: (element.key as DateTime)))
        .toList();

    return TimeSeries<SleepSummary>(
      values: newValues,

      // fill a list of length n with 0 values
      timestamps: newZippedValues.keys.toList(),
      confidenceIntervalLow: newValues,
      confidenceIntervalHigh: newValues,
      confidence: List<double>.filled(newZippedValues.keys.length, 0.0),
    );
  }
}

extension ExtractScreenTimeAggregateWeeklyAverages
    on TimeSeries<ScreenTimeAggregate> {
  TimeSeries<ScreenTimeAggregate> extractWeeklyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip([timestamps, values]).toList();

    final newZippedValues = zippedValues.groupListsBy((element) =>
        Jiffy.parseFromDateTime(element[0] as DateTime)
            .startOf(Unit.week)
            .startOf(Unit.day)
            .dateTime);
    final newValues = newZippedValues.entries
        .map((element) => ScreenTimeAggregate(
            totalScreenTime: element.value
                .map((element) =>
                    (element[1] as ScreenTimeAggregate).totalScreenTime)
                .toList()
                .safeAverage(),
            socialScreenTime: element.value
                .map((element) =>
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

  TimeSeries<ScreenTimeAggregate> extractMonthlyAverages() {
    final List<List<Object>> zippedValues =
        IterableZip([timestamps, values]).toList();

    final newZippedValues = zippedValues.groupListsBy((element) =>
        Jiffy.parseFromDateTime(element[0] as DateTime)
            .startOf(Unit.month)
            .startOf(Unit.day)
            .dateTime);
    final newValues = newZippedValues.entries
        .map((element) => ScreenTimeAggregate(
            totalScreenTime: element.value
                .map((element) =>
                    (element[1] as ScreenTimeAggregate).totalScreenTime)
                .toList()
                .safeAverage(),
            socialScreenTime: element.value
                .map((element) =>
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
