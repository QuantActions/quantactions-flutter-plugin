/// Struct representing a journal entry.
///
/// The SDK allows also to use a journaling function to log a series of entries. Each entry is composed of:
/// * a date
/// * short text describing the entry
/// * list of events (from a predefined pool)
/// * rating (1 to 5) for each event in the entry
public struct JournalEntry: Identifiable, Hashable {
    public let id: String
    public var date: Date
    public var note: String
    public var events: [JournalEntryEvent]

    public init(
        date: Date,
        note: String,
        events: [JournalEntryEvent]
    ) {
        self.id = UUID().uuidString
        self.date = date
        self.note = note
        self.events = events
    }

    // Should not be public.
    // It's used internally by the SDK to provide id when extracting items from local database.
    init(
        id: String,
        date: Date,
        note: String,
        events: [JournalEntryEvent]
    ) {
        self.id = id
        self.date = date
        self.note = note
        self.events = events
    }
}

/// Struct representing an event of the journal entry.
///
/// It consists of `eventKindID` from predefined ``JournalEventKind`` and `rating` (Int value).
public struct JournalEntryEvent: Identifiable, Hashable {
    public let id: String
    public var eventKindID: String
    public var rating: Int

    public init(
        eventKindID: String,
        rating: Int
    ) {
        self.id = UUID().uuidString
        self.eventKindID = eventKindID
        self.rating = rating
    }

    // Should not be public.
    // It's used internally by the SDK to provide id when extracting items from local database.
    init(
        id: String,
        eventKindID: String,
        rating: Int
    ) {
        self.id = id
        self.eventKindID = eventKindID
        self.rating = rating
    }
}
