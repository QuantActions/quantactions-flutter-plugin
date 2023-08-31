import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class QAResponseStringFactory extends MockModelFactory<QAResponse> {
  @override
  QAResponse generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse(
        data: faker.lorem.sentence(),
        message: null,
      );
    } else {
      return QAResponse(
        data: null,
        message: faker.lorem.sentence(),
      );
    }
  }

  @override
  List<QAResponse> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
