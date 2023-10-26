struct JournalEventKindDTO: Decodable {
    let id: String
    let publicName: String
    let iconName: String
    let created: String
    let modified: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case publicName = "public_name"
        case iconName = "icon_name"
        case created = "created"
        case modified = "modified"
    }
}

struct JournalEventKindMapper: Mapper {
    func map(from object: JournalEventKindDTO) -> JournalEventKind {
        JournalEventKind(
            id: object.id,
            publicName: object.publicName,
            iconName: object.iconName
        )
    }
}
