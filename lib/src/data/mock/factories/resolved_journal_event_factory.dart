import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';

class ResolvedJournalEventFactory extends MockModelFactory<ResolvedJournalEvent> {
  @override
  ResolvedJournalEvent generateFake() {
    return ResolvedJournalEvent(
      id: generateId,
      publicName: faker.conference.name(),
      iconName: faker.lorem.word(),
    );
  }

  @override
  List<ResolvedJournalEvent> generateListFake({required int length}) {
    return List<ResolvedJournalEvent>.generate(length, (int index) => generateFake());
  }
}
