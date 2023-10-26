import Foundation

extension URLRequest {
    init(string: String) throws {
        guard let url = URL(string: string) else {
            throw LocalError.descriptive("Invalid URL string")
        }
        self.init(url: url)
    }

    mutating func add(header: HTTPHeader) {
        addValue(header.value, forHTTPHeaderField: header.key)
    }
}
