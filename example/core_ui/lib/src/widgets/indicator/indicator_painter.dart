import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class IndicatorPainter extends CustomPainter {
  final bool shouldRepaintIndicator;
  final bool isLastAnimationIteration;
  final double percentValue;
  final Color color;
  final Color colorLight;
  final double internalCircleStrokeWidth;
  final double progressCircleStrokeWidth;

  const IndicatorPainter({
    required this.shouldRepaintIndicator,
    required this.isLastAnimationIteration,
    required this.percentValue,
    required this.color,
    required this.colorLight,
    required this.internalCircleStrokeWidth,
    required this.progressCircleStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int outputEnd = 98;
    const int outputStart = 0;
    const int inputEnd = 100;
    const int inputStart = 0;
    const double slope = 1.0 * (outputEnd - outputStart) / (inputEnd - inputStart);

    // Convert the dataUsage to angle
    final double ratio = outputStart + slope * (percentValue - inputStart);
    final double sweepAngle = ratio * 360 / 100;

    final double centerPoint = size.height / 2;

    // create a solid paint object to draw the circles
    final Paint solidPaint = Paint()
      ..color = colorLight
      ..style = PaintingStyle.fill;

    final Paint strokePaintWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = internalCircleStrokeWidth
      ..style = PaintingStyle.stroke;

    final double speedFactor = percentValue * 3.6 * 1.2;

    // create a paint object to draw the circles
    final Paint paint = Paint()
      ..shader = SweepGradient(
        colors: <Color>[Colors.white, color],
        stops: <double>[0.0, percentValue / 100],
        tileMode: TileMode.repeated,
        startAngle: isLastAnimationIteration ? math.radians(270) : math.radians(270 + speedFactor),
        endAngle: isLastAnimationIteration
            ? math.radians(270 + 360)
            : math.radians(270 + speedFactor + 360),
      ).createShader(
        Rect.fromCircle(
          center: Offset(centerPoint, centerPoint),
          radius: 0,
        ),
      )
      ..strokeWidth = progressCircleStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // create a path object to draw the arc
    final Path path = Path();

    // draw the outer circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 2,
      solidPaint,
    );

    // draw the inner circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 2 * 0.8,
      strokePaintWhite,
    );

    // draw the arc
    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.height * 0.8,
        height: size.height * 0.8,
      ),
      isLastAnimationIteration ? math.radians(-90 + 7) : math.radians(-90 + speedFactor + 7),
      math.radians(sweepAngle),
      true,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return shouldRepaintIndicator;
  }
}
