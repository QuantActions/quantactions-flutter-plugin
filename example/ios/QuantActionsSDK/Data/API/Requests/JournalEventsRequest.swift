import Foundation

struct JournalEventsRequest: URLRequestBuilder {
    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/journal_events")
        request.httpMethod = HTTPMethod.GET
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
