struct DeviceRegistrationResponseDTO: Decodable {
    let publicKey: String
}

struct DeviceRegistrationResponseMapper: Mapper {
    func map(from object: DeviceRegistrationResponseDTO) -> String {
        object.publicKey
    }
}
