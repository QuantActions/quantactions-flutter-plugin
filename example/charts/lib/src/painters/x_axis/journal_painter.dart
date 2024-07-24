import 'dart:math';

import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';

class JournalPainter extends CustomPainter {
  Color color;
  Color grey;
  List<bool> journal;
  ChartMode chartMode;
  bool isHorizontalBias;
  double horizontalBias;
  double selectedXDouble;

  JournalPainter({
    required this.journal,
    required this.color,
    required this.grey,
    required this.chartMode,
    required this.selectedXDouble,
    this.isHorizontalBias = false,
  })  : horizontalBias = chartMode != ChartMode.weeks ? 9.0 : 24.0,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    const double lineStroke = 1.0;
    const double minVal = 0.0;
    const double maxVal = 100.0;

    final List<Point<double>> flatPointsList =
    ChartUtils.calculatePointsForDataGeneralFlat(
      data: List<double>.generate(journal.length, (int index) => 0.0),
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

    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

    final Paint paintXAxisCircleSelected = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint paintXAxisCircle = Paint()
      ..color = grey
      ..style = PaintingStyle.fill;

    for (int step = 0; step < journal.length; step++) {
      final double xP =
          (stepVerticalLines + lineStroke) * step + horizontalBias;

      if (journal[step]) {
        canvas.drawCircle(
          Offset(xP, size.height / 2),
          3,
          selectedPoint == step ? paintXAxisCircleSelected : paintXAxisCircle,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
