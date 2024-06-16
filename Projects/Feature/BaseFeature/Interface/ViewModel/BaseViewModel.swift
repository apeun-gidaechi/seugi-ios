import Foundation
import Combine
import SwiftUtil
import Domain

open class BaseViewModel<Subject>: ObservableObject {
    public var subscriptions = Set<AnyCancellable>()
    private let subject = PassthroughSubject<Subject, Never>()
    
    public init() {}
    
    public func sub<T>(
        _ publisher: APIResult<T>,
        fetching: @escaping () -> Void,
        success: @escaping (T) -> Void,
        failure: @escaping (APIError) -> Void,
        finished: @escaping () -> Void = {}
    ) {
        publisher
            .sink {
                switch $0 {
                case .finished:
                    finished()
                default:
                    break
                }
            } receiveValue: { result in
                switch result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    failure(error)
                case .fetching:
                    fetching()
                }
            }
            .store(in: &subscriptions)
    }
    
    public func subscribe(_ subscriber: @escaping (Subject) -> Void) {
        subject
            .sink(receiveValue: subscriber)
            .store(in: &subscriptions)
    }
    
    public func emit(_ value: Subject) {
        subject.send(value)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}
