import Foundation

struct FleksyKeyboardData: Decodable {
    let sessionId: String
    let startUnixTime: Int
    let endUnixTime: Int
    let timeZone: Double
    let appContext: String
    let screenSizePx: ScreenSizePx
    let tapEvent: [TapEvent]
    let wordsData: [WordsData]
    let deleteData: [DeleteData]

    struct ScreenSizePx: Decodable {
        public let width: Double
        public let height: Double
    }

    struct TapEvent: Decodable {
        public let touchBegin: TouchBegin

        public struct TouchBegin: Decodable {
            public let timestamp: Int
        }
    }

    struct WordsData: Decodable {
        public let autocorrection: Bool
        public let swipe: Bool
        public let timestamp: Int
    }

    struct DeleteData: Decodable {
        public let type: Int
        public let timestamp: Int
    }
}

struct FleksyKeyboardDataMapper: Mapper {
    func map(from object: String) throws -> FleksyKeyboardData {
        guard
            let data = object.data(using: .utf8),
            let fleksyKeyboardData = try? JSONDecoder().decode(FleksyKeyboardData.self, from: data)
        else {
            throw LocalError.descriptive("Couldn't decode FleksyKeyboardData")
        }

        return fleksyKeyboardData
    }
}
