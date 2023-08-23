import '../../../domain/domain.dart';

abstract class TrendProvider {
  Stream<dynamic> getTrendStream(Trend trend);
}
