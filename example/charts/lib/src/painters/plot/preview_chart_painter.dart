import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../utils/chart_utils.dart';

class PreviewChartPainter extends CustomPainter {
  Color color;
  List<double> data;

  PreviewChartPainter({
    required this.data,
    required this.color,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double bias = width * 0.01;

    final List<List<Point<double>>> pointsList =
        ChartUtils.calculatePointsForData(data, width, height);
    final List<Pair<List<Point<double>>, List<Point<double>>>> connPointsList =
        pointsList.map(ChartUtils.calculateConnectionPointsForBezierCurveSmall).toList();

    drawBars(
      canvas: canvas,
      size: size,
      bias: bias,
      height: height,
      pointsList: pointsList,
      connPointsList: connPointsList,
    );

    drawLinePlot(
      canvas: canvas,
      bias: bias,
      pointsList: pointsList,
      connPointsList: connPointsList,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawBars({
    required Canvas canvas,
    required Size size,
    required double bias,
    required double height,
    required List<List<Point<double>>> pointsList,
    required List<Pair<List<Point<double>>, List<Point<double>>>> connPointsList,
  }) {
    final double centerPoint = size.height / 2;
    final List<Path> listBars = List<Path>.empty(growable: true);

    for (final int i in pointsList.indices) {
      listBars.addAll(
        ChartUtils.barWithCubicPath(pointsList[i], connPointsList[i], bias, height),
      );
    }

    for (final Path element in listBars) {
      canvas.drawPath(
        element,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Colors.white, color],
            stops: const <double>[0.0, 1.0],
          ).createShader(
            Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 90),
          )
          ..style = PaintingStyle.fill,
      );
    }

    // for (int i = data.length - listBars.length - 1; i > 0; i--) {
    //   final double barWeight = size.width / data.length;
    //   canvas.drawLine(
    //     Offset(size.width - barWeight * (i / 2), height / 2),
    //     Offset(size.width - barWeight * (i / 2), height),
    //     Paint()
    //       ..color = Colors.white
    //       ..strokeWidth = 1
    //       ..style = PaintingStyle.stroke,
    //   );
    // }
  }

  void drawLinePlot({
    required Canvas canvas,
    required double bias,
    required List<List<Point<double>>> pointsList,
    required List<Pair<List<Point<double>>, List<Point<double>>>> connPointsList,
  }) {
    final Iterable<Path> paths = pointsList.zip(
      connPointsList,
      (List<Point<double>> points, Pair<List<Point<double>>, List<Point<double>>> connPoints) =>
          ChartUtils.cubicPath(points, connPoints, bias),
    );

    for (final Path element in paths) {
      canvas.drawPath(
        element,
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      );
    }

    if (pointsList.isNotEmpty) {
      canvas.drawCircle(
          Offset(pointsList.last.last.x - bias, pointsList.last.last.y),
          3,
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
    }
  }
}
