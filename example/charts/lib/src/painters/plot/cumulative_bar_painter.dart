import 'dart:math';


import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';
import '../../utils/date_time_utils.dart';
import '../average_painter.dart';
import '../grid_painter.dart';

class CumulativeBarPainter extends CustomPainter {
  static const double lineStroke = 1.0;
  static const double minVal = 0.0;
  static const double hourInMilliseconds = 3600000;

  final Color meshColor;
  final List<double> data;
  final List<double> totalData;
  final Color totalColor;
  final Color color;
  final ChartMode chartMode;
  final double selectedXDouble;
  final double horizontalBias;
  final double maxVal;

  CumulativeBarPainter({
    required this.data,
    required this.totalData,
    required this.totalColor,
    required this.color,
    required this.meshColor,
    required this.chartMode,
    required this.selectedXDouble,
    required this.maxVal,
  })  : horizontalBias = chartMode != ChartMode.weeks ? 9.0 : 18.0,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;
    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);
    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

    GridPainter(
      meshColor: meshColor,
      chartMode: chartMode,
      horizontalBias: horizontalBias,
      isVertical: chartMode != ChartMode.weeks,
    ).paint(canvas, size);

    final List<Point<double>> flatPointsList =
        ChartUtils.calculatePointsForDataGeneralFlat(
      data: totalData,
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
    final double selectedY = flatPointsList[selectedPoint].y;
    final double selectedX = flatPointsList[selectedPoint].x;

    AveragePainter(
      color: totalColor,
      points: ChartUtils.calculatePointsForDataGeneralFlat(
        data: totalData,
        width: width,
        height: height,
        reverse: false,
        maxVal: maxVal,
        minVal: minVal,
        horizontalBias: horizontalBias,
        includeOutOfChartLeft: false,
      ),
    ).paint(canvas, size);

    AveragePainter(
      color: color,
      points: ChartUtils.calculatePointsForDataGeneralFlat(
        data: data,
        width: width,
        height: height,
        reverse: false,
        maxVal: maxVal,
        minVal: minVal,
        horizontalBias: horizontalBias,
        includeOutOfChartLeft: false,
      ),
    ).paint(canvas, size);

    _drawBars(
      canvas: canvas,
      width: width,
      height: height,
      maxVal: maxVal,
      selectedX: selectedX,
      selectedXDouble: selectedXDouble,
    );

    // final bool isTemp =
    //     chartMode == ChartMode.days && selectedPoint == totalData.length - 1;

    if (selectedXDouble > 0 &&
        !selectedY.isNaN &&
        selectedY != height
        // && !isTemp
    ) {
      _drawSelection(
        canvas: canvas,
        height: height,
        selectedPoint: selectedPoint,
        selectedX: selectedX,
        selectedY: selectedY,
      );

      _drawBubble(
        canvas: canvas,
        size: size,
        width: width,
        height: height,
        selectedY: selectedY,
        selectedX: selectedX,
        selectedPoint: selectedPoint,
        stepVerticalLines: stepVerticalLines,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawSelection({
    required Canvas canvas,
    required double height,
    required int selectedPoint,
    required double selectedX,
    required double selectedY,
  }) {
    final Paint paintSleepHighlightBottom = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final Path pathsHighlightBottom = Path();
    pathsHighlightBottom
      ..moveTo(selectedX - horizontalBias, selectedY)
      ..lineTo(selectedX + horizontalBias, selectedY)
      ..lineTo(selectedX + horizontalBias, height + 120)
      ..lineTo(selectedX - horizontalBias, height + 120)
      ..close();

    canvas.drawPath(pathsHighlightBottom, paintSleepHighlightBottom);
  }

  void _drawBars({
    required Canvas canvas,
    required double width,
    required double height,
    required double selectedX,
    required double maxVal,
    required double selectedXDouble,
  }) {
    final List<Point<double>> pointsListBar =
        ChartUtils.calculatePointsForDataGeneral(
      data: data,
      width: width,
      height: height,
      reverse: false,
      maxVal: maxVal,
      minVal: minVal,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: false,
    ).flatten();

    final List<Point<double>> pointsListTotalBar =
        ChartUtils.calculatePointsForDataGeneral(
      data: totalData,
      width: width,
      height: height,
      reverse: false,
      maxVal: maxVal,
      minVal: minVal,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
      fromTop: false,
    ).flatten();

    final Paint paintTotalBarTemp = Paint()
      ..color = totalColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint paintTotalBar = Paint()
      ..color = totalColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint paintTotalBarSelected = Paint()
      ..color = totalColor
      ..style = PaintingStyle.fill;

    final Paint paintBarTemp = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint paintBar = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint paintBarSelected = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final List<Path> pathsBars = List<Path>.empty(growable: true);

    // final int barsCount = chartMode != ChartMode.days
    //     ? pointsListBar.length
    //     : pointsListBar.length - 1;

    for (int i = 0; i < pointsListBar.length; i++) {
      final Path thisPath = Path();

      thisPath.moveTo(
        pointsListBar[i].x - horizontalBias,
        pointsListBar[i].y,
      );
      thisPath.lineTo(
        pointsListBar[i].x + horizontalBias,
        pointsListBar[i].y,
      );
      thisPath.lineTo(pointsListBar[i].x + horizontalBias, height);
      thisPath.lineTo(pointsListBar[i].x - horizontalBias, height);
      thisPath.close();

      pathsBars.add(thisPath);
      canvas.drawPath(
        thisPath,
        (selectedXDouble > 0 && pointsListBar[i].x == selectedX)
            ? paintBarSelected
            : (i == pointsListBar.length - 1) && (chartMode != ChartMode.days)
            ? paintBarTemp
            : paintBar,
      );

      final Path totalPath = Path();

      totalPath.moveTo(
        pointsListBar[i].x - horizontalBias,
        pointsListTotalBar[i].y,
      );
      totalPath.lineTo(
        pointsListBar[i].x + horizontalBias,
        pointsListTotalBar[i].y,
      );
      totalPath.lineTo(
        pointsListBar[i].x + horizontalBias,
        pointsListBar[i].y,
      );
      totalPath.lineTo(
        pointsListBar[i].x - horizontalBias,
        pointsListBar[i].y,
      );
      totalPath.close();

      pathsBars.add(totalPath);
      canvas.drawPath(
        totalPath,
        (selectedXDouble > 0 && pointsListBar[i].x == selectedX)
            ? paintTotalBarSelected
            : (i == pointsListBar.length - 1) && (chartMode != ChartMode.days)
                ? paintTotalBarTemp
                : paintTotalBar,
      );
    }
  }

  void _drawBubble({
    required Canvas canvas,
    required Size size,
    required double width,
    required double height,
    required double selectedY,
    required double selectedX,
    required int selectedPoint,
    required double stepVerticalLines,
  }) {
    final Paint paintBubble = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final String dateValue = DateTimeUtils.getHourAndMin(
      DateTimeUtils.fromMillisecondsSinceEpoch(
        data[selectedPoint].toInt().coerceAtLeast(60 * 1000),
      ),
    );
    final String dateTotalValue = DateTimeUtils.getHourAndMin(
      DateTimeUtils.fromMillisecondsSinceEpoch(
        totalData[selectedPoint].toInt().coerceAtLeast(60 * 1000),
      ),
    );

    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    final TextSpan textSpan = TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '$dateValue\n',
          style: textStyle.copyWith(fontSize: 14),
        ),
        const TextSpan(
          text: 'from a total of\n',
          style: textStyle,
        ),
        TextSpan(
          text: dateTotalValue,
          style: textStyle,
        ),
      ],
    );

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: textSpan,
      textAlign: TextAlign.center,
    );
    textPainter.layout(maxWidth: size.width);
    const int paddingText = 5;

    final num xCenter = (selectedX - textPainter.width / 2)
        .clamp(paddingText, width - textPainter.width + paddingText);

    final num yCenter = selectedY - textPainter.height - paddingText - 9;
    final Offset offset = Offset(xCenter.toDouble(), yCenter.toDouble());

    final double xPos =
        (stepVerticalLines + lineStroke) * selectedPoint + horizontalBias;

    final Path trianglePath = Path();
    trianglePath.moveTo(xPos, selectedY);
    trianglePath.lineTo(xPos - 12 / 2, selectedY - 10);
    trianglePath.lineTo(xPos + 12 / 2, selectedY - 10);
    trianglePath.close();

    canvas.drawPath(trianglePath, paintBubble);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            (selectedX - paddingText - textPainter.width / 2)
                .clamp(0, width - textPainter.width),
            selectedY - textPainter.height - paddingText * 2 - 9,
            textPainter.width + paddingText * 2,
            textPainter.height + paddingText * 2),
        const Radius.circular(4.0),
      ),
      paintBubble,
    );

    textPainter.paint(canvas, offset);
  }
}
