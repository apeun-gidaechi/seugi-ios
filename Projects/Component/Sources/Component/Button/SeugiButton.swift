//
//  AlimoButton.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

public struct SeugiButton: View {
    
    private let text: String
    private let type: SeugiButtonType
    private let size: SeugiButtonSize
    private let isLoading: Bool
    private let expanded: Bool
    private let callback: () -> Void
    
    private init(
        _ text: String,
        type: SeugiButtonType,
        size: SeugiButtonSize,
        isLoading: Bool = false,
        expanded: Bool = false,
        callback: @escaping () -> Void
    ) {
        self.text = text
        self.type = type
        self.size = size
        self.isLoading = isLoading
        self.expanded = expanded
        self.callback = callback
    }
    
    public var body: some View {
        Button {
            callback()
        } label: {
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

// MARK: - Method
public extension SeugiButton {
    
    static func large(
        _ text: String,
        type: SeugiButtonType,
        isLoading: Bool = false, callback: @escaping () -> Void
    ) -> SeugiButton {
        .init(text, type: type, size: .large, isLoading: isLoading, callback: callback)
    }
    
    static func small(
        _ text: String,
        type: SeugiButtonType,
        isLoading: Bool = false, callback: @escaping () -> Void
    ) -> SeugiButton {
        .init(text, type: type, size: .small, isLoading: isLoading, callback: callback)
    }
    
    func expanded(_ condition: Bool = true) -> Self {
        .init(
            text,
            type: type,
            size: size,
            isLoading: isLoading,
            expanded: condition,
            callback: callback
        )
    }
}

// MARK: - Style
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
        let backgroundColor = isEnabled ? type.backgroundColor : type.disabledBackgroundColor
        configuration.label
        // style
            .font(size.font)
            .frame(height: size.height)
            .if((size == .small) && !expanded) {
                $0.padding(.horizontal, 12)
                    .if(isLoading) {
                        $0.padding(.horizontal, 24)
                    }
            }
            .if(size == .large || expanded) {
                $0.frame(maxWidth: .infinity)
            }
            .foregroundStyle(isEnabled ? type.foregroundColor : type.disabledForegroundColor)
            .if(type == .shadow) {
                $0.shadow(.evBlack(.ev1))
            }
            .background(backgroundColor)
            .cornerRadius(12, corners: .allCorners)
            .addPressAnimation(configuration.isPressed)
    }
}
