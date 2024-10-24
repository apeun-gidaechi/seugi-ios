import SwiftUI
import SwiftUIUtil

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
            .disabled(isPressed)
            .animation(.easeOut(duration: 0.2), value: isPressed)
            .contentShape(Rectangle())  // Ensure the entire area is clickable
    }
    
    func scaledButtonStyle() -> some View {
        self
            .buttonStyle(SeugiAnimationButton())
    }
}
