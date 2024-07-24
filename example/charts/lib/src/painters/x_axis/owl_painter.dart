import 'dart:math';

import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';

class OwlPainter extends CustomPainter {
  Color color;
  Color textColor;
  ChartMode chartMode;
  List<double> score;
  bool isHorizontalBias;
  double horizontalBias;
  double selectedXDouble;
  bool isLarge;

  OwlPainter({
    required this.color,
    required this.textColor,
    required this.chartMode,
    required this.score,
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
      data: List<double>.generate(score.length, (int index) => 0.0),
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

    for (int step = 0; step < score.length; step++) {
      final double xP =
          (stepVerticalLines + lineStroke) * step + horizontalBias;

      _drawData(
        canvas: canvas,
        size: size,
        height: height,
        xP: xP,
        data: score[step],
        isTemp: false,
        isSelected: selectedPoint == step && selectedXDouble > 0,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawData({
    required Canvas canvas,
    required Size size,
    required double height,
    required double xP,
    required double data,
    required bool isTemp,
    required bool isSelected,
  }) {
    final TextSpan textSpan = TextSpan(
      text: data.toInt().toString(),
      style: TextStyle(
        color: isSelected
            ? color
            : data > 0
                ? textColor
                : textColor.withOpacity(0.5),
        fontSize: 12,
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
      Offset(xP - textPainter.width / 2, -textPainter.height / 2),
    );
  }
}
