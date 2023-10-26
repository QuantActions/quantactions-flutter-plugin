struct StatisticResponseItemDTO<DataItem: Decodable>: Decodable {
    let metrics: StatisticCoreDTO<DataItem>
    let code: String
    let timestamp: String
}

struct StatisticCoreDTO<DataItem: Decodable>: Decodable {
    let data: [DataItem]
}
