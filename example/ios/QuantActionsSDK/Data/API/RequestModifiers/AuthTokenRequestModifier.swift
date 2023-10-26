import Foundation

struct AuthTokenRequestModifier: URLRequestModifier {
    func modify(urlRequest: URLRequest) async throws -> URLRequest {
        var request = urlRequest
        request.addValue(
            Config.Auth.apiKey,
            forHTTPHeaderField: "Authorization"
        )
        return request
    }
}

