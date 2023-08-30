import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/mock/factories/mock_model_factory.dart';

class ResolvedJournalEventFactory
    extends MockModelFactory<ResolvedJournalEvent> {
  @override
  ResolvedJournalEvent generateFake() {
    return ResolvedJournalEvent(
      id: generateId,
      publicName: faker.conference.name(),
      iconName: faker.lorem.word(),
    );
  }

  @override
  List<ResolvedJournalEvent> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
