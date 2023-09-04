import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class SleepSummaryFactory extends MockModelFactory<SleepSummary> {
  @override
  SleepSummary generateFake() {
    return SleepSummary(
      sleepStart: generateDateTime,
      sleepEnd: generateDateTime,
      interruptionsStart: List.generate(10, (index) => generateDateTime),
      interruptionsEnd: List.generate(10, (index) => generateDateTime),
      interruptionsNumberOfTaps:
          List.generate(10, (index) => faker.randomGenerator.integer(5)),
    );
  }

  @override
  List<SleepSummary> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
