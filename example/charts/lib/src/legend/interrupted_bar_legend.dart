
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../charts.dart';
import 'legend_row.dart';

class InterruptedBarLegend extends StatelessWidget {
  final ChartMode chartMode;
  final Color color;

  const InterruptedBarLegend({super.key, 
    required this.chartMode,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LegendRow(
          icon: AppIcons.scoreCommon(color: color),
          title: Text(
            switch (chartMode) {
              ChartMode.days =>
                "Average sleep time over the past 14 days",
              ChartMode.weeks =>
                "Average sleep time over the past 6 weeks",
              ChartMode.months =>
                "Average sleep time over the past 12 months",
            },
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
