import SwiftUI

public extension View {
    @inlinable
    @ViewBuilder
    func onChange<V>(of value: V, initial: Bool, action: @escaping (_ newValue: V) -> Void) -> some View where V: Equatable {
        if initial {
            self.onChange(of: value, perform: action).onAppear { action(value) }
        } else {
            self.onChange(of: value, perform: action)
        }
    }
}
