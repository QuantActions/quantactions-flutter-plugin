public extension QA {
    /// Retrieves the ``JournalEventKind`` items that can be used while logging journal entries.
    /// The events come from a fixed set which may be updated in the future.
    func journalEventKinds() -> [JournalEventKind] {
        journalingRepository.journalEventKinds()
    }

    /// Allows to get all journal entries created so far.
    func journalEntries() -> [JournalEntry] {
        journalingRepository.journalEntries()
    }

    /// Allows to create new or update existing ``JournalEntry``.
    /// - Parameter journalEntry: The entry that will replace the previous entry when updating or create new one if doesn't exist.
    /// - Returns: `JournalEntry` with assigned ID.
    func saveJournalEntry(journalEntry: JournalEntry) throws -> JournalEntry {
        do {
            let entries = journalingRepository.journalEntries()
            let result: JournalEntry

            if entries.contains(where: { $0.id == journalEntry.id }) {
                result = try journalingRepository.updateJournalEntry(
                    byID: journalEntry.id,
                    journalEntry: journalEntry
                )
            } else {
                result = try journalingRepository.create(journalEntry: journalEntry)
            }

            Task {
                try await journalingRepository.syncFromLocalToRemote()
            }

            return result
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Allows to delete existing ``JournalEntry``.
    func deleteJournalEntry(byID id: String) throws {
        do {
            try journalingRepository.deleteJournalEntry(byID: id)

            Task {
                try await journalingRepository.syncFromLocalToRemote()
            }
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }
}
