import Foundation

struct DeviceParticipationsDataSource {
    func withdrawFromStudy(deviceUUID: String, participationID: String) async throws {
        let request = WithdrawFromStudyRequest(
            tapDeviceId: deviceUUID,
            participationId: participationID
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }
}
