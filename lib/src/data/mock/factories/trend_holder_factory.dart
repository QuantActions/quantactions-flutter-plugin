import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

/// Factory for [TrendHolder] model.
class TrendHolderFactory extends MockModelFactory<TrendHolder> {
  @override
  TrendHolder generateFake([dynamic data]) {
    return TrendHolder(
      difference2Weeks: generateDouble,
      statistic2Weeks: generateDouble,
      significance2Weeks: generateDouble,
      difference6Weeks: generateDouble,
      statistic6Weeks: generateDouble,
      significance6Weeks: generateDouble,
      difference1Year: generateDouble,
      statistic1Year: generateDouble,
      significance1Year: generateDouble,
    );
  }

  @override
  List<TrendHolder> generateListFake({required int length}) {
    return List<TrendHolder>.generate(length, (int index) => generateFake());
  }
}
