import Foundation

enum HTTPHeader: Hashable {

    enum ContentType: Hashable {
        case urlFormEncoded
        case json
        case multipart(boundary: String)
        case file(mimeType: String)

        fileprivate var value: String {
            switch self {
            case .urlFormEncoded:
                return "application/x-www-form-urlencoded"
            case .json:
                return "application/json"
            case .multipart(let boundary):
                return "multipart/form-data; boundary=\(boundary)"
            case .file(let mimeType):
                return mimeType
            }
        }
    }

    enum Authorization: Hashable {
        case basic(String)
        case bearer(String)

        fileprivate var value: String {
            switch self {
            case .basic(let token):
                return "Basic \(token)"
            case .bearer(let token):
                return "Bearer \(token)"
            }
        }
    }

    case contentType(ContentType)
    case authorization(Authorization)
    case xAuthToken(String)
    case accept(ContentType)

    case device(String)
    case deviceIdentifier(String)
    case language(String)
    case custom(String, String)

    var key: String {
        switch self {
        case .authorization:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        case .xAuthToken:
            return "X-Auth-Token"
        case .accept:
            return "Accept"
        case .device:
            return "Device-Type"
        case .deviceIdentifier:
            return "Device-Identifier"
        case .language:
            return "App-Language"
        case .custom(let key, _):
            return key
        }
    }

    var value: String {
        switch self {
        case .authorization(let authorization):
            return authorization.value
        case .contentType(let contentType), .accept(let contentType):
            return contentType.value
        case .xAuthToken(let authorization):
            return authorization
        case .device(let type):
            return type
        case .deviceIdentifier(let identifier):
            return identifier
        case .language(let languageCode):
            return languageCode
        case .custom(_, let value):
            return value
        }
    }
}
