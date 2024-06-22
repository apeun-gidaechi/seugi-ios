import SwiftUI

public extension View {
    func button(action: @escaping () -> Void) -> Button<Self> {
        Button {
            action()
        } label: {
            self
        }
    }
}
