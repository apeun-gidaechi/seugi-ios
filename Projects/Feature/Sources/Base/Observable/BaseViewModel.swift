import Foundation
import Combine
import Domain

open class BaseViewModel<Effect>: ObservableObject {
    
    @Published var onAppeared = false
    
    public var subscriptions = Set<AnyCancellable>()
    private let effect = PassthroughSubject<Effect, Never>()
    
    public init() {}
    
    final func onAppear() {
        guard onAppeared else { return }
        onAppeared = false
    }
    
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
