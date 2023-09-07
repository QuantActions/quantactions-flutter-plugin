import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class SleepSummaryFactory extends MockModelFactory<SleepSummary> {
  @override
  SleepSummary generateFake() {
    return SleepSummary(
      sleepStart: generateDateTime,
      sleepEnd: generateDateTime,
      interruptionsStart: List<DateTime>.generate(10, (int index) => generateDateTime),
      interruptionsEnd: List<DateTime>.generate(10, (int index) => generateDateTime),
      interruptionsNumberOfTaps: List<int>.generate(
        10,
        (int index) => faker.randomGenerator.integer(5),
      ),
    );
  }

  @override
  List<SleepSummary> generateListFake({required int length}) {
    return List<SleepSummary>.generate(length, (int index) => generateFake());
  }
}
