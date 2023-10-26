@_implementationOnly import RealmSwift

struct MetricCode {
    static let actionSpeed = "001-003-003-002"
    static let typingSpeed = "001-003-004-002"
    static let cognitiveFitness = "003-001-001-003"
    static let socialEngagement = "003-001-001-004"
    static let socialTaps = "001-005-005-011"
    static let sleepScore = "003-001-001-002"
    static let screenTimeAggregate = "003-001-001-005"
    static let sleepSummary = "001-002-006-004"
}

struct TrendCode {
    static let cognitiveFitness = "003-003-002-004"
    static let actionSpeed = "003-003-002-001"
    static let typingSpeed = "003-003-002-003"
    static let sleepScore = "003-003-001-004"
    static let sleepLength = "003-003-001-001"
    static let sleepInterruptions = "003-003-001-003"
    static let socialEngagement = "003-003-003-005"
    static let socialScreenTime = "003-003-003-002"
    static let socialTaps = "003-003-003-004"
    static let wave = "003-003-004-001"
}

struct MetricsAndTrendsRepository {
    private let participationAnalyticsDataSource = ParticipationAnalyticsDataSource()

    func actionSpeedMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricOrTrend(
            realmType: DoubleValueMetricDBO.self,
            remoteType: ActionDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.actionSpeed,
            resultMapper: DoubleValueElementMapper()
        )
    }

    func typingSpeedMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricOrTrend(
            realmType: DoubleValueMetricDBO.self,
            remoteType: TypingDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.typingSpeed,
            resultMapper: DoubleValueElementMapper()
        )
    }

    func cognitiveFitnessMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricOrTrend(
            realmType: DoubleValueMetricDBO.self,
            remoteType: CognitiveDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.cognitiveFitness,
            resultMapper: DoubleValueElementMapper()
        )
    }

    func socialEngagementMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricOrTrend(
            realmType: DoubleValueMetricDBO.self,
            remoteType: SocialDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.socialEngagement,
            resultMapper: DoubleValueElementMapper()
        )
    }

    func socialTapsMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricOrTrend(
            realmType: DoubleValueMetricDBO.self,
            remoteType: SocialTapsDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.socialTaps,
            resultMapper: DoubleValueElementMapper()
        )
    }

    func sleepScoreMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<SleepScoreElement>] {
        try await metricOrTrend(
            realmType: SleepScoreMetricDBO.self,
            remoteType: SleepDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.sleepScore,
            resultMapper: SleepScoreElementMapper()
        )
    }

    func screenTimeAggregateMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<ScreenTimeAggregateElement>] {
        try await metricOrTrend(
            realmType: ScreenTimeAggregateMetricDBO.self,
            remoteType: ScreenTimeAggregateDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.screenTimeAggregate,
            resultMapper: ScreenTimeAggregateElementMapper()
        )
    }

    func sleepSummaryMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<SleepSummaryElement>] {
        try await metricOrTrend(
            realmType: SleepSummaryMetricDBO.self,
            remoteType: SleepSummaryDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: MetricCode.sleepSummary,
            resultMapper: SleepSummaryElementMapper()
        )
    }

    func cognitiveFitnessTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.cognitiveFitness,
            resultMapper: TrendElementMapper()
        )
    }

    func actionSpeedTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.actionSpeed,
            resultMapper: TrendElementMapper()
        )
    }

    func typingSpeedTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.typingSpeed,
            resultMapper: TrendElementMapper()
        )
    }

    func sleepScoreTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.sleepScore,
            resultMapper: TrendElementMapper()
        )
    }

    func sleepLengthTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.sleepLength,
            resultMapper: TrendElementMapper()
        )
    }

    func sleepInterruptionsTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.sleepInterruptions,
            resultMapper: TrendElementMapper()
        )
    }

    func socialEngagementTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.socialEngagement,
            resultMapper: TrendElementMapper()
        )
    }

    func socialScreenTimeTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.socialScreenTime,
            resultMapper: TrendElementMapper()
        )
    }

    func socialTapsTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.socialTaps,
            resultMapper: TrendElementMapper()
        )
    }

    func waveTrend(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<TrendElement>] {
        try await metricOrTrend(
            realmType: TrendDBO.self,
            remoteType: TrendDataItemDTO.self,
            participationID: participationID,
            interval: interval,
            code: TrendCode.wave,
            resultMapper: TrendElementMapper()
        )
    }

    @BackgroundActor
    private func metricOrTrend<RealmElement: RealmFetchable, RemoteElement: Decodable, M: Mapper>(
        realmType: RealmElement.Type,
        remoteType: RemoteElement.Type,
        participationID: String,
        interval: DateInterval,
        code: String,
        resultMapper: M
    ) async throws -> [DataPoint<M.To>] where RealmElement: MetricOrTrendDBO, RemoteElement: MappableToMetricOrTrendDBO, M.From == RealmElement  {
        let realm = try await Realm(
            configuration: Config.RealmConfig.configuration,
            actor: BackgroundActor.shared
        )

        let firstObject = realm.objects(RealmElement.self)
            .where { $0.code == code && $0.date >= interval.start && $0.date <= interval.end }
            .sorted(by: \.timestamp)
            .first

        let twoHoursAgo = Calendar.current.date(byAdding: .hour, value: -2, to: .now) ?? .now
        let shouldUpdateFromRemote = firstObject == nil || (firstObject?.updatedAt ?? .now) < twoHoursAgo

        if shouldUpdateFromRemote {
            let statistics: [StatisticResponseItemDTO<RemoteElement>] = try await participationAnalyticsDataSource.statistics(
                partitionKey: participationID,
                code: code,
                dateInterval: interval
            )

            let dbos = statistics
                .flatMap { $0.metrics.data }
                .map { $0.map(code: code) }

            try realm.write {
                dbos.forEach { dbo in
                    realm.add(dbo, update: .modified)
                }
            }
        }

        let objects = realm.objects(RealmElement.self)
            .where { $0.code == code && $0.date >= interval.start && $0.date <= interval.end }
            .sorted(by: \.date)

        let objectsArray = Array(objects)

        let days = Calendar.current.generateStartsOfDays(for: interval)

        return try days.map { day in
            let item = objectsArray.first(where: {
                Calendar.current.isDate($0.date, equalTo: day, toGranularity: .day)
            })

            if let item {
                return DataPoint(
                    date: day,
                    element: try resultMapper.map(from: item)
                )
            }

            return DataPoint(
                date: day,
                element: nil
            )
        }
    }
}
