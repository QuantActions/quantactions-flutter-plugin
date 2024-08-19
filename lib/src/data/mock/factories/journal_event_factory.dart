import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';

class JournalEventFactory extends MockModelFactory<JournalEvent> {
  @override
  JournalEvent generateFake([dynamic data]) {
    return JournalEvent(
      id: generateId,
      eventKindID: generateId,
      eventName: faker.lorem.word(),
      eventIcon: faker.lorem.word(),
      rating: faker.randomGenerator.integer(5),
    );
  }

  @override
  List<JournalEvent> generateListFake({required int length}) {
    return List<JournalEvent>.generate(length, (int index) => generateFake());
  }
}
