import Foundation

struct JournalEntryUpdateRequest: URLRequestBuilder {
    let deviceID: String
    let body: Body

    struct Body: Encodable {
        let entry: Entry
        let oldEntryID: String

        enum CodingKeys: String, CodingKey {
            case entry
            case oldEntryID = "old_entry_id"
        }
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
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/journalEntryUpdate")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(body)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
