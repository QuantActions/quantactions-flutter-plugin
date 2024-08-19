part of 'screen_time_aggregate.dart';

/// extension to check if it's nan
extension ScreenTimeAggregateExtension on ScreenTimeAggregate {
  /// check if the screen time aggregate is nan
  bool get isNaN => totalScreenTime.isNaN && socialScreenTime.isNaN;
}
