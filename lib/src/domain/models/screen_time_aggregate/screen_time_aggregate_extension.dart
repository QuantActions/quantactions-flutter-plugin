part of 'screen_time_aggregate.dart';

// extension to trend holder to check if it's nan
extension ScreenTimeAggregateExtension on ScreenTimeAggregate {
  bool get isNaN => totalScreenTime.isNaN && socialScreenTime.isNaN;
}
