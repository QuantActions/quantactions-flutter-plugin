part of 'trend_holder.dart';

// extension to trend holder to check if it's nan
extension TrendHolderExtension on TrendHolder {
  bool get isNaN => difference2Weeks.isNaN &&
        difference6Weeks.isNaN &&
        difference1Year.isNaN;
}






