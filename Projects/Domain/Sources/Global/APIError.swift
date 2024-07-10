public enum APIError: Error, Equatable {
    case http(BaseVoid)
    case unknown
    case refreshFailure
}
