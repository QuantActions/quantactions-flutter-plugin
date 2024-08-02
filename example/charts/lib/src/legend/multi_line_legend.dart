import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'legend_row.dart';

class MultiLineLegend extends StatelessWidget {
  final List<Color> colors;
  final List<bool> activities;
  final List<String> titles;
  final Function({
    required int index,
    required bool value,
  }) onTap;

  const MultiLineLegend({super.key, 
    required this.colors,
    required this.activities,
    required this.titles,
    required this.onTap,
  }) : assert(colors.length == activities.length);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: activities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (BuildContext context, int index) {
        return LegendRow(
          checkbox: CheckBoxWidget(
            onTap: ({required bool value}) {
              onTap(index: index, value: value);
            },
            value: activities[index],
          ),
          icon: AppIcons.scoreFill(color: colors[index]),
          title: Text(
            titles[index],
            style: AppFonts.roboto14Normal.copyWith(
              color: context.theme.colors.textLight,
              height: 1,
            ),
          ),
        );
      },
    );
  }
}
