import SwiftUI
import Domain

public enum IdleFlow<Data: Equatable>: Equatable {
    case success(_ data: Data = true)
    case idle
    case failure(_ error: APIError)
    case fetching
    
    public var isSuccess: Bool {
        if case .success = self {
            true
        } else {
            false
        }
    }
    
    public var isFailure: Bool {
        if case .failure = self {
            true
        } else {
            false
        }
    }
    
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

public func successDialog(for flow: Binding<IdleFlow<Bool>>) -> Binding<Bool> {
    Binding {
        flow.wrappedValue == .success(true)
    } set: { _ in
        flow.wrappedValue = .idle
    }
}

public func failureDialog(for flow: Binding<IdleFlow<Bool>>) -> Binding<Bool> {
    Binding {
        flow.wrappedValue.isFailure
    } set: { _ in
        flow.wrappedValue = .idle
    }
}

public extension View {
    
    func onChangeIdleFlow<T: Equatable>(
        of value: IdleFlow<T>,
        success: @escaping () -> Void
    ) -> some View {
        self
            .onChange(of: value) {
                if case .success = $0 {
                    success()
                }
            }
    }
    
    func onChangeIdleFlow<T: Equatable>(
        of value: IdleFlow<T>,
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
