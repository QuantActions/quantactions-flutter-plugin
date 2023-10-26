import Foundation

struct UpdateDeviceRequest: URLRequestBuilder, Encodable {
    let tapDeviceId: String
    let systemVersion: String
    let deviceManufacturer: String
    let deviceModel: String
    let language: String
    let sdkVersion: Int
    let deviceType: String
    let permAppId: Int
    let permDrawOver: Int
    let permLocation: Int
    let permContact: Int
    let yearOfBirth: Int
    let gender: String
    let selfDeclaredHealthy: Int

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(tapDeviceId)/updateDevice")
        
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(self)
        request.add(header: HTTPHeader.contentType(.json))
        
        return request
    }
    
    enum CodingKeys: String, CodingKey {
        case tapDeviceId = "id"
        case systemVersion = "androidVersion"
        case deviceManufacturer = "deviceManufacturer"
        case deviceModel = "deviceModel"
        case language = "language"
        case sdkVersion = "apiVersion"
        case deviceType = "deviceType"
        case permAppId = "permAppId"
        case permDrawOver = "permDrawOver"
        case permLocation = "permLocation"
        case permContact = "permContact"
        case yearOfBirth = "age"
        case gender = "gender"
        case selfDeclaredHealthy = "selfDeclaredHealthy"
    }
}
