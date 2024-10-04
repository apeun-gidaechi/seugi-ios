import Combine
import SwiftUI

public extension Publisher {
    func ignoreError() -> AnyPublisher<Output, Never> {
        return self.catch { _ in
            Empty<Output, Never>()
        }
        .eraseToAnyPublisher()
    }
    
    func silentSink() -> AnyCancellable {
        return self.sink { _ in } receiveValue: { _ in }
    }
}

// Allow to assign Optional value
public extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to path: ReferenceWritableKeyPath<Root, Output?>, on instance: Root) -> Cancellable {
        sink { instance[keyPath: path] = $0 }
    }
}
