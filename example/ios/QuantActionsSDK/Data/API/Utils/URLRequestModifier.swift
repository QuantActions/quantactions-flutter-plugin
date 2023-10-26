import Foundation

protocol URLRequestModifier {
    func modify(urlRequest: URLRequest) async throws -> URLRequest
}
