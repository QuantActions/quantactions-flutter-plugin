import Foundation
@_implementationOnly import RealmSwift

struct TapDataSessionStorage {
    private var realm: Realm? {
        return try? Realm(configuration: Config.RealmConfig.configuration)
    }

    func addSession(rawFleksyKeyboardData: String) {
        guard
            let realm = realm,
            let data = rawFleksyKeyboardData.data(using: .utf8),
            let fleksyKeyboardData = try? JSONDecoder().decode(FleksyKeyboardData.self, from: data)
        else {
            return
        }

        let session = TapDataSessionDBO()
        session.startedAt = Date(millisecondsSince1970: fleksyKeyboardData.startUnixTime)
        session.endedAt = Date(millisecondsSince1970: fleksyKeyboardData.endUnixTime)
        session.rawFleksyKeyboardData = rawFleksyKeyboardData

        let tapEvents = fleksyKeyboardData.tapEvent.map {
            let event = TapEventDBO()
            event.timestamp = Date(
                millisecondsSince1970: fleksyKeyboardData.startUnixTime + $0.touchBegin.timestamp
            )
            return event
        }
        session.tapEvents.append(objectsIn: tapEvents)

        realm.writeAsync({
            realm.add(session)
        }) { _ in
            print("\(#function): \(fleksyKeyboardData.startUnixTime)")
        }
    }

    func rawFleksyKeyboardSessions(after date: Date) -> [String] {
        guard let realm = realm else {
            return []
        }

        let objects = realm.objects(TapDataSessionDBO.self)
            .sorted(by: \.endedAt, ascending: false)
            .where { $0.endedAt > date }

        let rawSessions = Array(objects.map { $0.rawFleksyKeyboardData })
        return rawSessions
    }

    func tapEvents(in interval: DateInterval) -> [Date] {
        guard let realm = realm else {
            return []
        }

        let objects = realm.objects(TapEventDBO.self)
            .where { $0.timestamp >= interval.start && $0.timestamp < interval.end }
            .sorted(by: \.timestamp, ascending: false)

        return objects.map({ $0.timestamp })
    }
}
