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
        @ViewBuilder fetching: @escaping () -> some View,
        @ViewBuilder success: @escaping (Data) -> some View,
        @ViewBuilder failure: @escaping (APIError) -> some View
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
}

public extension View {
    
    func onChangeFetchFlow<T: Equatable>(
        of value: FetchFlow<T>,
        success: @escaping () -> Void
    ) -> some View {
        self
            .onChange(of: value) {
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
        self
            .onChange(of: value) {
                if case .success = $0 {
                    success()
                } else if case .failure = $0 {
                    failure()
                }
            }
    }
}
