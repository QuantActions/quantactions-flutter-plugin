struct MetricsAndTrendsGroupingHelper<Element: DataPointElement, M: Mapper> where M.From == [Element], M.To: DataPointElement {
    let input: [DataPoint<Element>]
    let mapper: M

    var monthly: [DataPoint<M.To>] {
        extractItems(forDateComponents: [.year, .month])
    }

    var weekly: [DataPoint<M.To>] {
        extractItems(forDateComponents: [.weekOfYear, .yearForWeekOfYear])
    }

    private func extractItems(forDateComponents components: Set<Calendar.Component>) -> [DataPoint<M.To>] {
        let grouped = Dictionary(
            grouping: input,
            by: {
                let components = Calendar.current.dateComponents(components, from: $0.date)
                return Calendar.current.date(from: components) ?? $0.date
            }
        )

        let result = grouped.map { key, value in
            let elements = value.compactMap { $0.element }

            if elements.isEmpty {
                return DataPoint<M.To>(
                    date: key,
                    element: nil
                )
            }

            return DataPoint(
                date: key,
                element: try? mapper.map(from: elements)
            )
        }

        return result.sorted(by: { $0.date < $1.date })
    }
}
