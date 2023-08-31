import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';
import 'resolved_journal_event_factory.dart';

class JournalEntryWithEventsFactory
    extends MockModelFactory<JournalEntryWithEvents> {
  @override
  JournalEntryWithEvents generateFake() {
    return JournalEntryWithEvents(
      id: generateId,
      timestamp: faker.date.dateTime(
        minYear: 1990,
        maxYear: DateTime.now().year,
      ),
      note: faker.lorem.sentences(3).join(),
      events: ResolvedJournalEventFactory().generateListFake(length: 5),
      ratings: faker.randomGenerator.numbers(5, 5),
      scores: faker.lorem.words(5).fold<Map<String, int>>(
        {},
        (map, word) => map..[word] = faker.randomGenerator.integer(5),
      ),
    );
  }

  @override
  List<JournalEntryWithEvents> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
