import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

/// Factory for [ScreenTimeAggregate] model.
class ScreenTimeAggregateFactory extends MockModelFactory<ScreenTimeAggregate> {

  /// Number of milliseconds in a day.
  final int h24 = 86400000;

  @override
  ScreenTimeAggregate generateFake([dynamic data]) {
    final double totalScreenTime = faker.randomGenerator.decimal(scale: h24);
    return ScreenTimeAggregate(
      totalScreenTime: totalScreenTime,
      socialScreenTime: faker.randomGenerator.decimal(scale: totalScreenTime),
    );
  }

  @override
  List<ScreenTimeAggregate> generateListFake({required int length}) {
    return List<ScreenTimeAggregate>.generate(
        length, (int index) => generateFake());
  }
}
