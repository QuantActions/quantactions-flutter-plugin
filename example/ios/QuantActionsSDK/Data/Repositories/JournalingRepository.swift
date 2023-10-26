@_implementationOnly import RealmSwift

@globalActor actor BackgroundActor: GlobalActor {
    static var shared = BackgroundActor()
}

struct JournalingRepository {
    private let journalingDataSource = JournalingDataSource()
    private let journalEventKindsStorage = JournalEventKindsStorage()
    private let journalEntriesStorage = JournalEntriesStorage()
    private let deviceIDStorage = DeviceIDStorage()

    func journalEventKinds() -> [JournalEventKind] {
        journalEventKindsStorage.readAll()
    }

    func syncJournalEventKindsFromRemote() async throws {
        let response = try await journalingDataSource.journalEventKinds()

        let items = response.map {
            JournalEventKindMapper().map(from: $0)
        }

        try journalEventKindsStorage.createOrUpdate(journalEventKinds: items)
    }

    func journalEntries() -> [JournalEntry] {
        let items = journalEntriesStorage.readAll()

        return items.map {
            JournalEntryDBOMapper().map(from: $0)
        }
    }

    func create(journalEntry: JournalEntry) throws -> JournalEntry {
        let dbo = try journalEntriesStorage.create(
            date: journalEntry.date,
            note: journalEntry.note,
            events: journalEntry.events,
            deviceID: deviceIDStorage.deviceID
        )

        return JournalEntryDBOMapper().map(from: dbo)
    }

    func updateJournalEntry(byID id: String, journalEntry: JournalEntry) throws -> JournalEntry {
        let dbo = try journalEntriesStorage.update(
            byID: id,
            date: journalEntry.date,
            note: journalEntry.note,
            events: journalEntry.events
        )

        return JournalEntryDBOMapper().map(from: dbo)
    }

    func deleteJournalEntry(byID id: String) throws {
        try journalEntriesStorage.markAsDeleted(byID: id)
    }

    /// Triggers full Journaling synchronization based on response from the remote server.
    ///
    /// 1. First, it downloads entries from the remote server.
    /// 2. Then, it syncs local storage with received remote items (creation/updates, deletions). See ``syncLocal(withRemoteItems:)``
    /// 3. Then, it sends local changes to remote (new items, updates, deletions). See ``syncFromLocalToRemote()``
    func syncFromRemoteToLocal() async throws {
        let response = try await journalingDataSource.journalEntries(deviceID: deviceIDStorage.deviceID)
        let remoteItems = try response.map { try JournalEntryMapper().map(from: $0) }
        
        try syncLocal(withRemoteItems: remoteItems)
        try await syncFromLocalToRemote()
    }

    /// Triggers local items submiting/updating/deleting to/on/from the remote server.
    ///
    /// It makes server requests and performs the actions to cover the following requirements:
    /// * Elements that don't have `remoteID` are local-only items which sould be uploaded to the remote server. After successful upload, remoteID of local item is set.
    /// * Elements that have `oldEntryID` are modified locally so should be updated on the remote server. After successfull update on remote, the `oldEntryID` flag is set back to nil.
    /// * Elements with `isDeleted` flag set to true are marked locally as deleted and should be deleted from the remote server. After successfull deletion from remote, they are also deleted from local.
    ///
    /// Elements that have `remoteID != nil` are considered as synchronized with the remote server.
    @BackgroundActor
    func syncFromLocalToRemote() async throws {
        let realm = try await Realm(
            configuration: Config.RealmConfig.configuration,
            actor: BackgroundActor.shared
        )

        let itemsToSubmit = realm.objects(JournalEntryDBO.self)
            .where { $0.remoteID == nil }

        for item in Array(itemsToSubmit) {
            let id = UUID().uuidString
            try await journalingDataSource.submitEntry(
                id: id,
                date: item.date,
                note: item.note,
                events: item.events.map { JournalEntryEventDBOMapper().map(from: $0) },
                deviceID: item.deviceID
            )

            try realm.write {
                item.remoteID = id
            }
        }

        let itemsToUpdate = realm.objects(JournalEntryDBO.self)
            .where { $0.oldEntryID != nil }

        for item in Array(itemsToUpdate) {
            try await journalingDataSource.updateEntry(
                id: UUID().uuidString,
                date: item.date,
                note: item.note,
                events: item.events.map { JournalEntryEventDBOMapper().map(from: $0) },
                deviceID: item.deviceID,
                oldEntryID: item.oldEntryID ?? ""
            )

            try realm.write {
                item.oldEntryID = nil
            }
        }

        let itemsToDelete = realm.objects(JournalEntryDBO.self)
            .where { $0.remoteID != nil && $0.isDeleted }

        for item in Array(itemsToDelete) {
            try await journalingDataSource.deleteEntry(
                id: item.remoteID ?? "",
                deviceID: item.deviceID
            )

            try realm.write {
                realm.delete(item)
            }
        }
    }

    /// Triggers local items synchronization based on items from the remote server passed as a parameter.
    ///
    /// It doesn't make server requests but performs the actions to cover the following requirements:
    /// * Elements that don't exist in local but exist on remote, should be added to local. Each update actually replaces old entry with the new one in remote database (brand new id) so adding items to local also covers updating cases. It's also necessary to check `oldEntryID` to avoid overriding locally edited items while comparing them with remote ones.
    /// * Elements that have `remoteID` but they don't extist on the remote server anymore should be removed from local.
    ///
    /// Elements that have `remoteID != nil` are considered as synchronized with the remote server.
    /// - Parameter remoteItems: Items from the remote server
    private func syncLocal(withRemoteItems remoteItems: [JournalEntry]) throws {
        let realm = try Realm(configuration: Config.RealmConfig.configuration)

        let localItems = realm.objects(JournalEntryDBO.self)

        let itemsToAddToLocal = remoteItems.filter { item in
            !localItems.contains { $0.remoteID == item.id || $0.oldEntryID == item.id }
        }

        try realm.write {
            itemsToAddToLocal.forEach { item in
                let dbo = JournalEntryDBO()
                dbo.remoteID = item.id
                dbo.note = item.note
                dbo.deviceID = deviceIDStorage.deviceID
                dbo.date = item.date
                dbo.isDeleted = false
                dbo.oldEntryID = nil

                let events = journalEntryEventDBOs(fromEvents: item.events)
                dbo.events.append(objectsIn: events)

                realm.add(dbo)
            }
        }

        let itemsToDeleteFromLocal = localItems.filter { item in
            item.remoteID != nil && !remoteItems.contains { $0.id == item.remoteID }
        }

        try realm.write {
            itemsToDeleteFromLocal.forEach {
                realm.delete($0.events)
            }
            realm.delete(itemsToDeleteFromLocal)
        }
    }

    private func journalEntryEventDBOs(fromEvents events: [JournalEntryEvent]) -> [JournalEntryEventDBO] {
        events.compactMap { journalEntryEvent -> JournalEntryEventDBO? in
            let item = JournalEntryEventDBO()

            item.localID = journalEntryEvent.id
            item.eventKindID = journalEntryEvent.eventKindID
            item.rating = journalEntryEvent.rating

            return item
        }
    }
}
