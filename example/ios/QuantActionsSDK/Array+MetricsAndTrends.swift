public extension Array where Element == DataPoint<SleepSummaryElement> {
    var monthlyAverages: [DataPoint<AveragesSleepSummaryElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: SleepSummaryElementsToAveragesMapper()
        )
        .monthly
    }

    var weeklyAverages: [DataPoint<AveragesSleepSummaryElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: SleepSummaryElementsToAveragesMapper()
        )
        .weekly
    }
}

public extension Array where Element == DataPoint<DoubleValueElement> {
    var monthlyAverages: [DataPoint<DoubleValueElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: DoubleValueElementsToAveragesMapper()
        )
        .monthly
    }

    var weeklyAverages: [DataPoint<DoubleValueElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: DoubleValueElementsToAveragesMapper()
        )
        .weekly
    }
}

public extension Array where Element == DataPoint<TrendElement> {
    var monthlyAverages: [DataPoint<TrendElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: TrendElementsToAveragesMapper()
        )
        .monthly
    }

    var weeklyAverages: [DataPoint<TrendElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: TrendElementsToAveragesMapper()
        )
        .weekly
    }
}

public extension Array where Element == DataPoint<ScreenTimeAggregateElement> {
    var monthlyAverages: [DataPoint<ScreenTimeAggregateElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: ScreenTimeAggregateElementsToAveragesMapper()
        )
        .monthly
    }

    var weeklyAverages: [DataPoint<ScreenTimeAggregateElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: ScreenTimeAggregateElementsToAveragesMapper()
        )
        .weekly
    }
}

public extension Array where Element == DataPoint<SleepScoreElement> {
    var monthlyAverages: [DataPoint<SleepScoreElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: SleepScoreElementsToAveragesMapper()
        )
        .monthly
    }

    var weeklyAverages: [DataPoint<SleepScoreElement>] {
        MetricsAndTrendsGroupingHelper(
            input: self,
            mapper: SleepScoreElementsToAveragesMapper()
        )
        .weekly
    }
}
