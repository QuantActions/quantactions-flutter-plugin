import Foundation

struct JournalEntryDeleteRequest: URLRequestBuilder {
    let deviceID: String
    let body: Body

    struct Body: Encodable {
        let journalEntryID: String

        enum CodingKeys: String, CodingKey {
            case journalEntryID = "journal_entry_id"
        }
    }

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/journalEntryDelete")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(body)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
