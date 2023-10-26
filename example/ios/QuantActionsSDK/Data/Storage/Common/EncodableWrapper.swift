import Foundation

struct EncodableWrapper<T: Encodable> : Encodable {
    let value: T
}
