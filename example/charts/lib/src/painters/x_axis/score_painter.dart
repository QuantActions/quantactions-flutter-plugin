import 'dart:math';

import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';

class ScorePainter extends CustomPainter {
  Color color;
  ChartMode chartMode;
  List<double> scores;
  bool isHorizontalBias;
  double horizontalBias;
  double selectedXDouble;
  bool isLarge;

  ScorePainter({
    required this.color,
    required this.chartMode,
    required this.scores,
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
    const double lineStroke = 1.0;

    final double height = size.height;
    final double width = size.width;

    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

    final List<Point<double>> flatPointsList =
        ChartUtils.calculatePointsForDataGeneralFlat(
      data: List<double>.generate(scores.length, (int index) => 0.0),
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

    for (int step = 0; step < scores.length; step++) {
      final double xP =
          (stepVerticalLines + lineStroke) * step + horizontalBias;

      if (scores[step] != 0) {
        if (!scores[step].isNaN) {
          _drawScore(
            canvas: canvas,
            size: size,
            xP: xP,
            data: scores[step],
            isTemp: false,
            isSelected: selectedPoint == step,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawScore({
    required Canvas canvas,
    required Size size,
    required double xP,
    required double data,
    required bool isTemp,
    required bool isSelected,
  }) {
    const double containerWidth = 18;
    const double containerHeight = 12;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint paintTemp = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(xP, 0),
          width: containerWidth,
          height: containerHeight,
        ),
        const Radius.circular(6),
      ),
      isTemp && !isSelected ? paintTemp : paint,
    );

    final TextSpan textSpan = TextSpan(
      text: data.toInt().toString(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 9,
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

    textPainter.paint(
      canvas,
      Offset(xP - textPainter.width / 2, -containerHeight / 2 + 1),
    );
  }
}
