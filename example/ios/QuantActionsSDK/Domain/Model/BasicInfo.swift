/// Data struct containing basic demographic information of the user associated with the device.
public struct BasicInfo: Codable {
    public var yearOfBirth: Int
    public var gender: Gender
    public var selfDeclaredHealthy: Bool

    /// Creates an instance with the given year of birth, gender and self declared healthy.
    ///
    /// - Parameters:
    ///   - yearOfBirth: Year of birth e.g. 1985
    ///   - gender: Gender of the user, see available settings in ``Gender``
    ///   - selfDeclaredHealthy: Whether or not the user declares themselves as being healthy, this can be left blank if unknown
    public init(
        yearOfBirth: Int = 0,
        gender: Gender = .unknown,
        selfDeclaredHealthy: Bool = false
    ) {
        self.yearOfBirth = yearOfBirth
        self.gender = gender
        self.selfDeclaredHealthy = selfDeclaredHealthy
    }
}
