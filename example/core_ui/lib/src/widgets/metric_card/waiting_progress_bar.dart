import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class WaitingProgressBar extends StatefulWidget {
  final double progressPercent;

  const WaitingProgressBar({super.key, 
    required this.progressPercent,
  });

  @override
  State<StatefulWidget> createState() => _WaitingProgressBarState();
}

class _WaitingProgressBarState extends State<WaitingProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void didUpdateWidget(covariant WaitingProgressBar oldWidget) {
    if (oldWidget.progressPercent != widget.progressPercent) {
      animation = Tween<double>(
        begin: oldWidget.progressPercent,
        end: widget.progressPercent / 100,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
      controller.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.0,
      end: widget.progressPercent / 100,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FractionallySizedBox(
          widthFactor: animation.value,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: context.theme.colors.textDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '${widget.progressPercent.round()}%',
                style: AppFonts.roboto12Normal.copyWith(
                  color: context.theme.colors.textWhite,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
