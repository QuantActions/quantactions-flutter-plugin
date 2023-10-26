import Foundation

protocol URLRequestBuilder {
    func build() throws -> URLRequest
}
