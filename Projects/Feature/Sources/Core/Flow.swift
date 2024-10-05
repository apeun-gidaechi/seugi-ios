import Combine
import SwiftUI

import Domain

public enum Flow<Data: Equatable>: Equatable {
    case idle
    case fetching
    case success(Data)
    case failure(Error)
    
    public static func == (lhs: Flow<Data>, rhs: Flow<Data>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, idle), (.fetching, .fetching), (.failure, .failure): true
        case (.success(let lData), .success(let rData)) where lData == rData: true
        default: false
        }
    }
}

public extension Flow {
    enum FlowSet {
        case idle
        case fetching
        case success
        case failure
    }
    
    func `is`(_ flow: FlowSet) -> Bool {
        switch flow {
        case .idle:
            if case .idle = self {
                true
            } else {
                false
            }
        case .fetching:
            if case .fetching = self {
                true
            } else {
                false
            }
        case .success:
            if case .success = self {
                true
            } else {
                false
            }
        case .failure:
            if case .failure = self {
                true
            } else {
                false
            }
        }
    }
    
    var data: Data? {
        if case .success(let data) = self {
            return data
        } else {
            return nil
        }
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            error
        } else {
            nil
        }
    }
    
    @inlinable
    func map<NewData: Equatable>(_ data: NewData) -> Flow<NewData> {
        switch self {
        case .idle: .idle
        case .fetching: .fetching
        case .success: .success(data)
        case .failure(let err): .failure(err)
        }
    }
    
    @inlinable
    func map<NewData: Equatable>(_ transform: (Data) throws -> NewData) rethrows -> Flow<NewData> {
        switch self {
        case .idle: .idle
        case .fetching: .fetching
        case .success(let data): .success(try transform(data))
        case .failure(let err): .failure(err)
        }
    }
    
    @inlinable
    func mapError(_ error: Error) -> Flow<Data> {
        switch self {
        case .idle: .idle
        case .fetching: .fetching
        case .success(let data): .success(data)
        case .failure: .failure(error)
        }
    }
    
    @inlinable
    func mapError(_ transform: (Error) throws -> Error) rethrows -> Flow<Data> {
        switch self {
        case .idle: .idle
        case .fetching: .fetching
        case .success(let data): .success(data)
        case .failure(let err): .failure(try transform(err))
        }
    }
    
    @inlinable
    @ViewBuilder
    func makeView(
        @ViewBuilder fetching: () -> some View,
        @ViewBuilder success: (Data) -> some View,
        @ViewBuilder failure: (Error) -> some View
    ) -> some View {
        switch self {
        case .success(let data):
            success(data)
        case .failure(let error):
            failure(error)
        case .fetching:
            fetching()
        default:
            EmptyView()
        }
    }
}

// TODO: mv file
public extension Publisher {
    
    @inlinable
    func flow<Object: AnyObject>(
        _ keyPath: ReferenceWritableKeyPath<Object, Flow<Output>>,
        on object: Object
    ) -> AnyPublisher<Output, Failure> {
        self.handleEvents(
            receiveSubscription: { _ in
                object[keyPath: keyPath] = .fetching
            },
            receiveOutput: {
                object[keyPath: keyPath] = .success($0)
            },
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    object[keyPath: keyPath] = .failure(error)
                }
            },
            receiveCancel: {
                object[keyPath: keyPath] = .idle
            }
        )
        .eraseToAnyPublisher()
    }
}
