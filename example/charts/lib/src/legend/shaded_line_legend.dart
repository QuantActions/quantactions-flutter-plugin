
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'legend_row.dart';

class ShadedLineLegend extends StatelessWidget {
  final Color color;
  final bool isUncertaintyActive;
  final bool isWithUncertainty;
  final Function({required bool value}) onTap;

  const ShadedLineLegend({super.key, 
    required this.isUncertaintyActive,
    required this.isWithUncertainty,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LegendRow(
          isCheckboxPadding: isWithUncertainty,
          icon: AppIcons.score(color: color),
          title: Text(
            "Your score",
            style: AppFonts.roboto14Normal.copyWith(
              color: context.theme.colors.text,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (isWithUncertainty) ...<Widget>{
          LegendRow(
            info: "Confidence interval",
            checkbox: CheckBoxWidget(
              onTap: onTap,
              value: isUncertaintyActive,
            ),
            icon: Container(
              height: 16,
              width: 20,
              color: color.withOpacity(0.2),
            ),
            title: Text(
              "Uncertainty of your score",
              style: AppFonts.roboto14Normal.copyWith(
                color: context.theme.colors.text,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 4),
        },
        LegendRow(
          isCheckboxPadding: isWithUncertainty,
          info: "Comparison range",
          icon: Container(
            height: 16,
            width: 20,
            color: context.theme.colors.iconMiddleDark.withOpacity(0.2),
          ),
          // AppIcons.scoreCommon(
          //   color: context.theme.colors.iconMiddleDark,
          // ),
          title: Text(
            "Most common scores for healthy people",
            style: AppFonts.roboto14Normal.copyWith(
              color: context.theme.colors.text,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
