import Combine

public typealias APIResult<T> = AnyPublisher<Result<T>, Never>

public enum Result<Success> {
    case success(_ data: Success)
    case failure(error: APIError)
    case fetching
}

public extension Publisher {
    func asResult() -> APIResult<Output> {
        map { Result.success($0) }
        .prepend(Result.fetching)
        .catch { error in
            if let error = error as? APIError {
                Just(Result<Output>.failure(error: error))
            } else {
                Just(Result<Output>.failure(error: APIError.unknown))
            }
        }
        .eraseToAnyPublisher()
    }
}
