struct DeviceParticipationsRepository {
    private let deviceParticipationsDataSource = DeviceParticipationsDataSource()

    func withdrawFromStudy(deviceUUID: String, participationID: String) async throws {
        try await deviceParticipationsDataSource.withdrawFromStudy(
            deviceUUID: deviceUUID,
            participationID: participationID
        )
    }
}
