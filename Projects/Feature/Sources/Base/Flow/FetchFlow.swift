import SwiftUI
import Domain

public enum FetchFlow<Data: Equatable>: Equatable {
    case success(_ data: Data)
    case failure(_ error: APIError = .unknown)
    case fetching
    
    public var data: Data? {
        if case .success(let data) = self {
            data
        } else {
            nil
        }
    }
    
    public var error: APIError? {
        if case .failure(let error) = self {
            error
        } else {
            nil
        }
    }
    
    public var httpError: BaseVoid? {
        if case .http(let baseVoid) = error {
            baseVoid
        } else {
            nil
        }
    }
    
    @ViewBuilder
    public func makeView(
        @ViewBuilder fetching: () -> some View,
        @ViewBuilder success: (Data) -> some View,
        @ViewBuilder failure: (APIError) -> some View
    ) -> some View {
        switch self {
        case .success(let data):
            success(data)
        case .failure(let error):
            failure(error)
        case .fetching:
            fetching()
        }
    }
    
    @inlinable
    func map<N: Equatable>(_ data: N) -> FetchFlow<N> {
        switch self {
        case .success: .success(data)
        case .failure(let err): .failure(err)
        case .fetching: .fetching
        }
    }
    
    @inlinable func map<N: Equatable>(_ transform: (Data) throws -> N) rethrows -> FetchFlow<N> {
        switch self {
        case .success(let data): .success(try transform(data))
        case .failure(let err): .failure(err)
        case .fetching: .fetching
        }
    }
    
    @inlinable
    func mapError(_ error: APIError) -> FetchFlow<Data> {
        switch self {
        case .success(let data): .success(data)
        case .failure: .failure(error)
        case .fetching: .fetching
        }
    }
    
    @inlinable
    func mapError(_ transform: (APIError) throws -> APIError) rethrows -> FetchFlow<Data> {
        switch self {
        case .success(let data): .success(data)
        case .failure(let err): .failure(try transform(err))
        case .fetching: .fetching
        }
    }
}

public extension View {
    func onChangeFetchFlow<T: Equatable>(
        of value: FetchFlow<T>,
        success: @escaping () -> Void
    ) -> some View {
        self.onChange(of: value) {
            if case .success = $0 {
                success()
            }
        }
    }
    
    func onChangeFetchFlow<T: Equatable>(
        of value: FetchFlow<T>,
        success: @escaping () -> Void,
        failure: @escaping () -> Void
    ) -> some View {
        self.onChange(of: value) {
            if case .success = $0 {
                success()
            } else if case .failure = $0 {
                failure()
            }
        }
    }
}
