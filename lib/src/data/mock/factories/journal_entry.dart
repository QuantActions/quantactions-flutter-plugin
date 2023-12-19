import '../../../domain/models/models.dart';
import 'journal_event_factory.dart';
import 'mock_model_factory.dart';

class JournalEntryFactory extends MockModelFactory<JournalEntry> {
  @override
  JournalEntry generateFake([dynamic data]) {
    return JournalEntry(
      id: generateId,
      timestamp: generateDateTime,
      note: faker.lorem.sentences(2).join(),
      events: JournalEventFactory().generateListFake(length: 5),
      scores: <String, int>{
        'fitness': faker.randomGenerator.integer(100),
        'sleep': faker.randomGenerator.integer(100),
        'social': faker.randomGenerator.integer(100),
      },
    );
  }

  @override
  List<JournalEntry> generateListFake({required int length}) {
    return List<JournalEntry>.generate(length, (int index) => generateFake());
  }
}
