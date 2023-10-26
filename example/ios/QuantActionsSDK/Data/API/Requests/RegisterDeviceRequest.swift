import Foundation

struct RegisterDeviceRequest: URLRequestBuilder, Encodable {
    enum CodingKeys: String, CodingKey {
        case tapDeviceId = "tapDeviceId"
        case deviceInfo = "deviceInfo"
        case gender = "gender"
        case yearOfBirth = "age"
        case selfDeclaredHealthy = "selfDeclaredHealthy"
        case deviceType = "deviceType"
    }

    let tapDeviceId: String
    let deviceInfo: DeviceInfo
    let gender: String
    let yearOfBirth: Int
    let selfDeclaredHealthy: Int
    let deviceType = "ios"

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/register")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(self)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
