import Foundation
import Combine
import Domain

open class BaseViewModel<Effect>: ObservableObject {
    public var subscriptions = Set<AnyCancellable>()
    private let effect = PassthroughSubject<Effect, Never>()
    
    public init() {}
    
    public func subscribe(_ subscriber: @escaping (Effect) -> Void) {
        effect
            .sink(receiveValue: subscriber)
            .store(in: &subscriptions)
    }
    
    public func emit(_ value: Effect) {
        effect.send(value)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}
