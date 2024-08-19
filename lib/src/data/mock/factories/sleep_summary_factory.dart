import 'dart:math';
import 'package:sugar/sugar.dart';

import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class SleepSummaryFactory extends MockModelFactory<SleepSummary> {
  @override
  SleepSummary generateFake([dynamic data]) {
    final ZonedDateTime sleepStart = (data as ZonedDateTime)
        .subtract(const Duration(days: 1))
        .copyWith(hour: Random().nextInt(4) + 20);
    final ZonedDateTime sleepEnd = data.copyWith(hour: Random().nextInt(9) + 1);

    return SleepSummary(
      sleepStart: sleepStart,
      sleepEnd: sleepEnd,
      interruptionsStart: List<ZonedDateTime>.generate(
        Random().nextInt(2),
        (int index) => data.subtract(const Duration(days: 1)).copyWith(
              hour:
                  Random().nextInt(24 - sleepStart.hour) + sleepStart.hour + 1,
            ),
      ),
      interruptionsEnd: List<ZonedDateTime>.generate(
        Random().nextInt(2),
        (int index) => data.copyWith(hour: Random().nextInt(sleepEnd.hour) + 1),
      ),
      interruptionsNumberOfTaps: List<int>.generate(
        Random().nextInt(4),
        (int index) => faker.randomGenerator.integer(5),
      ),
    );
  }

  @override
  List<SleepSummary> generateListFake({required int length}) {
    return List<SleepSummary>.generate(length, (int index) => generateFake());
  }
}
