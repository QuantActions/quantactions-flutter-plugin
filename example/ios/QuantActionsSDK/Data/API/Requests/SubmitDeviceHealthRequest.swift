import Foundation

struct SubmitDeviceHealthRequest: URLRequestBuilder {
    let deviceID: String
    let timestamp: Int
    let charge: Int

    ///
    /// `data` field must be a String due to legacy reasons where there was unstructured data send to the backend by other platforms.
    /// As some devices are still using that endpoint we needed to keep the legacy support. This will be updated to a better endpoint in the near future.
    ///
    struct Body: Encodable {
        let data: String
    }

    struct HealthData: Encodable {
        let timestamp: Int
        let charge: Int
    }

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/submitHealthParsed")
        request.httpMethod = HTTPMethod.POST
        request.add(header: HTTPHeader.contentType(.json))

        let healthData = [HealthData(timestamp: timestamp, charge: charge)]
        let jsonData = try JSONEncoder().encode(healthData)
        let body = Body(
            data: String(data: jsonData, encoding: .utf8) ?? ""
        )
        
        request.httpBody = try JSONEncoder().encode(body)

        return request
    }
}
