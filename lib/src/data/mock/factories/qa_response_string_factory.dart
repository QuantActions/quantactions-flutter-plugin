import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class QAResponseStringFactory extends MockModelFactory<QAResponse<String>> {
  @override
  QAResponse<String> generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse<String>(
        data: faker.lorem.sentence(),
        message: null,
      );
    } else {
      return QAResponse<String>(
        data: null,
        message: faker.lorem.sentence(),
      );
    }
  }

  @override
  List<QAResponse<String>> generateListFake({required int length}) {
    return List<QAResponse<String>>.generate(length, (int index) => generateFake());
  }
}
