import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';

class JournalEventFactory extends MockModelFactory<JournalEvent> {
  @override
  JournalEvent generateFake() {
    return JournalEvent(
      id: generateId,
      publicName: faker.conference.name(),
      iconName: faker.lorem.word(),
      created: generateDateTime,
      modified: generateDateTime,
    );
  }

  @override
  List<JournalEvent> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
