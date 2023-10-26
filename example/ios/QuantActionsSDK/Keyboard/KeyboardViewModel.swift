import Foundation

final class KeyboardViewModel {
    private let tapDevicesRepository = TapDevicesRepository()
    private let tapDataSessionStorage = TapDataSessionStorage()
    private let userDefaults = UserDefaults(suiteName: Config.Storage.storageName)!

    private var deviceID: String {
        DeviceIDStorage().deviceID
    }

    private var isDataCollectionDisabled: Bool {
        userDefaults.bool(forKey: Config.Storage.isDataCollectionDisabled)
    }

    func handleSession(data: String) {
        if isDataCollectionDisabled {
            return
        }

        tapDataSessionStorage.addSession(rawFleksyKeyboardData: data)
    }

    func synchronize() {
        if isDataCollectionDisabled {
            return
        }

        Task {
            try await tapDevicesRepository.synchronize(
                deviceID: deviceID
            )
        }
    }

    func send(batteryLevel: Double) {
        if isDataCollectionDisabled {
            return
        }
        
        let percentage = Int(batteryLevel * 100)

        Task {
            try await tapDevicesRepository.submitDeviceHealth(
                batteryLevelPercentage: percentage
            )
        }
    }
}
