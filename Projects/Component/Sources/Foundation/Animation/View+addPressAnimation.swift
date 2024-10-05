import SwiftUI

struct SeugiAnimationButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .addPressAnimation(configuration.isPressed)
    }
}

public extension View {
    func addPressAnimation(_ isPressed: Bool) -> some View {
        self
            .opacity(isPressed ? 0.64 : 1)
            .scaleEffect(isPressed ? 0.96 : 1)
            .animation(.easeOut, value: 1)
            .disabled(isPressed)
    }
    
    func scaledButtonStyle() -> some View {
        self
            .buttonStyle(SeugiAnimationButton())
    }
}
