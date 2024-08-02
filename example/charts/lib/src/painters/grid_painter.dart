import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../utils/chart_utils.dart';

class GridPainter extends CustomPainter {

  static const double horizontalBiasDef = 8.0;
  static const double lineStroke = 1.0;

  final Color meshColor;
  final ChartMode chartMode;
  final bool isVertical;
  final double horizontalBias;
  final int nHorizontalLines;

  GridPainter({
    required this.meshColor,
    required this.chartMode,
    this.isVertical = true,
    this.horizontalBias = horizontalBiasDef,
    this.nHorizontalLines = 11,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);
    final double stepHorizontalLines =
        (height - lineStroke * (nHorizontalLines - 1)) / (nHorizontalLines - 1);

    final Path pathHorizontal = Path();
    final Paint paintGrid = Paint()
      ..color = meshColor
      ..strokeWidth = lineStroke
      ..style = PaintingStyle.stroke;

    pathHorizontal.moveTo(0, 0);
    for (int step = 0; step < nHorizontalLines; step++) {
      pathHorizontal.lineTo(
        width,
        (stepHorizontalLines + lineStroke) * step + lineStroke / 2,
      );
      pathHorizontal.moveTo(
        0,
        (stepHorizontalLines + lineStroke) * (step + 1) + lineStroke / 2,
      );
    }
    canvas.drawPath(pathHorizontal, paintGrid);

    if (isVertical) {
      final Path pathVertical = Path();
      pathVertical.moveTo(horizontalBias, 0);
      for (int step = 0; step < nVerticalLines; step++) {
        pathVertical.lineTo(
          (stepVerticalLines + lineStroke) * step + horizontalBias,
          height + lineStroke,
        );
        pathVertical.moveTo(
          (stepVerticalLines + lineStroke) * (step + 1) + horizontalBias,
          0,
        );
      }

      canvas.drawPath(pathVertical, paintGrid);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
