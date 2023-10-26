import Foundation

struct Response {
    let body: Data
    let httpResponse: HTTPURLResponse
}

enum HTTPClientError: Error {
    case invalidRequest
    case noResponse
    case badServerResponse(status: Int, data: Data)
}

//TODO: Logger
struct HTTPClient {
    static func execute(urlRequest: URLRequest) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.noResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw HTTPClientError.badServerResponse(status: httpResponse.statusCode, data: data)
        }

        return Response(body: data, httpResponse: httpResponse)
    }
}
