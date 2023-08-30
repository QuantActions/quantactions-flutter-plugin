import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/mock/factories/mock_model_factory.dart';

class BasicInfoFactory extends MockModelFactory<BasicInfo> {
  @override
  BasicInfo generateFake() {
    return BasicInfo(
      yearOfBirth: faker.randomGenerator.integer(2023, min: 1990),
      gender: Gender.values[faker.randomGenerator.integer(4)],
      selfDeclaredHealthy: faker.randomGenerator.boolean(),
    );
  }

  @override
  List<BasicInfo> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
