import Foundation
@_implementationOnly import RealmSwift

/// Local cache for `JournalEvent` items.
struct JournalEventKindsStorage {
    private var realm: Realm? {
        return try? Realm(configuration: Config.RealmConfig.configuration)
    }

    func createOrUpdate(journalEventKinds: [JournalEventKind]) throws {
        guard let realm = realm else {
            return
        }

        let newItems = journalEventKinds.map {
            let dbo = JournalEventKindDBO()
            dbo.remoteID = $0.id
            dbo.publicName = $0.publicName
            dbo.iconName = $0.iconName

            return dbo
        }

        try realm.write {
            let previousItems = realm.objects(JournalEventKindDBO.self)
            realm.delete(previousItems)

            realm.add(newItems)
        }
    }

    func readAll() -> [JournalEventKind] {
        guard let realm = realm else {
            return []
        }

        let objects = realm.objects(JournalEventKindDBO.self)

        return objects.map {
            JournalEventKindDBOMapper().map(from: $0)
        }
    }
}
