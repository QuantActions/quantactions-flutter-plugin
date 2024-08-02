import 'package:flutter/material.dart';
import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';

import '../../../core_ui.dart';
import 'indicator_painter.dart';

class Indicator extends StatefulWidget {
  final Widget child;
  final int percentValue;
  final Metric metric;
  final double size;
  final double internalCircleStrokeWidth;
  final double progressCircleStrokeWidth;

  const Indicator.small({
    super.key,
    required this.child,
    required this.percentValue,
    required this.metric,
  })  : size = 140,
        internalCircleStrokeWidth = 5,
        progressCircleStrokeWidth = 11;

  const Indicator.big({
    super.key,
    required this.child,
    required this.percentValue,
    required this.metric,
  })  : size = 232,
        internalCircleStrokeWidth = 8,
        progressCircleStrokeWidth = 18;

  @override
  State<StatefulWidget> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  bool isLastAnimationIteration = false;

  @override
  void didUpdateWidget(covariant Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.percentValue != widget.percentValue && widget.percentValue != 0) {
      animation.addListener(() {
        if (animation.value == 1.0) {
          animation = Tween<double>(
            begin: 1.0,
            end: widget.percentValue.toDouble(),
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ),
          );
          isLastAnimationIteration = true;
          controller.forward();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(
      begin: 1.0,
      end: widget.percentValue == 0 ? 98.0 : widget.percentValue.toDouble(),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        if (widget.percentValue != 0) {
          isLastAnimationIteration = true;
        }

        if (isLastAnimationIteration && animation.isCompleted) {
          controller.stop();
        }
        if (animation.value == 98.0) {
          controller.reverse();
        } else if (animation.value == 1.0) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              size: Size(widget.size, widget.size),
              painter: IndicatorPainter(
                shouldRepaintIndicator: !(isLastAnimationIteration && animation.isCompleted),
                isLastAnimationIteration: isLastAnimationIteration,
                internalCircleStrokeWidth: widget.internalCircleStrokeWidth,
                progressCircleStrokeWidth: widget.progressCircleStrokeWidth,
                percentValue: animation.value,
                color: widget.metric.getPrimaryColor(
                  colors: context.theme.colors,
                ),
                colorLight: widget.metric.getSecondaryColor(
                  colors: context.theme.colors,
                ),
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
