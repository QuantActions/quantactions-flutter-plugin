import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/mock/factories/mock_model_factory.dart';

class JournalEventFactory extends MockModelFactory<JournalEvent> {
  @override
  JournalEvent generateFake() {
    return JournalEvent(
      id: faker.randomGenerator.fromCharSet('-1234567890', 10),
      publicName: faker.conference.name(),
      iconName: faker.lorem.word(),
      created: faker.date.dateTime(
        minYear: 1990,
        maxYear: DateTime.now().year,
      ),
      modified: faker.date.dateTime(
        minYear: 1990,
        maxYear: DateTime.now().year,
      ),
    );
  }

  @override
  List<JournalEvent> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
