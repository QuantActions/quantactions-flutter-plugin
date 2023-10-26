import Foundation
@_implementationOnly import RealmSwift

struct JournalEntriesStorage {
    private var realm: Realm? {
        return try? Realm(configuration: Config.RealmConfig.configuration)
    }

    func create(
        date: Date,
        note: String,
        events: [JournalEntryEvent],
        deviceID: String
    ) throws -> JournalEntryDBO {
        guard let realm else {
            throw LocalError.descriptive("Couldn't initialize realm.")
        }

        let dbo = JournalEntryDBO()
        dbo.remoteID = nil
        dbo.note = note
        dbo.deviceID = deviceID
        dbo.date = date
        dbo.isDeleted = false
        dbo.oldEntryID = nil

        let events = journalEntryEventDBOs(fromEvents: events)
        dbo.events.append(objectsIn: events)

        try realm.write {
            realm.add(dbo)
        }

        return dbo
    }

    func readAll() -> [JournalEntryDBO] {
        guard let realm else {
            return []
        }

        let items = realm.objects(JournalEntryDBO.self)
            .where { !$0.isDeleted }
            .sorted(by: \.date, ascending: false)

        return Array(items)
    }

    func update(
        byID id: String,
        date: Date,
        note: String,
        events: [JournalEntryEvent]
    ) throws -> JournalEntryDBO {
        guard let realm else {
            throw LocalError.descriptive("Couldn't initialize realm.")
        }

        let dbo = realm.object(
            ofType: JournalEntryDBO.self,
            forPrimaryKey: try ObjectId(string: id)
        )

        guard let dbo else {
            throw LocalError.descriptive("Couldn't update. Item not found in local storage.")
        }

        try realm.write {
            dbo.note = note
            dbo.date = date
            dbo.oldEntryID = dbo.remoteID

            dbo.events.removeAll()
            let events = journalEntryEventDBOs(fromEvents: events)
            dbo.events.append(objectsIn: events)
        }

        return dbo
    }

    func markAsDeleted(byID id: String) throws {
        guard let realm else {
            return
        }

        let dbo = realm.object(
            ofType: JournalEntryDBO.self,
            forPrimaryKey: try ObjectId(string: id)
        )

        guard let dbo else {
            throw LocalError.descriptive("Couldn't delete. Item not found in local storage.")
        }

        try realm.write {
            dbo.isDeleted = true
        }
    }

    private func journalEntryEventDBOs(fromEvents events: [JournalEntryEvent]) -> [JournalEntryEventDBO] {
        events.compactMap { journalEntryEvent -> JournalEntryEventDBO? in
            let item = JournalEntryEventDBO()

            item.localID = UUID().uuidString
            item.eventKindID = journalEntryEvent.eventKindID
            item.rating = journalEntryEvent.rating

            return item
        }
    }
}
