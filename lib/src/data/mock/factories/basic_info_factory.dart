import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';

/// Factory for [BasicInfo] model.
class BasicInfoFactory extends MockModelFactory<BasicInfo> {
  @override
  BasicInfo generateFake([dynamic data]) {
    return BasicInfo(
      yearOfBirth: faker.randomGenerator.integer(
        DateTime.now().year,
        min: 1990,
      ),
      gender: Gender.values[faker.randomGenerator.integer(4)],
      selfDeclaredHealthy: faker.randomGenerator.boolean(),
    );
  }

  @override
  List<BasicInfo> generateListFake({required int length}) {
    return List<BasicInfo>.generate(length, (int index) => generateFake());
  }
}
