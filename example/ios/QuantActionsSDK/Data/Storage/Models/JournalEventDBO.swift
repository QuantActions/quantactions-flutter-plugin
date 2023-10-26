@_implementationOnly import RealmSwift
import Foundation

final class JournalEventKindDBO: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var remoteID: String
    @Persisted var publicName: String
    @Persisted var iconName: String
}

struct JournalEventKindDBOMapper: Mapper {
    func map(from object: JournalEventKindDBO) -> JournalEventKind {
        JournalEventKind(
            id: object.remoteID,
            publicName: object.publicName,
            iconName: object.iconName
        )
    }
}
