public enum FetchFlow<Data> {
    case Success(data: Data)
    case Failure
    case Fetching
}
