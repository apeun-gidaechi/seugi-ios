import SwiftUI
import Domain

public enum IdleFlow<Data: Equatable>: Equatable {
    case success(_ data: Data = true)
    case idle
    case failure(_ error: APIError)
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
}

public extension View {
    
    func onChangeSuccess<T: Equatable>(
        of value: IdleFlow<T>,
        success: @escaping (T) -> Void
    ) -> some View {
        self
            .onChange(of: value) {
                if case .success(let data) = $0 {
                    success(data)
                }
            }
    }
    
    func onChangeFailure<T: Equatable>(
        of value: IdleFlow<T>,
        failure: @escaping (APIError) -> Void
    ) -> some View {
        self
            .onChange(of: value) {
                if case .failure(let error) = $0 {
                    failure(error)
                }
            }
    }
    
    func onChange<T: Equatable>(
        of value: IdleFlow<T>,
        success: @escaping (T) -> Void,
        failure: @escaping (APIError) -> Void
    ) -> some View {
        self
            .onChange(of: value) {
                if case .success(let data) = $0 {
                    success(data)
                } else if case .failure(let error) = $0 {
                    failure(error)
                }
            }
    }
}
