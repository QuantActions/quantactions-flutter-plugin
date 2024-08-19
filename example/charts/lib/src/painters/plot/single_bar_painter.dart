import 'dart:math';

import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';
import '../average_painter.dart';
import '../grid_painter.dart';

class SingleBarPainter extends CustomPainter {
  final Color color;
  final Color meshColor;
  final ChartMode chartMode;
  final List<double> data;
  final double selectedXDouble;
  final double maxValRequested;
  final double minValRequested;
  final bool adaptiveRange;
  final double horizontalBias;

  SingleBarPainter({
    required this.data,
    required this.color,
    required this.meshColor,
    required this.chartMode,
    required this.selectedXDouble,
    this.maxValRequested = 100.0,
    this.minValRequested = 0.0,
    this.adaptiveRange = false,
  })  : horizontalBias = chartMode != ChartMode.weeks ? 9.0 : 24.0,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;
    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    GridPainter(
      meshColor: meshColor,
      chartMode: chartMode,
      horizontalBias: horizontalBias,
    ).paint(canvas, size);

    final List<Point<double>> flatPointsList =
        ChartUtils.calculatePointsForDataGeneralFlat(
      data: data,
      width: width,
      height: height,
      reverse: false,
      maxVal: maxValRequested,
      minVal: minValRequested,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: false,
    );

    final int selectedPoint = ChartUtils.findClosest(
        flatPointsList.map((Point<double> e) => e.x).toList(), selectedXDouble);
    final double selectedY = flatPointsList[selectedPoint].y;
    final double selectedX = flatPointsList[selectedPoint].x;

    _drawBars(
      canvas: canvas,
      height: height,
      selectedX: selectedX,
      points: flatPointsList,
    );

    AveragePainter(
      color: color,
      points: flatPointsList,
    ).paint(canvas, size);

    if (!selectedY.isNaN &&
        selectedY != height &&
        selectedXDouble > 0
    // &&
        // !(chartMode == ChartMode.days &&
        //     selectedPoint == flatPointsList.length - 1)
    ) {
      _drawSelection(
        canvas: canvas,
        size: size,
        width: width,
        height: height,
        selectedPoint: selectedPoint,
        selectedX: selectedX,
        selectedY: selectedY,
        nVerticalLines: nVerticalLines,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawBars({
    required Canvas canvas,
    required double height,
    required double selectedX,
    required List<Point<double>> points,
  }) {
    final List<Path> pathsBars = List<Path>.empty(growable: true);

    final Paint paintBar = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint paintBarTemp = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint paintBarSelected = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // final int barsCount =
    //     chartMode != ChartMode.days ? points.length : points.length - 1;

    for (int i = 0; i < points.length; i++) {
      if (points[i].y.isNaN) {
        continue;
      }
      final Path thisPath = Path();

      thisPath.moveTo(
        points[i].x - horizontalBias,
        points[i].y,
      );
      thisPath.lineTo(
        points[i].x + horizontalBias,
        points[i].y,
      );
      thisPath.lineTo(points[i].x + horizontalBias, height);
      thisPath.lineTo(points[i].x - horizontalBias, height);
      thisPath.close();

      pathsBars.add(thisPath);
      canvas.drawPath(
        thisPath,
        (selectedXDouble > 0 && points[i].x == selectedX)
            ? paintBarSelected
            : i == points.length - 1
                ? paintBarTemp
                : paintBar,
      );
    }
  }

  void _drawSelection({
    required Canvas canvas,
    required Size size,
    required double width,
    required double height,
    required int selectedPoint,
    required double selectedX,
    required double selectedY,
    required int nVerticalLines,
  }) {
    const double lineStroke = 1.0;

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

    final Paint paintBubble = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final TextSpan textSpan = TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '${data[selectedPoint].toInt()}ms',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
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

    final num xCenter = (selectedX - textPainter.width / 2).clamp(
      paddingText,
      width - textPainter.width + paddingText,
    );

    final double yCenter = selectedY - textPainter.height - paddingText - 9;
    final Offset offset = Offset(xCenter.toDouble(), yCenter);

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

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
          textPainter.height + paddingText * 2,
        ),
        const Radius.circular(4.0),
      ),
      paintBubble,
    );

    textPainter.paint(canvas, offset);
  }
}
