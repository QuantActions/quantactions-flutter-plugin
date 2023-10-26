import Foundation

struct DecodableWrapper<T: Decodable> : Decodable {
    let value: T
}
