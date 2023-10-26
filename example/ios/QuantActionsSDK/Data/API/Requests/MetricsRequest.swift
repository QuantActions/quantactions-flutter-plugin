import Foundation

struct AnalyticsRequest: URLRequestBuilder {
    let partitionKey: String
    let containerName: String
    let code: String
    let from: String
    let to: String

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/ParticipationAnalytics/getCosmosCode")
        request.url?.append(queryItems: [
            URLQueryItem(name: "patitionKey", value: partitionKey),
            URLQueryItem(name: "containerName", value: containerName),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "to", value: to)
        ])
        request.httpMethod = HTTPMethod.GET
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}
