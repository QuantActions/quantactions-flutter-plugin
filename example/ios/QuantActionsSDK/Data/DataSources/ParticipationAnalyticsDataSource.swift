struct ParticipationAnalyticsDataSource {
    func statistics<DataItem: Decodable>(
        partitionKey: String,
        code: String,
        dateInterval: DateInterval
    ) async throws -> [StatisticResponseItemDTO<DataItem>] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"

        let request = AnalyticsRequest(
            partitionKey: partitionKey,
            containerName: String(code.split(separator: "-").first ?? ""),
            code: code,
            from: dateFormatter.string(from: dateInterval.start),
            to: dateFormatter.string(from: dateInterval.end)
        )

        return try await APIClient.execute(requestBuilder: request)
    }
}
