import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../charts.dart';
import 'legend_row.dart';

class CumulativeBarLegend extends StatelessWidget {
  final ChartMode chartMode;
  final Color color;
  final Color totalColor;
  final String displayName;

  const CumulativeBarLegend({super.key, 
    required this.chartMode,
    required this.color,
    required this.totalColor,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LegendRow(
          icon: Column(
            children: [
              Container(
                height: 8,
                width: 20,
                color: totalColor.withOpacity(0.5),
              ),
              Container(
                height: 8,
                width: 20,
                color: color.withOpacity(0.5),
              ),
            ],
          ),
          title: Text(
            Platform.isAndroid ? "Total Screen Time" : "Total Writing Time",
            style: AppFonts.roboto14Normal.copyWith(
              color: context.theme.colors.text,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        LegendRow(
          icon: Container(
            height: 16,
            width: 20,
            color: color.withOpacity(0.5),
          ),
          title: Text(
            toBeginningOfSentenceCase(displayName) ?? displayName,
            style: AppFonts.roboto14Normal.copyWith(
              color: context.theme.colors.text,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        LegendRow(
          icon: AppIcons.scoreCommon(color: context.theme.colors.textLight),
          title: Text(
            switch (chartMode) {
              ChartMode.days => Platform.isAndroid ? "Your average screen time in the last 14 days" : "Your average writing time in the last 14 days",
              ChartMode.weeks => Platform.isAndroid ? "Your average screen time in the last 6 weeks" : "Your average writing time in the last 6 weeks",
              ChartMode.months => Platform.isAndroid ? "Your average screen time in the last 12 months" : "Your average writing time in the last 12 months",
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
