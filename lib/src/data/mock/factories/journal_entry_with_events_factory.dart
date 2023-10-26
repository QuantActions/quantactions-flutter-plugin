import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';
import 'resolved_journal_event_factory.dart';

class JournalEntryWithEventsFactory extends MockModelFactory<JournalEntryWithEvents> {
  @override
  JournalEntryWithEvents generateFake([dynamic data]) {
    return JournalEntryWithEvents(
      id: generateId,
      timestamp: generateDateTime,
      note: faker.lorem.sentences(3).join(),
      events: ResolvedJournalEventFactory().generateListFake(length: 5),
      ratings: faker.randomGenerator.numbers(5, 5),
      scores: faker.lorem.words(5).fold<Map<String, int>>(
        <String, int>{},
        (Map<String, int> map, String word) => map..[word] = faker.randomGenerator.integer(5),
      ),
    );
  }

  @override
  List<JournalEntryWithEvents> generateListFake({required int length}) {
    return List<JournalEntryWithEvents>.generate(length, (int index) => generateFake());
  }
}
