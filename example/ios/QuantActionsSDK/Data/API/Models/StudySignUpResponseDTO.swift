struct StudySignUpResponseDTO: Decodable {
    let participationId: String
    let privacyPolicy: String
    let privacyPolicyDate: String
    let studyId: String
    let study: StudyDTO
    let studyTitle: String
    let dataPattern: String
    let perimeterCheck: Int
    let syncOnScreenOff: Int
    let gpsResolution: Int
    let canWithdraw: Int
    let permAppId: Int
    let permDrawOver: Int
    let permLocation: Int
    let permContact: Int
    let deviceParticipationId: String?
    let participationModified: String?
    let participationTtlInMillis: String
    let deviceParticipations: [DeviceParticipationDTO]
}

struct StudySignUpResponseMapper: Mapper {
    func map(from object: StudySignUpResponseDTO) -> SubscriptionWithQuestionnaires {
        let study = object.study
        let tapDeviceIDs = object.deviceParticipations.map { $0.tapDeviceId }

        let cohort = Cohort(
            id: study.id,
            name: study.title,
            privacyPolicy: study.privacyPolicy,
            canWidthdraw: study.canWithdraw == 1
        )

        let questionnaires = study.questionnaires?.map {
            QuestionnaireMapper(study: object.study).map(from: $0)
        }

        return SubscriptionWithQuestionnaires(
            cohort: cohort,
            questionnaires: questionnaires ?? [],
            subscriptionID: object.participationId,
            tapDeviceIDs: tapDeviceIDs,
            premiumFeaturesTTL: Int(object.participationTtlInMillis) ?? -1
        )
    }
}
