struct ParticipationsResponseDTO: Decodable {
    let participations: [DeviceParticipationDTO]
}

struct DeviceParticipationDTO: Decodable {
    let id: String
    let participationId: String
    let tapDeviceId: String
    let privacyPolicyDate: String?
    let dates: String?
    let lastCheckInDate: String?
    let lastCheckOutDate: String?
    let center: String?
    let created: String?
    let modified: String?
    let participation: ParticipationDTO?
}

struct ParticipationDTO: Decodable {
    let id: String
    let studyId: String
    let study: StudyDTO
    let modified: String
    let ttlInMillis: String
    let deviceParticipations: [DeviceParticipationDTO]
}

struct StudyDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let emailTemplate: String?
    let privacyPolicy: String
    let privacyPolicyDate: String
    let dataPattern: String?
    let canWithdraw: Int
    let includeDeviceNotes: Int?
    let rawDataAccess: Int?
    let deviceIdAccess: Int?
    let perimeterCheck: Int?
    let syncOnScreenOff: Int?
    let gpsResolution: Int?
    let permAppId: Int?
    let permDrawOver: Int?
    let permLocation: Int?
    let permContact: Int?
    let studyIdSignUpAccess: Int?
    let created: String?
    let modified: String?
    let userId: String?
    let questionnaires: [QuestionnaireDTO]?
    let premiumFeaturesTTL: Int?
}

struct QuestionnaireDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let definition: String
    let created: String
    let modified: String
}

struct ParticipationsResponseMapper: Mapper {
    func map(from object: ParticipationsResponseDTO) -> [SubscriptionWithQuestionnaires] {
        object.participations.compactMap {
            guard let participation = $0.participation else {
                return nil
            }
            return ParticipationToSubscriptionWithQuestionnairesMapper().map(from: participation)
        }
    }
}

struct ParticipationToSubscriptionWithQuestionnairesMapper: Mapper {
    func map(from object: ParticipationDTO) -> SubscriptionWithQuestionnaires {
        let study = object.study

        let questionnaires = study.questionnaires?.map {
            QuestionnaireMapper(study: object.study).map(from: $0)
        }

        let tapDeviceIDs = object.deviceParticipations.map { $0.id }

        return SubscriptionWithQuestionnaires(
            cohort: Cohort(
                id: study.id,
                name: study.title,
                privacyPolicy: study.privacyPolicy,
                canWidthdraw: study.canWithdraw == 1
            ),
            questionnaires: questionnaires ?? [],
            subscriptionID: object.id,
            tapDeviceIDs: tapDeviceIDs,
            premiumFeaturesTTL: Int(object.ttlInMillis) ?? -1
        )
    }
}

struct QuestionnaireMapper: Mapper {
    let study: StudyDTO

    func map(from object: QuestionnaireDTO) -> Questionnaire {
        Questionnaire(
            id: "\(study.id):\(object.id)",
            name: object.title,
            description: object.description,
            code: object.id,
            cohortID: study.id,
            body: object.definition
        )
    }
}
