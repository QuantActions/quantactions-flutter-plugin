enum LocalError: Error {
    case descriptive(String)
    case mapping(AnyKeyPath)
}
