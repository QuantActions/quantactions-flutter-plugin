struct TapDataDTO: Encodable {
    let sessionId: String
    let startUnixTime: Int
    let endUnixTime: Int
    let timeZone: Double
    let appContext: String
    let orientation: String
    let taps: [Int]
    let wordsData: [WordsDataDTO]
    let deleteData: [DeleteDataDTO]

    struct WordsDataDTO: Encodable {
        let autocorrection: Bool
        let swipe: Bool
        let timestamp: Int
    }

    struct DeleteDataDTO: Encodable {
        let type: Int
        let timestamp: Int
    }
}

struct FleksyKeyboardToTapDataDTOMapper: Mapper {
    func map(from object: FleksyKeyboardData) -> TapDataDTO {
        TapDataDTO(
            sessionId: object.sessionId,
            startUnixTime: object.startUnixTime,
            endUnixTime: object.endUnixTime,
            timeZone: object.timeZone,
            appContext: object.appContext,
            orientation: OrientationMapper().map(from: object.screenSizePx),
            taps: object.tapEvent.map {
                object.startUnixTime + $0.touchBegin.timestamp
            },
            wordsData: object.wordsData.map {
                WordsDataMapper(sessionStartUnixTime: object.startUnixTime).map(from: $0)
            },
            deleteData: object.deleteData.map {
                DeleteDataMapper(sessionStartUnixTime: object.startUnixTime).map(from: $0)
            }
        )
    }

    struct OrientationMapper: Mapper {
        func map(from object: FleksyKeyboardData.ScreenSizePx) -> String {
            if object.width < object.height {
                return "P"
            } else {
                return "L"
            }
        }
    }

    struct WordsDataMapper: Mapper {
        let sessionStartUnixTime: Int

        func map(from object: FleksyKeyboardData.WordsData) -> TapDataDTO.WordsDataDTO {
            TapDataDTO.WordsDataDTO(
                autocorrection: object.autocorrection,
                swipe: object.swipe,
                timestamp: sessionStartUnixTime + object.timestamp
            )
        }
    }

    struct DeleteDataMapper: Mapper {
        let sessionStartUnixTime: Int

        func map(from object: FleksyKeyboardData.DeleteData) -> TapDataDTO.DeleteDataDTO {
            TapDataDTO.DeleteDataDTO(
                type: object.type,
                timestamp: sessionStartUnixTime + object.timestamp
            )
        }
    }
}


