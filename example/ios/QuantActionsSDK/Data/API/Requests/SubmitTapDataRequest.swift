import Foundation

struct SubmitTapDataRequest: URLRequestBuilder {
    let deviceID: String
    let body: TapDataDTO

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/submitPlainTapDataParsed")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(body)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
