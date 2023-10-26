import Foundation

struct DeviceIDStorage {
    private let userDefaults = UserDefaults(suiteName: Config.Storage.storageName)

    var deviceID: String {
        guard let deviceID: String = userDefaults?.string(forKey: Config.Storage.deviceID) else {
            let uuid = UUID().uuidString
            userDefaults?.set(uuid, forKey: Config.Storage.deviceID)
            return uuid
        }

        return deviceID
    }

    var isInitialized: Bool {
        userDefaults?.string(forKey: Config.Storage.deviceID) != nil
    }
}
