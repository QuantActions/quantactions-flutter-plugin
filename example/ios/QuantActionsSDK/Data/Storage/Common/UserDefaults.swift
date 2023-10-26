import Foundation

extension UserDefaults {
    func decodable<T: Decodable>(forKey key: String) -> T? {
        do {
            guard let data = data(forKey: key) else {
                return nil
            }
            let object = try JSONDecoder().decode(DecodableWrapper<T>.self, from: data)
            return object.value
        } catch {
            debugPrint(error)
        }
        return nil
    }

    func set<T: Encodable>(encodable: T, key: String) {
        do {
            let data = try JSONEncoder().encode(EncodableWrapper(value: encodable))
            set(data, forKey: key)
        } catch {
            debugPrint(error)
        }
    }

    func remove(key: String) {
        removeObject(forKey: key)
    }
}
