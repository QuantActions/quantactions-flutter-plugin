import 'package:flutter/cupertino.dart';

import 'animated_dot.dart';

class DotsLoader extends StatelessWidget {
  final double size;
  final Color color;

  const DotsLoader({super.key, 
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) => SizedBox(width: size / 4),
        itemBuilder: (BuildContext context, int index) {
          return AnimatedDot(size: size, dotIndex: index, color: color);
        },
      ),
    );
  }
}
