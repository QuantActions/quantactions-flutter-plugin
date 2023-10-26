import Foundation

enum NetworkError: Error {
    case invalidRequest
    case noResponse
    case badServerResponse(status: Int, data: Data)
}
