import Combine

public typealias APIResult<T> = AnyPublisher<T, APIError>

public struct ObservableResult<T> {
    let result: APIResult<T>
    let fetching: (() -> Void)?
    let success: ((T) -> Void)?
    let failure: ((APIError) -> Void)?
    let finished: (() -> Void)?
    
    public func fetching(_ fetching: @escaping () -> Void) -> Self {
        return .init(result: result, fetching: fetching, success: success, failure: failure, finished: finished)
    }
    
    public func success(_ success: @escaping (T) -> Void) -> Self {
        return .init(result: result, fetching: fetching, success: success, failure: failure, finished: finished)
    }
    
    public func failure(_ failure: @escaping (APIError) -> Void) -> Self {
        return .init(result: result, fetching: fetching, success: success, failure: failure, finished: finished)
    }
    
    public func finished(_ finished: @escaping () -> Void) -> Self {
        return .init(result: result, fetching: fetching, success: success, failure: failure, finished: finished)
    }
    
    public func observe(_ subscriptions: inout Set<AnyCancellable>) {
        fetching?()
        result.sink { completion in
            switch completion {
            case .failure(let error): failure?(error)
            case .finished:
                finished?()
            }
        } receiveValue: { output in
            success?(output)
        }
        .store(in: &subscriptions)
    }
}

public extension APIResult where Failure == APIError {
    func observe() -> ObservableResult<Output> {
        .init(result: self, fetching: nil, success: nil, failure: nil, finished: nil)
    }
}
