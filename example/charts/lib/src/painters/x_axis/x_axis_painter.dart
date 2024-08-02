import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sugar/sugar.dart' as sugar;

import '../../../charts.dart';
import '../../utils/chart_utils.dart';

class XAxisPainter extends CustomPainter {
  Color color;
  Color weekEnds;
  Color workDays;
  double selectedPoint = -1.0;
  List<double> data;
  List<sugar.ZonedDateTime> timestamps;
  ChartMode chartMode;
  double selectedXDouble;
  bool isHorizontalBias;
  double horizontalBias;
  bool isLarge;

  XAxisPainter({
    required this.data,
    required this.timestamps,
    required this.color,
    required this.weekEnds,
    required this.workDays,
    required this.chartMode,
    required this.selectedXDouble,
    this.isHorizontalBias = false,
    this.isLarge = false,
  })  : horizontalBias = isLarge
            ? chartMode != ChartMode.weeks
                ? 9.0
                : 24.0
            : chartMode != ChartMode.weeks
                ? 8.0
                : 20.0,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    const double minVal = 0.0;
    const double maxVal = 100.0;

    final double height = size.height;
    final double width = size.width;
    const double lineStroke = 1.0;

    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    final List<sugar.ZonedDateTime> ts = switch (chartMode) {
      ChartMode.days => timestamps.takeLast(14),
      ChartMode.weeks => timestamps.takeLast(6),
      ChartMode.months => timestamps.takeLast(12),
    };

    final List<Point<double>> flatPointsList =
        ChartUtils.calculatePointsForDataGeneralFlat(
      data: data,
      width: width,
      height: height,
      reverse: false,
      maxVal: maxVal,
      minVal: minVal,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
    );

    final int selectedPoint = ChartUtils.findClosest(
      flatPointsList.map((Point<double> e) => e.x).toList(),
      selectedXDouble,
    );

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

    for (int step = 0; step < ts.length; step++) {
      final double xP =
          (stepVerticalLines + lineStroke) * step + horizontalBias;

      final TextSpan textSpan = TextSpan(
        text: switch (chartMode) {
          ChartMode.days => intl.DateFormat('E').format(ts[step].toLocal().toNative()).substring(0, 2),
          ChartMode.weeks =>
            'Week ${ts[step].weekOfYear}',
          ChartMode.months => intl.DateFormat('LLL').format(ts[step].toLocal().toNative()).substring(0, 3),
        },
        style: TextStyle(
          color: selectedPoint == step && selectedXDouble > 0
              ? color
              : !<int>[DateTime.sunday, DateTime.saturday]
                          .contains(timestamps[step].weekday) ||
                      chartMode != ChartMode.days
                  ? workDays
                  : weekEnds,
          fontSize: 10,
        ),
      );

      final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: textSpan,
        textAlign: TextAlign.center,
      );
      textPainter.layout(
        maxWidth: size.width,
      );

      final double xCenter = xP - textPainter.width / 2;
      final Offset offset = Offset(xCenter, (height - textPainter.height) / 2);

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
