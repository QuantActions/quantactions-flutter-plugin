import 'package:flutter/cupertino.dart';


class AnimatedDot extends StatefulWidget {
  final double size;
  final int dotIndex;
  final Color color;

  const AnimatedDot({super.key, 
    required this.size,
    required this.dotIndex,
    required this.color,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool isControllerDisposed = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    Future<void>.delayed(Duration(milliseconds: 1000 + (500 * widget.dotIndex))).whenComplete(() {

      if (!isControllerDisposed) {
        controller.forward();
      }

      animation.addListener(() {
        if (animation.isCompleted) {
          controller.reverse();
        } else if (animation.isDismissed) {
          Future<void>.delayed(const Duration(milliseconds: 500)).whenComplete(() {
            if (!isControllerDisposed) {
              controller.forward();
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    isControllerDisposed = true;
    controller.dispose();
    super.dispose();
  }
}
