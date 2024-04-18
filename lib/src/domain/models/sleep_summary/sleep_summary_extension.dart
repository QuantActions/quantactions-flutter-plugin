part of 'sleep_summary.dart';

// extension to sleep summary to check if it's nan
extension SleepSummaryExtension on SleepSummary {
  bool get isNaN => sleepStart.isNaN;
}