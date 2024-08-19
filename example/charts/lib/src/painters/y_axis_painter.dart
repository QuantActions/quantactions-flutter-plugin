import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';

import '../models/y_axis_type.dart';
import '../utils/chart_utils.dart';

class YAxisPainter extends CustomPainter {
  static const double lineStroke = 1.0;

  final Color color;
  final List<Object?> data;
  final bool adaptiveRange;
  final YAxisType yAxisType;
  double maxValRequested;
  double minValRequested;

  YAxisPainter({
    required this.data,
    required this.color,
    required this.yAxisType,
    this.maxValRequested = 100.0,
    this.minValRequested = 0.0,
    this.adaptiveRange = false,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    int nHorizontalLines = 11;

    switch (yAxisType) {
      case YAxisType.timeOfDay:
        nHorizontalLines = data.length;
        break;
      default:
        nHorizontalLines = 11;
        break;
    }

    if (adaptiveRange) {
      // extract the 80th percentile of the data.
      maxValRequested =
          ChartUtils.percentile((data as List<double>).sorted(), 0.8);
      maxValRequested -= maxValRequested % 50.0;
      minValRequested =
          ChartUtils.percentile(data as List<double>, 0.05) * 0.95;
      minValRequested -= minValRequested % 50;
    }

    final double stepHorizontalLines =
        (height - lineStroke * (nHorizontalLines - 1)) / (nHorizontalLines - 1);

    for (int step = 0; step < nHorizontalLines; step++) {
      final String value = switch (yAxisType) {
        YAxisType.timeOfDay => data[step].toString(),
        YAxisType.duration => step == nHorizontalLines - 1
            ? ChartUtils.getHourString(minValRequested)
            : ChartUtils.getHourString(
          minValRequested + (nHorizontalLines - 1 - step) * (maxValRequested - minValRequested) / (nHorizontalLines - 1),
              ),
        YAxisType.scalarDynamic => step == 0
            ? 'ms'
            : (minValRequested + (nHorizontalLines - 1 - step) * (maxValRequested - minValRequested) / (nHorizontalLines - 1))
                .toInt()
                .toString(),
        _ => (maxValRequested /
                    (nHorizontalLines - 1) *
                    (nHorizontalLines - 1 - step) +
                minValRequested)
            .toInt()
            .toString(),
      };

      final TextSpan textSpan = TextSpan(
        text: value,
        style: TextStyle(color: color, fontSize: 12),
      );

      final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: textSpan,
        textAlign: TextAlign.right,
      );
      textPainter.layout(maxWidth: size.width);

      final double yCenter =
          (stepHorizontalLines + lineStroke) * step - textPainter.height / 2;
      final Offset offset = Offset(size.width - textPainter.width - 10, yCenter);

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
