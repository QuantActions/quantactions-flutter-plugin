@_implementationOnly import RealmSwift
import Foundation

final class JournalEntryDBO: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var remoteID: String?
    @Persisted var note: String
    @Persisted var deviceID: String
    @Persisted var events: List<JournalEntryEventDBO>
    @Persisted var date: Date
    @Persisted var oldEntryID: String?
    @Persisted var isDeleted: Bool
}

final class JournalEntryEventDBO: EmbeddedObject {
    @Persisted var localID: String
    @Persisted var eventKindID: String
    @Persisted var rating: Int
}

struct JournalEntryDBOMapper: Mapper {
    func map(from object: JournalEntryDBO) -> JournalEntry {
        JournalEntry(
            id: object._id.stringValue,
            date: object.date,
            note: object.note,
            events: object.events.map {
                JournalEntryEventDBOMapper().map(from: $0)
            }
        )
    }
}

struct JournalEntryEventDBOMapper: Mapper {
    func map(from object: JournalEntryEventDBO) -> JournalEntryEvent {
        JournalEntryEvent(
            id: object.localID,
            eventKindID: object.eventKindID,
            rating: object.rating
        )
    }
}
