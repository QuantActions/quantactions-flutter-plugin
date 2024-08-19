import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';
import '../grid_painter.dart';

class MultiLinePlotPainter extends CustomPainter {
  static const double horizontalBias = 8.0;
  static const double minVal = 0.0;
  static const double maxVal = 100.0;

  final Color meshColor;
  final List<Color> colors;
  final List<List<double>> data;
  final List<List<double>?> confidenceIntervalLow;
  final List<List<double>?> confidenceIntervalHigh;
  final List<bool> activities;
  final ChartMode chartMode;

  MultiLinePlotPainter({
    required this.meshColor,
    required this.colors,
    required this.data,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.activities,
    required this.chartMode,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    GridPainter(meshColor: meshColor, chartMode: chartMode).paint(canvas, size);

    for (int i = 0; i < data.length; i++) {
      if (activities[i]) {
        _drawCurve(
          canvas: canvas,
          height: height,
          width: width,
          color: colors[i],
          data: data[i],
          confidenceIntervalLow: confidenceIntervalLow[i],
          confidenceIntervalHigh: confidenceIntervalHigh[i],
        );

        _drawMarkers(
          canvas: canvas,
          height: height,
          width: width,
          color: colors[i],
          data: data[i],
          drawLast: chartMode == ChartMode.days
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawCurve({
    required Canvas canvas,
    required double height,
    required double width,
    required List<double> data,
    required List<double>? confidenceIntervalLow,
    required List<double>? confidenceIntervalHigh,
    required Color color,
  }) {
    final List<List<Point<double>>> pointsList =
        ChartUtils.calculatePointsForDataGeneral(
      data: data,
      width: width,
      height: height,
      reverse: false,
      maxVal: maxVal,
      minVal: minVal,
      horizontalBias: horizontalBias,
      includeOutOfChartLeft: true,
      fromTop: false,
    );

    final List<Pair<List<Point<double>>, List<Point<double>>>> connPointsList =
        pointsList
            .map(ChartUtils.calculateConnectionPointsForBezierCurve)
            .toList();

    final List<Path> pathList = <Path>[Path()];
    final Paint paintMainLine = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < pointsList.length; i++) {
      final List<Point<double>> points = pointsList[i];
      final Pair<List<Point<double>>, List<Point<double>>> connPoints =
          connPointsList[i];
      pathList.first.moveTo(points.first.x, points.first.y);
      for (int j = 1; j < points.length; j++) {
        if (pointsList[i][j].y == height) {
          pathList.add(Path());
        } else if (pointsList[i][j - 1].y == height) {
          pathList.last.moveTo(points[j].x, points[j].y);
        } else {
          pathList.last.cubicTo(
            connPoints.first[j - 1].x,
            connPoints.first[j - 1].y,
            connPoints.second[j - 1].x,
            connPoints.second[j - 1].y,
            points[j].x,
            points[j].y,
          );
        }
      }
    }

    final List<Path> pathHList = <Path>[Path()];
    final Paint paintConfidenceShading = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;

    for (var path in pathList) {
      canvas.drawPath(path, paintMainLine);
    }

    if (confidenceIntervalHigh != null && confidenceIntervalLow != null) {
      final List<List<Point<double>>> pointsListCIH =
          ChartUtils.calculatePointsForDataGeneral(
        data: confidenceIntervalHigh,
        width: width,
        height: height,
        reverse: false,
        maxVal: maxVal,
        minVal: minVal,
        horizontalBias: horizontalBias,
        includeOutOfChartLeft: true,
        fromTop: false,
      );
      final List<List<Point<double>>> pointsListCIL =
          ChartUtils.calculatePointsForDataGeneral(
        data: confidenceIntervalLow,
        width: width,
        height: height,
        reverse: true,
        maxVal: maxVal,
        minVal: minVal,
        horizontalBias: horizontalBias,
        includeOutOfChartLeft: true,
        fromTop: false,
      );

      final List<Pair<List<Point<double>>, List<Point<double>>>>
          connPointsListCIH = pointsListCIH
              .map(ChartUtils.calculateConnectionPointsForBezierCurve)
              .toList();
      final List<Pair<List<Point<double>>, List<Point<double>>>>
          connPointsListCIL = pointsListCIL
              .map(ChartUtils.calculateConnectionPointsForBezierCurve)
              .toList();

      for (int segmentIndex = 0;
      segmentIndex < pointsListCIH.length;
      segmentIndex++) {
        final List<Point<double>> points = pointsListCIH[segmentIndex];
        final Pair<List<Point<double>>, List<Point<double>>> connPoints =
        connPointsListCIH[segmentIndex];
        int segmentPointsCounter = 0;

        pathHList[segmentIndex].moveTo(points.first.x, points.first.y);

        for (int i = 1; i <= points.length; i++) {
          segmentPointsCounter++;

          if (i == points.length || connPoints.first[i - 1].y == height) {


            final List<Point<double>> pointsL =
            pointsListCIL[pointsListCIH.length - 1 - segmentIndex].reversed.toList();
            final Pair<List<Point<double>>, List<Point<double>>> connPointsL2 =
            connPointsListCIL[pointsListCIH.length - 1 - segmentIndex];

            final Pair<List<Point<double>>, List<Point<double>>> connPointsL = Pair(
              connPointsL2.second.reversed.toList(),
              connPointsL2.first.reversed.toList(),
            );

            for (int j = i - 1; j > i - segmentPointsCounter; j--) {
              if (j == i - 1) {
                pathHList.last.lineTo(pointsL[j].x, pointsL[j].y);
              } else {
                pathHList.last.cubicTo(
                  connPointsL.second[j].x,
                  connPointsL.second[j].y,
                  connPointsL.first[j].x,
                  connPointsL.first[j].y,
                  pointsL[j].x,
                  pointsL[j].y,
                );
              }

              if (j == i - segmentPointsCounter + 1) {
                pathHList.last.cubicTo(
                  connPointsL.second[j - 1].x,
                  connPointsL.second[j - 1].y,
                  connPointsL.first[j - 1].x,
                  connPointsL.first[j - 1].y,
                  pointsL[j - 1].x,
                  pointsL[j - 1].y,
                );
                pathHList.last.moveTo(
                  points[j - 1].x,
                  points[j - 1].y,
                );
              }
            }

            pathHList.add(Path());
            segmentPointsCounter = 0;
          } else if (connPoints.second[i - 1].y == height) {
            segmentPointsCounter--;
            pathHList.last.moveTo(points[i].x, points[i].y);
          } else {
            pathHList.last.cubicTo(
              connPoints.first[i - 1].x,
              connPoints.first[i - 1].y,
              connPoints.second[i - 1].x,
              connPoints.second[i - 1].y,
              points[i].x,
              points[i].y,
            );
          }
        }
      }

      for (var pathsH in pathHList) {
        canvas.drawPath(pathsH, paintConfidenceShading);
      }
    }
  }

  void _drawMarkers({
    required Canvas canvas,
    required double height,
    required double width,
    required Color color,
    required List<double> data,
    required bool drawLast,
  }) {

    final int limit = drawLast ? 0 : 1;

    final List<List<Point<double>>> pointsListCircles =
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
    );

    final Paint paintMainLineCircles = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < pointsListCircles.length; i++) {
      for (int j = 0; j < pointsListCircles[i].length - limit; j++) {
        if (pointsListCircles[i][j].y != height) {
          canvas.drawCircle(
            Offset(pointsListCircles[i][j].x, pointsListCircles[i][j].y),
            3.5,
            paintMainLineCircles,
          );
        }
      }
    }
  }
}
