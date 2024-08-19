import 'package:flutter/material.dart';

import '../../core_ui.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool value;
  final Function({required bool value}) onTap;

  const CheckBoxWidget({super.key, 
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(value: !value),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: value ? context.theme.colors.checkBox : null,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: context.theme.colors.checkBox, width: 2),
        ),
        child: AppIcons.done(),
      ),
    );
  }
}
