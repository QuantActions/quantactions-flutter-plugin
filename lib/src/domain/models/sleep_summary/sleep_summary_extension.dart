part of 'sleep_summary.dart';

/// extension to sleep summary to check if it's nan
extension SleepSummaryExtension on SleepSummary {
  /// check if the sleep summary is nan
  bool get isNaN => sleepStart.isNaN;
}
