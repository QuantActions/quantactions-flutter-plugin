import Foundation

struct JournalEntriesRequest: URLRequestBuilder {
    let deviceID: String
    
    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/journalEntriesGet")
        request.httpMethod = HTTPMethod.GET
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
