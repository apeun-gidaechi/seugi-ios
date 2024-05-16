public enum FetchFlow<Data: Equatable>: Equatable {
    case success(data: Data)
    case failure
    case fetching
}
