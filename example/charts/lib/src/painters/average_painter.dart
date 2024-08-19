import 'dart:math';


import 'package:flutter/material.dart';
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

class AveragePainter extends CustomPainter {
  final Color color;
  final List<Point<double>> points;

  AveragePainter({
    required this.color,
    required this.points,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double averageValue =
        points.map((Point<double> point) => point.y).toList().safeAverage();

    const int dashWidth = 11;
    const int dashSpace = 3;
    double currentX = 0.0;
    while (currentX < size.width) {
      path.moveTo(currentX, averageValue);
      path.lineTo(currentX + dashWidth, averageValue);
      currentX += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
