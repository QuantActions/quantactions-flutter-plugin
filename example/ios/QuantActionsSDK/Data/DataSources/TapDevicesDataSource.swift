import Foundation

struct TapDevicesDataSource {
    func registerDevice(deviceUUID: String, deviceInfo: DeviceInfo, basicInfo: BasicInfo) async throws -> DeviceRegistrationResponseDTO {
        let request = RegisterDeviceRequest(
            tapDeviceId: deviceUUID,
            deviceInfo: deviceInfo,
            gender: "\(basicInfo.gender.rawValue)",
            yearOfBirth: basicInfo.yearOfBirth,
            selfDeclaredHealthy: basicInfo.selfDeclaredHealthy ? 1 : 0
        )

        return try await APIClient.execute(requestBuilder: request)
    }

    func signUpForStudy(deviceUUID: String, participationID: String) async throws -> StudySignUpResponseDTO {
        let request = SignUpForStudyRequest(
            tapDeviceId: deviceUUID,
            participationId: participationID
        )
        
        return try await APIClient.execute(requestBuilder: request)
    }

    func submitTapData(deviceUUID: String, data: FleksyKeyboardData) async throws {
        let request = SubmitTapDataRequest(
            deviceID: deviceUUID,
            body: FleksyKeyboardToTapDataDTOMapper().map(from: data)
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }

    func submitDeviceHealth(deviceUUID: String, batteryLevelPercentage: Int) async throws {
        let timestamp = Date.now.millisecondsSince1970
        let request = SubmitDeviceHealthRequest(
            deviceID: deviceUUID,
            timestamp: timestamp,
            charge: batteryLevelPercentage
        )
        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }

    func updateDevice(deviceUUID: String, deviceInfo: DeviceInfo, basicInfo: BasicInfo) async throws -> ParticipationsResponseDTO {
        let request = UpdateDeviceRequest(
            tapDeviceId: deviceUUID,
            systemVersion: deviceInfo.iOSVersion,
            deviceManufacturer: deviceInfo.manufacturer,
            deviceModel: deviceInfo.model,
            language: deviceInfo.language,
            sdkVersion: deviceInfo.sdkVersion,
            deviceType: deviceInfo.type,
            permAppId: 0,
            permDrawOver: 0,
            permLocation: 0,
            permContact: 0,
            yearOfBirth: basicInfo.yearOfBirth,
            gender: "\(basicInfo.gender.rawValue)",
            selfDeclaredHealthy: basicInfo.selfDeclaredHealthy ? 1 : 0
        )

        return try await APIClient.execute(requestBuilder: request)
    }

    func submitNote(deviceUUID: String, note: String) async throws {
        let request = SubmitNoteRequest(
            deviceID: deviceUUID,
            body: NoteDTO(note: note)
        )

        let _ = try await APIClient.executeRaw(requestBuilder: request)
    }
}
