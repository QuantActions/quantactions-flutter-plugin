/// Holds the information about the current subscription. It returns the
/// subscription ID, the list of device IDs connected to this subscription and the cohort ID relative to
/// the subscription.
public struct Subscription {
    /// Of the form `138e...28eb`
    public let id: String

    /// List of UUIDs
    public let deviceIDs: [String]

    /// Of the form `aef3...de19`
    public let cohortID: String

    public let cohortName: String

    public let premiumFeaturesTTL: Int
}

struct SubscriptionWithQuestionnairesToSubscriptionMapper: Mapper {
    func map(from object: SubscriptionWithQuestionnaires) -> Subscription {
        Subscription(
            id: object.subscriptionID,
            deviceIDs: object.tapDeviceIDs,
            cohortID: object.cohort.id,
            cohortName: object.cohort.name,
            premiumFeaturesTTL: object.premiumFeaturesTTL
        )
    }
}
