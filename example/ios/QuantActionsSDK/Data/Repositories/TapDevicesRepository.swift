import Foundation

struct TapDevicesRepository {
    private let tapDevicesDataSource = TapDevicesDataSource()
    private let tapDataSessionStorage = TapDataSessionStorage()
    private let deviceIDStorage = DeviceIDStorage()
    private let userDefaults = UserDefaults(suiteName: Config.Storage.storageName)!

    func registerDevice(deviceInfo: DeviceInfo, basicInfo: BasicInfo) async throws {
        let response = try await tapDevicesDataSource.registerDevice(
            deviceUUID: deviceIDStorage.deviceID,
            deviceInfo: deviceInfo,
            basicInfo: basicInfo
        )

        let publicKey = DeviceRegistrationResponseMapper().map(from: response)
        userDefaults.set(publicKey, forKey: Config.Storage.deviceRegistrationPublicKey)
        userDefaults.set(encodable: basicInfo, key: Config.Storage.basicInfo)
    }

    func signUpForStudy(participationID: String) async throws -> SubscriptionWithQuestionnaires {
        let response = try await tapDevicesDataSource.signUpForStudy(
            deviceUUID: deviceIDStorage.deviceID,
            participationID: participationID
        )

        return StudySignUpResponseMapper().map(from: response)
    }

    func submitDeviceHealth(batteryLevelPercentage: Int) async throws {
        try await tapDevicesDataSource.submitDeviceHealth(
            deviceUUID: deviceIDStorage.deviceID,
            batteryLevelPercentage: batteryLevelPercentage
        )
    }

    func updateDevice(deviceInfo: DeviceInfo, basicInfo: BasicInfo) async throws -> [SubscriptionWithQuestionnaires] {
        userDefaults.set(encodable: basicInfo, key: Config.Storage.basicInfo)

        let response = try await tapDevicesDataSource.updateDevice(
            deviceUUID: deviceIDStorage.deviceID,
            deviceInfo: deviceInfo,
            basicInfo: basicInfo
        )

        return ParticipationsResponseMapper().map(from: response)
    }

    func synchronize(deviceID: String) async throws {
        let lastSyncDate = userDefaults.object(forKey: Config.Storage.lastSyncDate) as? Date
        let sessions: [String]

        if let lastSyncDate = lastSyncDate {
            sessions = tapDataSessionStorage.rawFleksyKeyboardSessions(after: lastSyncDate)
        } else {
            sessions = tapDataSessionStorage.rawFleksyKeyboardSessions(after: .distantPast)
        }

        for session in sessions {
            try await submitTapData(deviceID: deviceID, data: session)
        }
    }

    func submitTapData(deviceID: String, data: String) async throws {
        try await tapDevicesDataSource
            .submitTapData(
                deviceUUID: deviceID,
                data: try FleksyKeyboardDataMapper().map(from: data)
            )

        userDefaults.set(Date.now, forKey: Config.Storage.lastSyncDate)
    }

    func submitNote(note: String) async throws {
        try await tapDevicesDataSource
            .submitNote(
                deviceUUID: deviceIDStorage.deviceID,
                note: note.trimmingCharacters(in: .whitespacesAndNewlines)
            )
    }
}
