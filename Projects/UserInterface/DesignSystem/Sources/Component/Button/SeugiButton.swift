//
//  AlimoButton.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

public struct SeugiButton: View {
    
    var text: String
    var type: SeugiButtonType
    var size: SeugiButtonSize
    var isLoading: Bool
    var callback: () -> Void
    
    public init(_ text: String,
                type: SeugiButtonType,
                size: SeugiButtonSize = .large,
                isLoading: Bool = false,
                callback: @escaping () -> Void) {
        self.text = text
        self.type = type
        self.size = size
        self.isLoading = isLoading
        self.callback = callback
    }
    
    public var body: some View {
        Button {
            callback()
        } label: {
            Text(!isLoading ? text : "")
            //                .buttonStyle(SeugiButtonStyle(type: type, size: size))
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
        .disabled(isLoading)
        .buttonStyle(SeugiButtonStyle(type: type, size: size, isLoading: isLoading))
    }
}

public extension SeugiButton {
    
    static func large(_ text: String,
                      type: SeugiButtonType,
                      isLoading: Bool = false, callback: @escaping () -> Void) -> SeugiButton {
        .init(text, type: type, size: .large, isLoading: isLoading, callback: callback)
    }
    
    static func small(_ text: String,
                      type: SeugiButtonType,
                      isLoading: Bool = false, callback: @escaping () -> Void) -> SeugiButton {
        .init(text, type: type, size: .small, isLoading: isLoading, callback: callback)
    }
}

struct SeugiButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    var type: SeugiButtonType
    var size: SeugiButtonSize
    var isLoading: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = isEnabled ? type.backgroundColor : type.disabledBackgroundColor
        configuration.label
            // style
            .font(size.font)
            .frame(height: size.height)
            .if(size == .small) {
                $0.padding(.horizontal, 12)
                    .if(isLoading) {
                        $0.padding(.horizontal, 24)
                    }
            }
            .if(size == .large) {
                $0.frame(maxWidth: .infinity)
            }
            .foregroundStyle(isEnabled ? type.foregroundColor : type.disabledForegroundColor)
            .if(type == .shadow) {
                $0.shadow(.ev(.ev1))
            }
            .background(backgroundColor)
            .cornerRadius(12, corners: .allCorners)
        
            // animation
            .opacity(configuration.isPressed ? 0.64 : 1)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut, value: 1)
            .disabled(configuration.isPressed)
    }
}
