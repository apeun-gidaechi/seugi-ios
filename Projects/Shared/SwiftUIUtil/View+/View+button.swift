import SwiftUI

public extension View {
    @inlinable
    func button(action: @escaping () -> Void) -> Button<Self> {
        Button {
            action()
        } label: {
            self
        }
    }
}
