import 'dart:ui';

import '../../core_ui.dart';
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';

extension MetricModeMapper on Metric {

  Color getPrimaryColor({
    required AppColorsTheme colors,
  }) {
    switch (this) {
      case Metric.cognitiveFitness:
        return colors.fitnessPrimary;
      case Metric.sleepScore:
        return colors.sleepPrimary;
      case Metric.socialEngagement:
        return colors.socialPrimary;
      default:
        return colors.scoresPrimary;
    }
  }

  Color getSecondaryColor({
    required AppColorsTheme colors,
  }) {
    switch (this) {
      case Metric.cognitiveFitness:
        return colors.fitnessSecondary;
      case Metric.sleepScore:
        return colors.sleepSecondary;
      case Metric.socialEngagement:
        return colors.socialSecondary;
      default:
        return colors.scoresSecondary;
    }
  }
}
