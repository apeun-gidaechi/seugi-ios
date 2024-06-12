import SwiftUI

public enum IdleFlow<Data: Equatable>: Equatable {
    case success(_ data: Data)
    case idle
    case failure
    case fetching
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
        flow.wrappedValue == .failure
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
