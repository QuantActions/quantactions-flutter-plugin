/// Contains information about the event kinds that can be logged in the journal,
/// only a set of predefined event kinds can be assigned to a journal event.
public struct JournalEventKind: Hashable {
    /// UUID of the event kind
    public let id: String

    /// Public name (in english) of the event kind (e.g. Food)
    public let publicName: String

    /// Icon name - refers to the icon names from FontAwesome
    public let iconName: String
}
