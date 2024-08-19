

import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

class ScoreMapper {
  static List<double> getScoresFromSleepSummaryTimeSeries(TimeSeries<SleepSummary> timeSeries){
    return timeSeries.values.reversed
        .map((SleepSummary e) => e.interruptionsStart.length.toDouble())
        .toList();
  }
}