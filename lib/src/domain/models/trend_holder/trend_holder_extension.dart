part of 'trend_holder.dart';

// extension to trend holder to check if it's nan
extension TrendHolderExtension on TrendHolder {
  bool get isNaN => difference2Weeks.isNaN &&
        difference6Weeks.isNaN &&
        difference1Year.isNaN &&
        statistic2Weeks.isNaN &&
        statistic6Weeks.isNaN &&
        statistic1Year.isNaN &&
        significance2Weeks.isNaN &&
        significance6Weeks.isNaN &&
        significance1Year.isNaN;
}






