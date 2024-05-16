public enum FetchFlow<Data> {
    case success(data: Data)
    case failure
    case fetching
}
