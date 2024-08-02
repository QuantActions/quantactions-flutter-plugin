import 'dart:math';

import 'package:charts/src/utils/extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/painting.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:scidart/numdart.dart';
import 'package:sugar/sugar.dart';

import '../../charts.dart';
import 'date_time_utils.dart';

class ChartUtils {
  static String getHourString(double milliseconds) {
    final DateTime date = DateTimeUtils.fromMillisecondsSinceEpoch(
      milliseconds.toInt(),
    );

    final int hours = DateTimeUtils.getHours(date);
    final int minutes = DateTimeUtils.getMinutes(date);
    final int minutesRounded = minutes - minutes % 5;

    if (hours == 0) {
      return '${minutesRounded}m';
    }

    if (minutesRounded == 0) {
      return '${hours}h';
    }

    return '${hours}h$minutesRounded';
  }

  static int getVerticalLinesCount(ChartMode chartMode) {
    return switch (chartMode) {
      ChartMode.days => ChartMode.days.length,
      ChartMode.weeks => ChartMode.weeks.length,
      ChartMode.months => ChartMode.months.length,
    };
  }

  // utility function to find the closest value in a list to a given value
  static int findClosest(List<double> values, double value) {
    double min = double.infinity;
    int minIndex = -1;
    for (int i = 0; i < values.length; i++) {
      if ((values[i] - value).abs() < min) {
        min = (values[i] - value).abs();
        minIndex = i;
      }
    }
    return minIndex;
  }

  static List<List<Point<double>>> calculatePointsForDataGeneral({
    required List<double> data,
    required double width,
    required double height,
    required bool reverse,
    required double maxVal,
    required double minVal,
    required double horizontalBias,
    required bool includeOutOfChartLeft,
    required bool fromTop,
  }) {
    List<Point<double>> points = List<Point<double>>.empty(growable: true);
    final double xDiff = (width - horizontalBias * 2) / (data.length - 1);
    final List<List<Point<double>>> segments =
        List<List<Point<double>>>.empty(growable: true);

    final Iterable<double> data2 = reverse ? data.reversed : data;

    for (int i = 0; i < data2.length; i++) {
      if (!data2.elementAt(i).isNaN) {
        final double y = fromTop
            ? ((data2.elementAt(i) - minVal) / maxVal * height)
            : height - ((data2.elementAt(i) - minVal) / maxVal * height);
        if (reverse) {
          points.add(Point<double>(
              xDiff * (data2.length - 1 - i) + horizontalBias, y + y * 0.03));
          if (i == data2.length - 1 && includeOutOfChartLeft) {
            points.add(Point<double>(0, y));
          }
        } else {
          if (i == 0 && includeOutOfChartLeft) {
            points.add(Point<double>(0, y + y * 0.03));
          }
          points.add(Point<double>(xDiff * i + horizontalBias, y));
        }
      } else {
        if (points.isNotEmpty) {
          segments.add(points);
          points = List<Point<double>>.empty(growable: true);
        }
      }
    }
    if (points.isNotEmpty) {
      segments.add(points); // this means no interruptions have been found
    }

    return segments;
  }

  // same as for data general but this time returns a flat array instead
  static List<Point<double>> calculatePointsForDataGeneralFlat({
    required List<double> data,
    required double width,
    required double height,
    required bool reverse,
    required double maxVal,
    required double minVal,
    required double horizontalBias,
    required bool includeOutOfChartLeft,
  }) {
    final List<Point<double>> points =
        List<Point<double>>.empty(growable: true);
    final double xDiff = (width - horizontalBias * 2) / (data.length - 1);

    final Iterable<double> data2 = reverse ? data.reversed : data;

    for (int i = 0; i < data2.length; i++) {
      double y = double.nan;
      if (!data2.elementAt(i).isNaN) {
        y = height -
            ((data2.elementAt(i) - minVal) / (maxVal - minVal) * height);
      }

      if (reverse) {
        points.add(Point<double>(
            xDiff * (data2.length - 1 - i) + horizontalBias, y + y * 0.03));
        if (i == data2.length - 1 && includeOutOfChartLeft) {
          points.add(Point<double>(0, y));
        }
      } else {
        if (i == 0 && includeOutOfChartLeft) {
          points.add(Point<double>(0, y + y * 0.03));
        }
        points.add(Point<double>(xDiff * i + horizontalBias, y));
      }
    }
    return points;
  }

  static Pair<List<Point<double>>, List<Point<double>>>
      calculateConnectionPointsForBezierCurve(List<Point<double>> points) {
    final List<Point<double>> conPoint1 =
        List<Point<double>>.empty(growable: true);
    final List<Point<double>> conPoint2 =
        List<Point<double>>.empty(growable: true);

    for (int i = 1; i < points.length; i++) {
      conPoint1.add(
          Point<double>((points[i].x + points[i - 1].x) / 2, points[i - 1].y));
      conPoint2
          .add(Point<double>((points[i].x + points[i - 1].x) / 2, points[i].y));
    }

    return Pair<List<Point<double>>, List<Point<double>>>(conPoint1, conPoint2);
  }

  static double percentile(List<double> values, double percent) {
    if (values.isEmpty) {
      return 0;
    }
    final List<double> sorted = values.sorted();
    final double k = (sorted.length - 1) * percent;
    final int f = k.floor();
    final int c = k.round();

    if (f == c) {
      return sorted.elementAt(f);
    }
    final double d0 = sorted.elementAt(f) * (c - k);
    final double d1 = sorted.elementAt(c) * (k - f);
    return d0 + d1;
  }

  // utilities to deal with date times and sleep lengths

  static int mapTimeToPlot(ZonedDateTime time, ZonedDateTime referenceTime) {
    if (time == ZonedDateTime.now().nan) {
      return 0;
    }
    return (time.toLocal().epochMilliseconds -
            referenceTime.toLocal().epochMilliseconds) ~/
        1000;
  }

  static Array toArray(List<int> list) {
    final Array array = Array.empty();
    for (int i = 0; i < list.length; i++) {
      array.add(list[i].toDouble());
    }
    return array;
  }

  static int findMinSleepStart(TimeSeries<SleepSummary> timeSeries) {
    final TimeSeries<SleepSummary> localTimeSeries = TimeSeries<SleepSummary>(
      values: <SleepSummary>[...timeSeries.values],
      timestamps: <ZonedDateTime>[...timeSeries.timestamps],
      confidenceIntervalLow: <SleepSummary>[
        ...timeSeries.confidenceIntervalLow
      ],
      confidenceIntervalHigh: <SleepSummary>[
        ...timeSeries.confidenceIntervalHigh
      ],
      confidence: <double>[...timeSeries.confidence],
    );

    for (int i = timeSeries.timestamps.length - 1; i >= 0; i--) {
      if (timeSeries.values[i].sleepStart == ZonedDateTime.now().nan) {
        localTimeSeries.timestamps.removeAt(i);
        localTimeSeries.values.removeAt(i);
      }
    }

    final array = toArray(
      localTimeSeries.timestamps.zip(
        localTimeSeries.values,
        (ZonedDateTime reference, SleepSummary summary) {
          return -summary.sleepStart.difference(reference).inSeconds;
        },
      ).toList(),
    );

    if (array.isEmpty) {
      return -3 * 60 * 60;
    }

    final int minIndex = arrayArgMax(array);

    return _truncateToHours(localTimeSeries.values[minIndex].sleepStart)
                .subtract(const Duration(hours: 2))
                .epochMilliseconds ~/
            1000 -
        localTimeSeries.timestamps[minIndex].epochMilliseconds ~/ 1000;
  }

  static int findMaxSleepEnd(TimeSeries<SleepSummary> timeSeries) {
    final TimeSeries<SleepSummary> localTimeSeries = TimeSeries<SleepSummary>(
      values: <SleepSummary>[...timeSeries.values],
      timestamps: <ZonedDateTime>[...timeSeries.timestamps],
      confidenceIntervalLow: <SleepSummary>[
        ...timeSeries.confidenceIntervalLow
      ],
      confidenceIntervalHigh: <SleepSummary>[
        ...timeSeries.confidenceIntervalHigh
      ],
      confidence: <double>[...timeSeries.confidence],
    );

    for (int i = timeSeries.timestamps.length - 1; i >= 0; i--) {
      if (timeSeries.values[i].sleepEnd == ZonedDateTime.now().nan) {
        localTimeSeries.timestamps.removeAt(i);
        localTimeSeries.values.removeAt(i);
      }
    }

    final array = toArray(localTimeSeries.timestamps.zip(
      localTimeSeries.values,
      (ZonedDateTime reference, SleepSummary summary) {
        return summary.sleepEnd.difference(reference).inSeconds;
      },
    ).toList());

    if (array.isEmpty) {
      return 8 * 60 * 60;
    }

    final int maxIndex = arrayArgMax(array);

    return _truncateToHours(localTimeSeries.values[maxIndex].sleepEnd)
                .add(const Duration(hours: 2))
                .epochMilliseconds ~/
            1000 -
        localTimeSeries.timestamps[maxIndex].epochMilliseconds ~/ 1000;
  }

  static Pair<int, int> lengthFromSleepWake(ZonedDateTime sleepStart,
      ZonedDateTime sleepStop, ZonedDateTime referenceTime) {
    return Pair<int, int>(
      mapTimeToPlot(sleepStop, referenceTime),
      mapTimeToPlot(sleepStart, referenceTime),
    );
  }

  static DateTime getDateOnly(DateTime toTruncate) {
    return DateTime(toTruncate.year, toTruncate.month, toTruncate.day);
  }

  static ZonedDateTime _truncateToHours(ZonedDateTime toTruncate) {
    // return DateTime(
    //   toTruncate.year,
    //   toTruncate.month,
    //   toTruncate.day,
    //   toTruncate.hour,
    // );
    return toTruncate.truncate(to: TimeUnit.hours);
  }

  static List<List<Point<double>>> calculatePointsForData(
      List<double> data, double width, double height,
      {bool reverse = false}) {
    List<Point<double>> points = List<Point<double>>.empty(growable: true);
    final double bottomY = height * 0.7;
    final double topY = height * 0.35;
    final double xDiff = width / data.length;

    final double maxData = data.safeMax();

    final List<List<Point<double>>> segments =
        List<List<Point<double>>>.empty(growable: true);

    final Iterable<double> data2 = reverse ? data.reversed : data;

    for (int i = 0; i < data2.length; i++) {
      if (!data2.elementAt(i).isNaN) {
        final double y =
            bottomY - (data2.elementAt(i) / maxData * bottomY) + topY;
        if (reverse) {
          points.add(Point<double>(xDiff * (data2.length - i) + xDiff / 2, y));
        } else {
          points.add(Point<double>(xDiff * i + xDiff / 2, y));
        }
      } else {
        if (points.isNotEmpty) {
          segments.add(points);
          points = List<Point<double>>.empty(growable: true);
        }
      }
    }

    if (points.isNotEmpty) segments.add(points);

    return segments;
  }

  static Pair<List<Point<double>>, List<Point<double>>>
      calculateConnectionPointsForBezierCurveSmall(List<Point<double>> points) {
    final List<Point<double>> conPoint1 =
        List<Point<double>>.empty(growable: true);
    final List<Point<double>> conPoint2 =
        List<Point<double>>.empty(growable: true);

    for (int i = 1; i < points.length; i++) {
      conPoint1.add(
          Point<double>((points[i].x + points[i - 1].x) / 2, points[i - 1].y));
      conPoint2
          .add(Point<double>((points[i].x + points[i - 1].x) / 2, points[i].y));
    }

    return Pair<List<Point<double>>, List<Point<double>>>(conPoint1, conPoint2);
  }

  static Path cubicPath(List<Point<double>> points,
      Pair<List<Point<double>>, List<Point<double>>> connPoints, double bias) {
    final Path path = Path();
    path.moveTo(points.first.x + bias, points.first.y);
    for (int i = 1; i < points.length; i++) {
      path.cubicTo(
          connPoints.first[i - 1].x,
          connPoints.first[i - 1].y,
          connPoints.second[i - 1].x,
          connPoints.second[i - 1].y,
          points[i].x,
          points[i].y);
    }
    return path;
  }

  static List<Path> barWithCubicPath(
      List<Point<double>> points,
      Pair<List<Point<double>>, List<Point<double>>> connPoints,
      double bias,
      double height) {
    final List<Path> listBars = List<Path>.empty(growable: true);

    for (int i = 1; i < points.length; i++) {
      final Path path2 = Path();
      path2.moveTo(points[i - 1].x + bias, points[i - 1].y);

      path2.cubicTo(
          connPoints.first[i - 1].x,
          connPoints.first[i - 1].y,
          connPoints.second[i - 1].x,
          connPoints.second[i - 1].y,
          points[i].x - bias,
          points[i].y);

      path2.lineTo(points[i].x - bias, height);
      path2.lineTo(points[i - 1].x + bias, height);
      path2.close();

      listBars.add(path2);
    }

    return listBars;
  }
}
