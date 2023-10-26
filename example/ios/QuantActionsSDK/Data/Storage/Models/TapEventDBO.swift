@_implementationOnly import RealmSwift
import Foundation

final class TapEventDBO: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var timestamp: Date
}
