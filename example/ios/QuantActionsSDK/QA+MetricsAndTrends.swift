public extension QA {
    /// Retrieves Action Speed metric.
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``DoubleValueElement``s.
    func actionSpeedMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricsAndTrendsRepository.actionSpeedMetric(
            participationID: participationID,
            interval: interval
        )
    }

    /// Retrieves Typing Speed metric.
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``DoubleValueElement``s.
    func typingSpeedMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricsAndTrendsRepository.typingSpeedMetric(
            participationID: participationID,
            interval: interval
        )
    }

    /**
     *  Retrieves Cognitive Fitness metric.
     *
     * **Cognitive fitness reflects how quickly you are able to see, understand and act.**
     *
     * Cognitive Processing Speed measures your cognitive fitness, which is a composition of various cognitive skills.
     *
     * Examples of these cognitive skills are:
     *   - The ability to focus your attention on a single stimulation
     *   - A contextual memory, that enables you to recall the source and circumstance of a certain event
     *   - Good hand-eye coordination
     *   - The ability to execute more than one action at a time
     *
     * **The higher your Cognitive Processing Speed, the more efficient your ability to think and learn.**
     *
     * Chronic stress is likely to negatively affect key cognitive functions such as memory, reaction times, attention span, and concentration skills. It is also likely that high stress levels will cause performance variability.
     *
     * When monitoring your cognitive fitness, these components are used (privacy is ensured and there's no tracking in terms of content):
     *  - Your tapping speed
     *  - Your typing speed
     *  - Your unlocking speed
     *  - Your app locating speed (how long it takes you to find apps that you're using)
     *
     * The score doesn't measure your efficiency in using your smartphone or executing one particular task. The focus is on the totality and consistency of your behaviour, not on certain maximum scores. Individual actions do not contribute to an increase or decrease in your score, e.g. if it takes you a little longer to find something because you were busy doing something else at the same time.
     *
     * Checkout our scientific literature about cognitive fitness:
     * - [Can you hear me now? Momentary increase in smartphone usage enhances neural processing of task-irrelevant sound tones](https://www.sciencedirect.com/science/article/pii/S2666956022000551?via%3Dihub)
     * - [Reopening after lockdown: the influence of working-from-home and digital device use on sleep, physical activity, and wellbeing following COVID-19 lockdown and reopening](https://academic.oup.com/sleep/article/45/1/zsab250/6390581)
     * - [Generalized priority-based model for smartphone screen touches](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.102.012307)
     * - [The details of past actions on a smartphone touchscreen are reflected by intrinsic sensorimotor dynamics](https://www.nature.com/articles/s41746-017-0011-3)
     * - [Use-Dependent Cortical Processing from Fingertips in Touchscreen Phone Users](https://www.cell.com/current-biology/fulltext/S0960-9822(14)01487-0?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS0960982214014870%3Fshowall%3Dtrue)
     * */
    ///
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``DoubleValueElement``s.
    func cognitiveFitnessMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricsAndTrendsRepository.cognitiveFitnessMetric(
            participationID: participationID,
            interval: interval
        )
    }
    
    /**
     * Retrieves Social Engagement metric.
     *
     * **Social Engagement is the process of engaging in digital activities in a social group. Engaging in social relationships benefits brain health.**
     *
     * While it has been long known that social interactions are good for you, digital social engagement is a new indicator of brain health. Recent studies have linked smartphone social engagement with the production of dopamine—the hormone that helps us feel pleasure as part of the brain’s reward system. Here are some examples of smartphone social interactions:
     *
     * - Text messaging
     * - Checking social media (e.g. Facebook, Instagram etc.)
     * - Playing multi-player smartphone games
     *
     * Other ways we use our smartphones like watching videos, reading news articles, and playing single-player games do not count as social interactions. The level of digital social engagement helps us to probe brain activity (synthesis of dopamine) which consequently helps us understand more about brain health.
     *
     * Checkout our scientific literature about social engagement:
     * - [Striatal dopamine synthesis capacity reflects smartphone social activity](https://www.cell.com/iscience/fulltext/S2589-0042(21)00465-X?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS258900422100465X%3Fshowall%3Dtrue)
     * */
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``DoubleValueElement``s.
    func socialEngagementMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricsAndTrendsRepository.socialEngagementMetric(
            participationID: participationID,
            interval: interval
        )
    }
    
    /// Retrieves Social Taps metric.
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``DoubleValueElement``s.
    func socialTapsMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<DoubleValueElement>] {
        try await metricsAndTrendsRepository.socialTapsMetric(
            participationID: participationID,
            interval: interval
        )
    }

    /**
     *  Retrieves Screen Time Aggregate metric.
     *
     * **Cognitive fitness reflects how quickly you are able to see, understand and act.**
     *
     * Cognitive Processing Speed measures your cognitive fitness, which is a composition of various cognitive skills.
     *
     * Examples of these cognitive skills are:
     *   - The ability to focus your attention on a single stimulation
     *   - A contextual memory, that enables you to recall the source and circumstance of a certain event
     *   - Good hand-eye coordination
     *   - The ability to execute more than one action at a time
     *
     * **The higher your Cognitive Processing Speed, the more efficient your ability to think and learn.**
     *
     * Chronic stress is likely to negatively affect key cognitive functions such as memory, reaction times, attention span, and concentration skills. It is also likely that high stress levels will cause performance variability.
     *
     * When monitoring your cognitive fitness, these components are used (privacy is ensured and there's no tracking in terms of content):
     *  - Your tapping speed
     *  - Your typing speed
     *  - Your unlocking speed
     *  - Your app locating speed (how long it takes you to find apps that you're using)
     *
     * The score doesn't measure your efficiency in using your smartphone or executing one particular task. The focus is on the totality and consistency of your behaviour, not on certain maximum scores. Individual actions do not contribute to an increase or decrease in your score, e.g. if it takes you a little longer to find something because you were busy doing something else at the same time.
     *
     * Checkout our scientific literature about cognitive fitness:
     * - [Can you hear me now? Momentary increase in smartphone usage enhances neural processing of task-irrelevant sound tones](https://www.sciencedirect.com/science/article/pii/S2666956022000551?via%3Dihub)
     * - [Reopening after lockdown: the influence of working-from-home and digital device use on sleep, physical activity, and wellbeing following COVID-19 lockdown and reopening](https://academic.oup.com/sleep/article/45/1/zsab250/6390581)
     * - [Generalized priority-based model for smartphone screen touches](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.102.012307)
     * - [The details of past actions on a smartphone touchscreen are reflected by intrinsic sensorimotor dynamics](https://www.nature.com/articles/s41746-017-0011-3)
     * - [Use-Dependent Cortical Processing from Fingertips in Touchscreen Phone Users](https://www.cell.com/current-biology/fulltext/S0960-9822(14)01487-0?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS0960982214014870%3Fshowall%3Dtrue)
     * */
    ///
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``ScreenTimeAggregateElement``s.
    func screenTimeAggregateMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<ScreenTimeAggregateElement>] {
        try await metricsAndTrendsRepository.screenTimeAggregateMetric(
            participationID: participationID,
            interval: interval
        )
    }
    
    /**
     *  Retrieves Sleep Score metric.
     *
     * **Good sleep is crucial for pretty much everything we do.**
     *
     * Sleep is a powerful stress-reliever. It improves concentration, regulates mood, and sharpens judgment skills and decision-making.
     * A lack of sleep not only reduces mental clarity but negatively impacts your ability to cope with stressful situations.
     * So getting a good night’s sleep is incredibly important for your health. In fact, it’s just as important as eating a balanced, nutritious diet and exercising.
     *
     * Getting enough sleep has many benefits. It can help you:
     *   - get sick less often
     *   - reduce stress and improve your mood
     *   - get along better with people
     *   - increase concentration abilities and cognitive speed
     *   - make good decisions and avoid injuries
     *
     * **How much sleep is enough sleep?**
     *
     * The amount of sleep each person needs depends on many factors, including age. For most adults, 7 to 8 hours a night appears to be the best amount of sleep, although some people may need as few as 5 hours or as many as 10 hours of sleep each day.
     *
     * Your sleep is not directly recorded, only your taps on your smartphone are captured and analysed by our algorithm. This includes, for example, when you check the time on your smartphone at night.
     *
     * When monitoring your sleep, these components are used:
     *   - Duration of sleep
     *   - Regularity of sleep
     *   - Sleep interruptions (taps during the night)
     *   - Longest sleep session without interruption
     *
     * The data reflects your sleep patterns over the past 7 days and the most weight is placed on the previous night. This data is fed into a validated algorithm that predicts and estimates the likelihood of when you sleep.
     *
     *
     * Checkout our scientific literature about sleep:
     * - [Large cognitive fluctuations surrounding sleep in daily living](https://www.cell.com/iscience/fulltext/S2589-0042(21)00127-9?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS2589004221001279%3Fshowall%3Dtrue)
     * - [Trait-like nocturnal sleep behavior identified by combining wearable, phone-use, and self-report data](https://www.nature.com/articles/s41746-021-00466-9)
     * - [Capturing sleep–wake cycles by using day-to-day smartphone touchscreen interactions](https://www.nature.com/articles/s41746-019-0147-4)
     * */
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``SleepScoreElement``s.
    func sleepScoreMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<SleepScoreElement>] {
        try await metricsAndTrendsRepository.sleepScoreMetric(
            participationID: participationID,
            interval: interval
        )
    }
    
    /// Retrieves Sleep Summary metric.
    ///
    /// A series of detailed information for each night detected. In particular this series gives information about bed time, wake up time and interruptions of sleep.
    /// See ``SleepSummaryElement`` for more information.
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``SleepSummaryElement``s.
    func sleepSummaryMetric(
        participationID: String,
        interval: DateInterval
    ) async throws -> [DataPoint<SleepSummaryElement>] {
        try await metricsAndTrendsRepository.sleepSummaryMetric(
            participationID: participationID,
            interval: interval
        )
    }

    /// Retreives a trend of a given kind.
    /// - Parameters:
    ///   - participationID: Can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`).
    ///   - interval: `DateInterval` for which to download data.
    /// - Returns: Array of ``DataPoint`` items containing ``TrendElement``s.
    func trend(
        participationID: String,
        interval: DateInterval,
        trendKind: TrendKind
    ) async throws -> [DataPoint<TrendElement>] {
        switch trendKind {
        case .cognitiveFitness:
            return try await metricsAndTrendsRepository.cognitiveFitnessTrend(
                participationID: participationID,
                interval: interval
            )
        case .actionSpeed:
            return try await metricsAndTrendsRepository.actionSpeedTrend(
                participationID: participationID,
                interval: interval
            )
        case .typingSpeed:
            return try await metricsAndTrendsRepository.typingSpeedTrend(
                participationID: participationID,
                interval: interval
            )
        case .sleepScore:
            return try await metricsAndTrendsRepository.sleepScoreTrend(
                participationID: participationID,
                interval: interval
            )
        case .sleepLength:
            return try await metricsAndTrendsRepository.sleepLengthTrend(
                participationID: participationID,
                interval: interval
            )
        case .sleepInterruptions:
            return try await metricsAndTrendsRepository.sleepInterruptionsTrend(
                participationID: participationID,
                interval: interval
            )
        case .socialEngagement:
            return try await metricsAndTrendsRepository.socialEngagementTrend(
                participationID: participationID,
                interval: interval
            )
        case .socialScreenTime:
            return try await metricsAndTrendsRepository.socialScreenTimeTrend(
                participationID: participationID,
                interval: interval
            )
        case .socialTaps:
            return try await metricsAndTrendsRepository.socialTapsTrend(
                participationID: participationID,
                interval: interval
            )
        case .wave:
            return try await metricsAndTrendsRepository.waveTrend(
                participationID: participationID,
                interval: interval
            )
        }
    }
}
