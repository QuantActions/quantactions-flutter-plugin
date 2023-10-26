/// Struct containing the information about a study and all of its questionnaires.
public struct SubscriptionWithQuestionnaires {
    /// the ``Cohort`` (a.k.a. study)
    public let cohort: Cohort

    /// the array of ``Questionnaire`` associated with the study
    public let questionnaires: [Questionnaire]

    /// the id of the subscription (a.k.a. participationID)
    public let subscriptionID: String

    /// the list of tap device ids associated with the subscription
    public let tapDeviceIDs: [String]

    /// the time to live of the premium features associated with the subscription
    public let premiumFeaturesTTL: Int
}

/// When subscribing to a cohort with a cohort ID or a subscription ID, the call will return a model
/// which contains all information related to the cohort including necessary
/// permissions and privacy policy.
public struct Cohort {
    /// Identification UUID fo the cohort
    public let id: String

    /// Human readable title
    public let name: String

    /// Privacy policy
    public let privacyPolicy: String

    /// It is `true` if the device is allowed to withdraw, if `false` only the cohort manager can withdraw the device
    public let canWidthdraw: Bool
}

/// Struct containing all information about a questionnaire that the user can fill in.
public struct Questionnaire {
    /// UUID of the questionnaire
    public let id: String

    /// Name of the questionnaire
    public let name: String

    /// Informal description of the questionnaire
    public let description: String

    /// Code - only used internally
    public let code: String

    /// Cohort ID to which this questionnaire is bound
    public let cohortID: String

    /// Body of the questionnaire in JSON format
    public let body: String
}
