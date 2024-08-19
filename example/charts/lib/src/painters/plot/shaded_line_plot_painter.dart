import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../../charts.dart';
import '../../utils/chart_utils.dart';
import '../grid_painter.dart';

class ShadedLinePlotPainter extends CustomPainter {
  static const int nHorizontalLines = 11;
  static const double horizontalBias = 8.0;
  static const double lineStroke = 1.0;
  static const double minVal = 0.0;
  static const double maxVal = 100.0;

  final Color primaryColor;
  final Color meshColor;
  final Color populationRangeBorder;
  final Color populationRangeBackground;
  final ChartMode chartMode;
  final List<double> data;
  final List<double> confidenceIntervalLow;
  final List<double> confidenceIntervalHigh;
  final Pair<int, int> populationRange;
  final double selectedXDouble;
  final bool isUncertaintyActive;

  ShadedLinePlotPainter({
    required this.data,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.populationRange,
    required this.chartMode,
    required this.primaryColor,
    required this.populationRangeBorder,
    required this.populationRangeBackground,
    required this.meshColor,
    required this.selectedXDouble,
    this.isUncertaintyActive = false,
  }) : super();

  bool get isWithShaded =>
      confidenceIntervalLow.isNotEmpty &&
      confidenceIntervalHigh.isNotEmpty &&
      isUncertaintyActive;

  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    final int nVerticalLines = ChartUtils.getVerticalLinesCount(chartMode);

    final double stepVerticalLines =
        (width - horizontalBias * 2 - lineStroke * (nVerticalLines - 1)) /
            (nVerticalLines - 1);

    GridPainter(meshColor: meshColor, chartMode: chartMode).paint(canvas, size);

    _drawPopulationRange(
      canvas: canvas,
      height: height,
      width: width,
      healthyRange: populationRange,
    );

    _drawCurve(
      canvas: canvas,
      height: height,
      width: width,
    );

    final List<Point<double>> flatPointsList =
        ChartUtils.calculatePointsForDataGeneralFlat(
      data: data,
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
    final double selectedY = flatPointsList[selectedPoint].y;
    final double selectedX = flatPointsList[selectedPoint].x;
    final double xPos =
        (stepVerticalLines + lineStroke) * selectedPoint + horizontalBias;

    _drawMarkers(
      canvas: canvas,
      selectedX: selectedX,
      height: height,
      width: width,
      drawLast: chartMode == ChartMode.days,
    );

    if (selectedXDouble > 0 &&
        !selectedY.isNaN &&
        selectedY != height &&
        selectedPoint != flatPointsList.length - 1) {
      _drawSelection(
        canvas: canvas,
        size: size,
        selectedY: selectedY,
        xPos: xPos,
        height: height,
        width: width,
        selectedPoint: selectedPoint,
        selectedX: selectedX,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawPopulationRange({
    required Canvas canvas,
    required double height,
    required double width,
    required Pair<int, int> healthyRange,
  }) {
    final Paint paintPopulationRange = Paint()
      ..color = populationRangeBackground
      ..style = PaintingStyle.fill;

    final Path pathPopulationRange = Path();
    pathPopulationRange.moveTo(0, height - healthyRange.second / 100 * height);
    pathPopulationRange.lineTo(
        width, height - healthyRange.second / 100 * height);
    pathPopulationRange.lineTo(
        width, height - healthyRange.first / 100 * height);
    pathPopulationRange.lineTo(0, height - healthyRange.first / 100 * height);
    pathPopulationRange.close();

    final Path pathPopulationLines = Path();
    final Paint paintPopulationLines = Paint()
      ..color = populationRangeBorder
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const int dashWidth = 3;
    const int dashSpace = 3;
    double currentX = 0.0;
    while (currentX < width) {
      pathPopulationLines.moveTo(
        currentX,
        height - healthyRange.second / 100 * height,
      );
      pathPopulationLines.lineTo(
        currentX + dashWidth,
        height - healthyRange.second / 100 * height,
      );
      currentX += dashWidth + dashSpace;
    }
    currentX = 0.0;
    while (currentX < width) {
      pathPopulationLines.moveTo(
        currentX,
        height - healthyRange.first / 100 * height,
      );
      pathPopulationLines.lineTo(
        currentX + dashWidth,
        height - healthyRange.first / 100 * height,
      );
      currentX += dashWidth + dashSpace;
    }

    canvas.drawPath(pathPopulationRange, paintPopulationRange);
    canvas.drawPath(pathPopulationLines, paintPopulationLines);
  }

  void _drawCurve({
    required Canvas canvas,
    required double height,
    required double width,
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
      ..color = primaryColor
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
      ..color = primaryColor.withOpacity(0.2)
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;

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

    for (var path in pathList) {
      canvas.drawPath(path, paintMainLine);
    }
    if (isUncertaintyActive) {
      for (var pathsH in pathHList) {
        canvas.drawPath(pathsH, paintConfidenceShading);
      }
    }
  }

  void _drawMarkers({
    required Canvas canvas,
    required double selectedX,
    required double height,
    required double width,
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
      ..color = primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final Paint paintMainLineCircles2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    for (int i = 0; i < pointsListCircles.length; i++) {
      for (int j = 0; j < pointsListCircles[i].length - limit; j++) {
        if (pointsListCircles[i][j].y != height) {
          canvas.drawCircle(
            Offset(pointsListCircles[i][j].x, pointsListCircles[i][j].y),
            5,
            paintMainLineCircles,
          );
        }
      }
    }

    for (int i = 0; i < pointsListCircles.length; i++) {
      for (int j = 0; j < pointsListCircles[i].length - limit; j++) {
        if (pointsListCircles[i][j].y != height) {
          canvas.drawCircle(
            Offset(pointsListCircles[i][j].x, pointsListCircles[i][j].y),
            3,
            selectedXDouble > 0 && pointsListCircles[i][j].x == selectedX
                ? paintMainLineCircles
                : paintMainLineCircles2,
          );
        }
      }
    }
  }

  void _drawSelection({
    required Canvas canvas,
    required Size size,
    required double selectedY,
    required double xPos,
    required double height,
    required double width,
    required int selectedPoint,
    required double selectedX,
  }) {
    final Path selectedVertical = Path();
    selectedVertical.moveTo(xPos, 0);
    selectedVertical.lineTo(xPos, height);

    final Paint paintSelectedVertical = Paint()
      ..color = primaryColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawPath(selectedVertical, paintSelectedVertical);

    final Path trianglePath = Path();
    final Paint paintBubble = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    TextSpan? shadedText;
    int selectedLowY = 0;
    int selectedHighY = 0;
    if (isWithShaded) {
      selectedLowY = confidenceIntervalLow[selectedPoint].toInt();
      selectedHighY = confidenceIntervalHigh[selectedPoint].toInt();
      shadedText = TextSpan(
        text: '\n($selectedLowY to $selectedHighY)',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );
    }

    final TextSpan textSpan = TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '${data[selectedPoint].toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (shadedText != null) ...<TextSpan>{
          shadedText,
        }
      ],
    );

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: textSpan,
      textAlign: TextAlign.center,
    );
    textPainter.layout(maxWidth: size.width);
    const int paddingText = 5;
    const double triangleHeight = 10;

    trianglePath.moveTo(xPos, 0);
    trianglePath.lineTo(xPos - 12 / 2, -triangleHeight);
    trianglePath.lineTo(xPos + 12 / 2, -triangleHeight);
    trianglePath.close();

    canvas.drawPath(trianglePath, paintBubble);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (selectedX - paddingText - textPainter.width / 2)
              .clamp(0, width - textPainter.width),
          -triangleHeight - textPainter.height - paddingText * 2,
          textPainter.width + paddingText * 2,
          textPainter.height + paddingText * 2,
        ),
        const Radius.circular(4.0),
      ),
      paintBubble,
    );

    final num xCenter = (selectedX - textPainter.width / 2)
        .clamp(paddingText, width - textPainter.width + paddingText);

    final num yCenter = -triangleHeight - textPainter.height - paddingText;
    final Offset offset = Offset(xCenter.toDouble(), yCenter.toDouble());

    textPainter.paint(canvas, offset);
  }
}
