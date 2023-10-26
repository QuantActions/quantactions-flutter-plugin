import Foundation

struct SignUpForStudyRequest: URLRequestBuilder, Encodable {
    let tapDeviceId: String
    let participationId: String

    enum CodingKeys: String, CodingKey {
        case tapDeviceId = "tapDeviceId"
        case participationId = "participationId"
    }

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/signUpForStudy")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(self)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
