struct JournalingDataSource {
    func journalEventKinds() async throws -> [JournalEventKindDTO] {
        let request = JournalEventsRequest()

        return try await APIClient.execute(requestBuilder: request)
    }

    func journalEntries(deviceID: String) async throws -> [JournalEntryDTO] {
        let request = JournalEntriesRequest(deviceID: deviceID)

        return try await APIClient.execute(requestBuilder: request)
    }

    func submitEntry(
        id: String,
        date: Date,
        note: String,
        events: [JournalEntryEvent],
        deviceID: String
    ) async throws {
        let request = JournalEntrySubmitRequest(
            deviceID: deviceID,
            body: JournalEntrySubmitRequest.Body(
                entry: JournalEntrySubmitRequest.Entry(
                    id: id,
                    note: note,
                    created: String(date.millisecondsSince1970),
                    events: events.map {
                        JournalEntrySubmitRequest.Entry.Event(
                            id: $0.id,
                            journalEventID: $0.eventKindID,
                            rating: $0.rating
                        )
                    }
                )
            )
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }

    func updateEntry(
        id: String,
        date: Date,
        note: String,
        events: [JournalEntryEvent],
        deviceID: String,
        oldEntryID: String
    ) async throws {
        let request = JournalEntryUpdateRequest(
            deviceID: deviceID,
            body: JournalEntryUpdateRequest.Body(
                entry: JournalEntryUpdateRequest.Entry(
                    id: id,
                    note: note,
                    created: String(date.millisecondsSince1970),
                    events: events.map {
                        JournalEntryUpdateRequest.Entry.Event(
                            id: $0.id,
                            journalEventID: $0.eventKindID,
                            rating: $0.rating
                        )
                    }
                ),
                oldEntryID: oldEntryID
            )
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }

    func deleteEntry(id: String, deviceID: String) async throws {
        let request = JournalEntryDeleteRequest(
            deviceID: deviceID,
            body: JournalEntryDeleteRequest.Body(
                journalEntryID: id
            )
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }
}
