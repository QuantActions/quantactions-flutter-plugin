struct JournalEntryDTO: Decodable {
    let id: String
    let note: String
    let deviceID: String
    let created: String
    let modified: String
    let events: [EventDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case note
        case deviceID = "device_id"
        case created
        case modified
        case events
    }

    struct EventDTO: Decodable {
        let id: String
        let journalEventID: String
        let journalEntryID: String
        let rating: Int

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case journalEventID = "journal_event_id"
            case journalEntryID = "journal_entry_id"
            case rating = "rating"
        }
    }
}

struct JournalEntryMapper: Mapper {
    func map(from object: JournalEntryDTO) throws -> JournalEntry {
        guard let created = Int(object.created) else {
            throw LocalError.mapping(\JournalEntryDTO.created)
        }

        return JournalEntry(
            id: object.id,
            date: Date(millisecondsSince1970: created),
            note: object.note,
            events: object.events.map { EventMapper().map(from: $0) }
        )
    }

    struct EventMapper: Mapper {
        func map(from object: JournalEntryDTO.EventDTO) -> JournalEntryEvent {
            JournalEntryEvent(
                id: object.journalEntryID,
                eventKindID: object.journalEventID,
                rating: object.rating
            )
        }
    }
}


