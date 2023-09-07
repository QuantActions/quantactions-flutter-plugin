import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class ScreenTimeAggregateFactory extends MockModelFactory<ScreenTimeAggregate> {
  @override
  ScreenTimeAggregate generateFake() {
    return ScreenTimeAggregate(
      totalScreenTime: generateDouble,
      socialScreenTime: generateDouble,
    );
  }

  @override
  List<ScreenTimeAggregate> generateListFake({required int length}) {
    return List<ScreenTimeAggregate>.generate(length, (int index) => generateFake());
  }
}
