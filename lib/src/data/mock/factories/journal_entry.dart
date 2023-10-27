import '../../../domain/models/models.dart';
import 'journal_event_factory.dart';
import 'mock_model_factory.dart';

class JournalEntryFactory extends MockModelFactory<JournalEntry> {
  @override
  JournalEntry generateFake([dynamic data]) {
    return JournalEntry(
      id: generateId,
      timestamp: generateDateTime,
      note: faker.lorem.sentences(3).join(),
      events: JournalEventFactory().generateListFake(length: 5),
      ratings: faker.randomGenerator.numbers(5, 5),
      scores: faker.lorem.words(5).fold<Map<String, int>>(
        <String, int>{},
        (Map<String, int> map, String word) => map..[word] = faker.randomGenerator.integer(5),
      ),
    );
  }

  @override
  List<JournalEntry> generateListFake({required int length}) {
    return List<JournalEntry>.generate(length, (int index) => generateFake());
  }
}
