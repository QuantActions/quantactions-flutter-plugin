import 'dart:math';


import 'package:charts/src/utils/extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:sugar/sugar.dart' as sugar;

import '../../../charts.dart';
import '../../models/sleep_length.dart';
import '../../utils/chart_utils.dart';
import '../average_painter.dart';
import '../grid_painter.dart';

class InterruptedBarPlotPainter extends CustomPainter {
  final Color color;
  final Color meshColor;
  final ChartMode chartMode;
  final TimeSeries<SleepSummary> timeSeries;
  final double selectedXDouble;
  final int minHour;
  final int maxHour;
  final double horizontalBias;
  final int nHorizontalLines;

  InterruptedBarPlotPainter({
    required this.timeSeries,
    required this.color,
    required this.meshColor,
    required this.chartMode,
    required this.selectedXDouble,
    required this.minHour,
    required this.maxHour,
    required this.nHorizontalLines
  })  : horizontalBias = chartMode != ChartMode.weeks ? 9.0 : 24.0,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    const int paddingText = 5;

    final double height = size.height;
    final double width = size.width;
    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    GridPainter(
      meshColor: meshColor,
      chartMode: chartMode,
      horizontalBias: horizontalBias,
      nHorizontalLines: nHorizontalLines,
    ).paint(canvas, size);

    final Iterable<Pair<int, int>> bottomTops = timeSeries.timestamps.mapIndexed(
      (int index, sugar.ZonedDateTime e) => ChartUtils.lengthFromSleepWake(
        timeSeries.values[index].sleepStart,
        timeSeries.values[index].sleepEnd,
        e,
      ),
    );

    final List<Point<double>> flatPointsList = ChartUtils.calculatePointsForDataGeneralFlat(
      data: bottomTops.map((Pair<int, int> e) => e.first.toDouble() - minHour).toList(),
      width: width,
      height: height,
      reverse: false,
      maxVal: (maxHour - minHour).toDouble(),
      minVal: 0,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
    );

    final List<List<Point<double>>> pointsTop = ChartUtils.calculatePointsForDataGeneral(
      data: bottomTops.map((Pair<int, int> e) => e.first.toDouble() - minHour).toList(),
      width: width,
      height: height,
      reverse: false,
      maxVal: (maxHour - minHour).toDouble(),
      minVal: 0,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: true,
    );

    final List<List<Point<double>>> pointsBottom = ChartUtils.calculatePointsForDataGeneral(
      data: bottomTops.map((Pair<int, int> e) => e.second.toDouble() - minHour).toList(),
      width: width,
      height: height,
      reverse: false,
      maxVal: (maxHour - minHour).toDouble(),
      minVal: 0,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: true,
    );

    final List<List<Point<double>>> pointsTopFiltered = ChartUtils.calculatePointsForDataGeneral(
      data: bottomTops.map((Pair<int, int> e) => e.first.toDouble() - minHour).where((element) => element != -minHour).toList(),
      width: width,
      height: height,
      reverse: false,
      maxVal: (maxHour - minHour).toDouble(),
      minVal: 0,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: true,
    );

    final List<List<Point<double>>> pointsBottomFiltered = ChartUtils.calculatePointsForDataGeneral(
      data: bottomTops.map((Pair<int, int> e) => e.second.toDouble() - minHour).where((element) => element != -minHour).toList(),
      width: width,
      height: height,
      reverse: false,
      maxVal: (maxHour - minHour).toDouble(),
      minVal: 0,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: true,
    );


    final int selectedPoint = ChartUtils.findClosest(
      flatPointsList.map((Point<double> e) => e.x).toList(),
      selectedXDouble,
    );
    final double selectedY = pointsBottom.flatten()[selectedPoint].y;
    final double selectedX = pointsBottom.flatten()[selectedPoint].x;

    _drawBars(
      canvas: canvas,
      height: height,
      width: width,
      selectedPoint: selectedPoint,
      pointsTop: pointsTop,
      pointsBottom: pointsBottom,
      horizontalBias: horizontalBias,
    );

    AveragePainter(
      color: color,
      points: pointsTopFiltered.expand((List<Point<double>> element) => element).toList(),
    ).paint(canvas, size);

    AveragePainter(
      color: color,
      points: pointsBottomFiltered.expand((List<Point<double>> element) => element).toList(),
    ).paint(canvas, size);

    // final bool isSelectedLastsDay =
    //     chartMode == ChartMode.days && selectedPoint == flatPointsList.length - 1;

    List<List<double>> pointsInterruptions = List<List<double>>.generate(
      timeSeries.timestamps.length,
      (int index) => List<double>.empty(growable: true),
    );
    if (chartMode == ChartMode.days) {
      pointsInterruptions = _drawInterruptions(
        canvas: canvas,
        height: height,
        width: width,
        horizontalBias: horizontalBias,
      );
    }

    final bool isEmptyValue = timeSeries.timestamps[selectedPoint] == sugar.ZonedDateTime.now().nan;
        // core.DateTimeUtils.fromMillisecondsSinceEpoch(0).year;

    // if (selectedXDouble > 0 && !selectedY.isNaN && !isSelectedLastsDay && !isEmptyValue) {
    if (selectedXDouble > 0 && !selectedY.isNaN && !isEmptyValue) {
      final Paint paintBubble = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      _drawSelection(
        canvas: canvas,
        height: height,
        selectedPoint: selectedPoint,
        pointsTop: pointsTop,
      );

      _drawBubble(
        canvas: canvas,
        size: size,
        width: width,
        selectedPoint: selectedPoint,
        selectedX: selectedX,
        selectedY: selectedY,
        nVerticalLines: nVerticalLines,
        horizontalBias: horizontalBias,
        pointsInterruptions: pointsInterruptions,
        paintBubble: paintBubble,
        paddingText: paddingText,
      );

      if (chartMode == ChartMode.days) {
        _drawAwakeBubble(
          canvas: canvas,
          size: size,
          selectedPoint: selectedPoint,
          nVerticalLines: nVerticalLines,
          selectedX: selectedX,
          pointsInterruptions: pointsInterruptions,
          paintBubble: paintBubble,
          paddingText: paddingText,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawBars({
    required Canvas canvas,
    required double height,
    required double width,
    required int selectedPoint,
    required List<List<Point<double>>> pointsTop,
    required List<List<Point<double>>> pointsBottom,
    required double horizontalBias,
  }) {
    final List<Path> paths = List<Path>.empty(growable: true);
    final Paint paintSleep = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint paintSleepSelected = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < pointsTop.length; i++) {
      for (int j = 0; j < pointsTop[i].length; j++) {
        paths.add(
          Path()
            ..moveTo(
              pointsBottom[i][j].x - horizontalBias,
              pointsBottom[i][j].y,
            )
            ..lineTo(
              pointsBottom[i][j].x + horizontalBias,
              pointsBottom[i][j].y,
            )
            ..lineTo(pointsBottom[i][j].x + horizontalBias, pointsTop[i][j].y)
            ..lineTo(pointsBottom[i][j].x - horizontalBias, pointsTop[i][j].y)
            ..close(),
        );
      }
    }

    for (int i = 0; i < paths.length; i++) {

      final bool isLast = i == paths.length - 1;

      if (isLast && chartMode != ChartMode.days){
          final Paint paintSleepTemp = Paint()
            ..color = color.withOpacity(0.2)
            ..style = PaintingStyle.fill;

          canvas.drawPath(
            paths[i],
            (selectedXDouble > 0 && i == selectedPoint) ? paintSleepSelected : paintSleepTemp,
          );

      } else {

        canvas.drawPath(
          paths[i],
          (selectedXDouble > 0 && i == selectedPoint) ? paintSleepSelected : paintSleep,
        );
      }
    }
  }

  void _drawSelection({
    required Canvas canvas,
    required double height,
    required int selectedPoint,
    required List<List<Point<double>>> pointsTop,
  }) {
    final double selectedY = pointsTop.flatten()[selectedPoint].y;
    final double selectedX = pointsTop.flatten()[selectedPoint].x;

    final Paint paintSleepHighlightBottom = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final Path pathsHighlightBottom = Path();
    pathsHighlightBottom
      ..moveTo(selectedX - horizontalBias, selectedY)
      ..lineTo(selectedX + horizontalBias, selectedY)
      ..lineTo(selectedX + horizontalBias, height + 105)
      ..lineTo(selectedX - horizontalBias, height + 105)
      ..close();

    canvas.drawPath(pathsHighlightBottom, paintSleepHighlightBottom);
  }

  List<List<double>> _drawInterruptions({
    required Canvas canvas,
    required double height,
    required double width,
    required double horizontalBias,
  }) {
    final List<List<double>> pointsInterruptions = List<List<double>>.generate(
      timeSeries.timestamps.length,
      (int index) => List<double>.empty(growable: true),
    );
    final List<Path> pathsInterruptions = List<Path>.empty(growable: true);
    final double widthInterruption = horizontalBias / 2;
    const double heightInterruption = 4.0;

    for (int i = 0; i < timeSeries.timestamps.length; i++) {
      final SleepSummary sleepSummary = timeSeries.values[i];
      final sugar.ZonedDateTime t = timeSeries.timestamps[i];
      final List<sugar.ZonedDateTime> interruptions = sleepSummary.interruptionsStart;
      final double xDiff = (width - (horizontalBias * 2)) / (timeSeries.timestamps.length - 1);
      final double xP = xDiff * i + horizontalBias;

      final List<Point<double>> points = ChartUtils.calculatePointsForDataGeneral(
        data: interruptions
            .map((sugar.ZonedDateTime e) => ChartUtils.mapTimeToPlot(e, t).toDouble() - minHour)
            .toList(),
        width: width,
        height: height,
        reverse: false,
        maxVal: (maxHour - minHour).toDouble(),
        minVal: 0,
        horizontalBias: horizontalBias,
        includeOutOfChartLeft: false,
        fromTop: true,
      ).flatten();

      for (final Point<double> point in points) {
        pointsInterruptions[i].add(point.y);
        final Path path = Path();

        path.moveTo(xP - widthInterruption, point.y - heightInterruption);
        path.lineTo(xP + widthInterruption, point.y - heightInterruption);
        path.lineTo(xP + widthInterruption, point.y + heightInterruption);
        path.lineTo(xP - widthInterruption, point.y + heightInterruption);
        path.close();
        pathsInterruptions.add(path);
      }
    }

    final Paint paintInterruptions = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < pathsInterruptions.length; i++) {
      canvas.drawPath(pathsInterruptions[i], paintInterruptions);
    }

    return pointsInterruptions;
  }

  void _drawBubble({
    required Canvas canvas,
    required Size size,
    required double width,
    required int selectedPoint,
    required double selectedX,
    required double selectedY,
    required int nVerticalLines,
    required double horizontalBias,
    required List<List<double>> pointsInterruptions,
    required Paint paintBubble,
    required int paddingText,
  }) {
    final intl.DateFormat formatterHours = intl.DateFormat('HH:mm');

    final sugar.ZonedDateTime selectedSleepStart = timeSeries.values[selectedPoint].sleepStart;//.toLocal();
    final sugar.ZonedDateTime selectedSleepEnd = timeSeries.values[selectedPoint].sleepEnd;//.toLocal();

    // print('Selected sleep start: $selectedSleepStart');
    // print('Selected sleep end: $selectedSleepEnd');

    final SleepLength sl = SleepLength.sleepLengthBy(
      sleepStartInitial: selectedSleepStart,
      sleepStop: selectedSleepEnd,
    );

    final TextSpan textSpan = TextSpan(
      children: <InlineSpan>[
        TextSpan(
          text:
              '${formatterHours.format(selectedSleepStart.toLocal().toNative())} - ${formatterHours.format(selectedSleepEnd.toLocal().toNative())}\n',
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        TextSpan(
          text: '(${sl.hours}h ${sl.minutes}min)',
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ],
    );

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: textSpan,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      maxWidth: size.width,
    );

    final num xCenter = (selectedX - textPainter.width / 2).clamp(
      paddingText,
      width - textPainter.width + paddingText,
    );
    final double yCenter = selectedY - textPainter.height - paddingText - 9;
    final Offset offset = Offset(xCenter.toDouble(), yCenter);

    final double xPos = selectedX;
    final Path trianglePath = Path();

    trianglePath.moveTo(xPos, selectedY);
    trianglePath.lineTo(xPos - 12 / 2, selectedY - 10);
    trianglePath.lineTo(xPos + 12 / 2, selectedY - 10);
    trianglePath.close();
    canvas.drawPath(trianglePath, paintBubble);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (selectedX - paddingText - textPainter.width / 2).clamp(0, width - textPainter.width),
          selectedY - textPainter.height - paddingText * 2 - 9,
          textPainter.width + paddingText * 2,
          textPainter.height + paddingText * 2,
        ),
        const Radius.circular(4.0),
      ),
      paintBubble,
    );

    textPainter.paint(canvas, offset);
  }

  void _drawAwakeBubble({
    required Canvas canvas,
    required Size size,
    required int selectedPoint,
    required int nVerticalLines,
    required double selectedX,
    required List<List<double>> pointsInterruptions,
    required Paint paintBubble,
    required int paddingText,
  }) {
    final StringBuffer string = StringBuffer('awake:');
    final intl.DateFormat formatterHours = intl.DateFormat('HH:mm');

    final List<sugar.LocalDateTime> selectedInterruptions =
        timeSeries.values[selectedPoint].interruptionsStart
            .map((sugar.ZonedDateTime e) => e.toLocal())
            .toList();

    for (int i = 0; i < selectedInterruptions.length; i++) {
      final sugar.LocalDateTime interruption = selectedInterruptions[i];
      string.write('\n${formatterHours.format(interruption.toNative())}');
    }
    final TextSpan textSpanInt = TextSpan(
      text: string.toString(),
      style: const TextStyle(color: Colors.white, fontSize: 13),
    );

    final TextPainter textPainterInt = TextPainter(
      textDirection: TextDirection.ltr,
      text: textSpanInt,
      textAlign: TextAlign.left,
    );
    textPainterInt.layout(
      maxWidth: size.width,
    );

    if (selectedInterruptions.isNotEmpty) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (selectedPoint > nVerticalLines / 2)
                ? (selectedX - paddingText * 2 - textPainterInt.width - horizontalBias * 2)
                : (selectedX + horizontalBias * 2),
            pointsInterruptions[selectedPoint].reduce(min) - 9,
            textPainterInt.width + paddingText * 2,
            textPainterInt.height + paddingText * 2,
          ),
          const Radius.circular(4.0),
        ),
        paintBubble,
      );

      final double xCenterInt = (selectedPoint > nVerticalLines / 2)
          ? selectedX - paddingText - textPainterInt.width - horizontalBias * 2
          : selectedX + paddingText + horizontalBias * 2;
      final double yCenterInt = pointsInterruptions[selectedPoint].reduce(min) - 9 + paddingText;
      final Offset offsetInt = Offset(xCenterInt, yCenterInt);

      textPainterInt.paint(canvas, offsetInt);
    }
  }
}
