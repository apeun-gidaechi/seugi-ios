//
//  SeugiTopbar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiTopBarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let showShadow: Bool
    private let showBackButton: Bool
    private let subView: AnyView?
    private let buttons: [SeugiTopBarButton]
    private let content: AnyView
    
    public init(
        title: String,
        showShadow: Bool,
        showBackButton: Bool,
        subView: AnyView? = nil,
        buttons: [SeugiTopBarButton],
        content: AnyView
    ) {
        self.title = title
        self.showShadow = showShadow
        self.showBackButton = showBackButton
        self.subView = subView
        self.buttons = buttons
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if showBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Image(icon: .arrowLeftLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.sub(.black))
                            .frame(width: 28, height: 28)
                    }
                }
                
                Text(title)
                    .font(.subtitle(.s1))
                    .seugiColor(.sub(.black))
                    .if(showBackButton) {
                        $0.padding(.leading, 16)
                    }
                
                Spacer()
                
                subView
                
                HStack(spacing: 16) {
                    ForEach(buttons.indices, id: \.self) { idx in
                        let button = buttons[idx]
                        Button {
                            button.action()
                        } label: {
                            Image(icon: button.icon)
                                .resizable()
                                .renderingMode(.template)
                                .seugiColor(.sub(.black))
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            }
            .frame(height: 54)
            .padding(.horizontal, 16)
            .background(Color.seugi(.sub(.white)))
            .navigationBarBackButtonHidden()
            content
                .navigationBarBackButtonHidden()
        }
        .if(showShadow) {
            $0.shadow(.evBlack(.ev1))
        }
    }
    
    public func button(_ icon: SeugiIconography, action: @escaping () -> Void) -> SeugiTopBarView {
        let button = SeugiTopBarButton(icon: icon, action: action)
        return Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  subView: subView,
                  buttons: buttons + [button],
                  content: content
        )
    }
    
    public func showShadow(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: condition,
                  showBackButton: showBackButton,
                  subView: subView,
                  buttons: buttons,
                  content: content
        )
    }
    
    public func subView<S: View>(@ViewBuilder content: @escaping () -> S) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  subView: AnyView(content()),
                  buttons: buttons,
                  content: self.content
        )
    }
    
    public func hideBackButton(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: !condition,
                  subView: subView,
                  buttons: buttons,
                  content: content
        )
    }
}

public extension View {
    func seugiTopBar(_ title: String) -> SeugiTopBarView {
        SeugiTopBarView(
            title: title,
            showShadow: false,
            showBackButton: true,
            buttons: [],
            content: AnyView(self)
        )
    }
}
