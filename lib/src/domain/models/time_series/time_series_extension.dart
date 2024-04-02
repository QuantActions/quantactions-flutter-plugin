
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
      confidenceIntervalLow:
      confidenceIntervalLow.reversed.toList(),
      confidenceIntervalHigh:
      confidenceIntervalHigh.reversed.toList(),
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
    return values.where((SleepSummary element) => element.sleepStart != DateTime.fromMicrosecondsSinceEpoch(0)).isEmpty;
  }
  bool isNotEmpty() {
    return !isEmpty();
  }
}

extension ScreenTimeAggregateTimeSeiresExtension on TimeSeries<ScreenTimeAggregate> {
  bool isEmpty() {
    return values.where((ScreenTimeAggregate element) => !element.totalScreenTime.isNaN).isEmpty;
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

// this is the dart version of the periodicMean function
// DateTime periodicMean(List<DateTime> zonedDateTimes, List<DateTime> references, DateTime reference) {
//   if (zonedDateTimes.isEmpty) return DateTime.fromMicrosecondsSinceEpoch(0);
//   // rewrite using expand instead of zip
//   final List<int> rawShifts = zonedDateTimes.expand((DateTime z) => references.map((DateTime r) => z.difference(r).inSeconds)).toList();
//   return reference.add(Duration(seconds: rawShifts.average.toInt()));
// }
//
//
//
// extension ExtractWeeklyAverages on TimeSeries<SleepSummary>  {
//
//   TimeSeries<SleepSummary> extractWeeklyAverages() {
//     // Group timestamps and values by the start of the week (Sunday)
//     final a = timestamps.zip(values);
//     final averagedValues = timestamps.zip(values).groupBy(
//             (entry) => entry.first.with(TemporalAdjusters.previousOrSame(
//         DayOfWeek.sunday)).truncatedTo(ChronoUnit.days).toLocalDateTime(),
//     (entry) => entry,
//     );
//   }
//
//
// }



