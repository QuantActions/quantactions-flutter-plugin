struct DeviceInfo: Encodable {
    let iOSVersion: String
    let manufacturer: String = "Apple"
    let model: String
    let language: String
    let sdkVersion: Int
    let type: String
    
    init(
        iOSVersion: String,
        deviceModel: String,
        language: String,
        sdkVersion: Int,
        deviceType: String
    ) {
        self.iOSVersion = iOSVersion
        self.model = deviceModel
        self.language = language
        self.sdkVersion = sdkVersion
        self.type = deviceType
    }
    
    enum CodingKeys: String, CodingKey {
        case iOSVersion = "iOSVersion"
        case manufacturer = "deviceManufacturer"
        case model = "deviceModel"
        case language = "language"
        case sdkVersion = "SDKversion"
        case type = "deviceType"
    }
}
