import Foundation

struct APIClient {
    static func execute<T: Decodable>(
        requestBuilder: URLRequestBuilder,
        modifiers: [URLRequestModifier] = [AuthTokenRequestModifier()]
    ) async throws -> T {
        let result = try await executeRaw(requestBuilder: requestBuilder, modifiers: modifiers)
        return try JSONDecoder().decode(T.self, from: result.body)
    }

    static func executeRaw(
        requestBuilder: URLRequestBuilder,
        modifiers: [URLRequestModifier] = [AuthTokenRequestModifier()]
    ) async throws -> Response {
        let urlRequest = try requestBuilder.build()
        let modifiedRequest = try await apply(modifiers: modifiers, to: urlRequest)

        do {
            return try await HTTPClient.execute(urlRequest: modifiedRequest)
        } catch {
            throw mapError(error)
        }
    }

    private static func apply(modifiers: [URLRequestModifier], to request: URLRequest) async throws -> URLRequest {
        var result = request
        for modifier in modifiers {
            result = try await modifier.modify(urlRequest: result)
        }
        return result
    }

    private static func mapError(_ error: Error) -> Error {
        guard let error = error as? HTTPClientError else {
            return error
        }

        switch error {
        case .invalidRequest:
            return NetworkError.invalidRequest
        case .noResponse:
            return NetworkError.noResponse
        case .badServerResponse(let status, let data):
            return NetworkError.badServerResponse(status: status, data: data)
        }
    }
}
