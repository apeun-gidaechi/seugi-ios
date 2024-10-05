import SwiftUI

import SwiftUIUtil

public struct SeugiButton: View {
    private let text: String
    private let type: SeugiButtonType
    private let size: SeugiButtonSize
    private let isLoading: Bool
    private let expanded: Bool
    private let action: () -> Void
    
    private init(
        _ text: String,
        type: SeugiButtonType,
        size: SeugiButtonSize,
        isLoading: Bool = false,
        expanded: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.type = type
        self.size = size
        self.isLoading = isLoading
        self.expanded = expanded
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(!isLoading ? text : "")
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
        .disabled(isLoading)
        .buttonStyle(SeugiButtonStyle(type: type, size: size, isLoading: isLoading, expanded: expanded))
    }
}

public extension SeugiButton {
    static func large(
        _ text: String,
        type: SeugiButtonType,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> SeugiButton {
        .init(
            text,
            type: type,
            size: .large,
            isLoading: isLoading,
            action: action
        )
    }
    
    static func small(
        _ text: String,
        type: SeugiButtonType,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> SeugiButton {
        .init(
            text,
            type: type,
            size: .small,
            isLoading: isLoading,
            action: action
        )
    }
    
    func expanded(_ condition: Bool = true) -> Self {
        .init(
            text,
            type: type,
            size: size,
            isLoading: isLoading,
            expanded: condition,
            action: action
        )
    }
}

struct SeugiButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    private let type: SeugiButtonType
    private let size: SeugiButtonSize
    private let isLoading: Bool
    private let expanded: Bool
    
    init(
        type: SeugiButtonType, 
        size: SeugiButtonSize,
        isLoading: Bool,
        expanded: Bool
    ) {
        self.type = type
        self.size = size
        self.isLoading = isLoading
        self.expanded = expanded
    }
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .font(size.font)
            .frame(height: size.height)
            .if((size == .small) && !expanded) {
                $0.padding(.horizontal, 12 + (isLoading ? 24 : 0))
            }
            .frame(maxWidth: size == .large || expanded ? .infinity : nil)
            .shadow(type == .shadow ? .evBlack(.ev1) : nil)
            .foregroundStyle(isEnabled ? type.foregroundColor : type.disabledForegroundColor)
            .background(isEnabled ? type.backgroundColor : type.disabledBackgroundColor)
            .cornerRadius(12, corners: .allCorners)
            .addPressAnimation(configuration.isPressed)
    }
}
