import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppDivider extends StatelessWidget {
  final double thickness;

  const AppDivider({super.key, 
    this.thickness = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      height: 2,
      color: context.theme.colors.divider,
    );
  }
}
