import Foundation

struct JournalEntrySubmitRequest: URLRequestBuilder {
    let deviceID: String
    let body: Body

    struct Body: Encodable {
        let entry: Entry
    }

    struct Entry: Encodable {
        let id: String
        let note: String
        let created: String
        let events: [Event]

        enum CodingKeys: String, CodingKey {
            case id
            case note
            case created
            case events
        }

        struct Event: Encodable {
            let id: String
            let journalEventID: String
            let rating: Int

            enum CodingKeys: String, CodingKey {
                case id = "id"
                case journalEventID = "journal_event_id"
                case rating = "rating"
            }
        }
    }

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/journalEntrySubmit")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(body)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
