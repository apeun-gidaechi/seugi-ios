//
//  SeugiTopbar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiTopBarView: View {
    
    @State private var isTextField = false
    @Namespace private var animation
    
    private let title: String
    private let showShadow: Bool
    private let showBackButton: Bool
    private let showTitle: Bool
    private let subView: AnyView?
    private let buttons: [SeugiTopBarButton]
    private let onBackAction: (() -> Void)?
    private let content: AnyView
    
    public init(
        title: String,
        showShadow: Bool,
        showBackButton: Bool,
        showTitle: Bool,
        subView: AnyView? = nil,
        buttons: [SeugiTopBarButton],
        onBackAction: (() -> Void)?,
        content: AnyView
    ) {
        self.title = title
        self.showShadow = showShadow
        self.showBackButton = showBackButton
        self.showTitle = showTitle
        self.subView = subView
        self.buttons = buttons
        self.onBackAction = onBackAction
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if showBackButton || isTextField {
                    Button {
                        if let onBackAction {
                            onBackAction()
                        }
                    } label: {
                        Image(icon: .arrowLeftLine)
                            .resizable()
                            .renderingMode(.template)
                            .seugiColor(.sub(.black))
                            .frame(width: 28, height: 28)
                    }
                    .matchedGeometryEffect(id: "backbutton", in: animation)
                }
                
                if showTitle {
                    Text(title)
                        .font(.subtitle(.s1))
                        .seugiColor(.sub(.black))
                        .if(showBackButton) {
                            $0.padding(.leading, 16)
                        }
                        .matchedGeometryEffect(id: "title", in: animation)
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
            .if(showShadow) {
                $0.shadow(.evBlack(.ev1))
            }
            content
                .navigationBarBackButtonHidden()
        }
    }
    
    public func button(_ icon: SeugiIconography, action: @escaping () -> Void) -> SeugiTopBarView {
        let button = SeugiTopBarButton(icon: icon, action: action)
        return Self.init(title: title,
                         showShadow: showShadow,
                         showBackButton: showBackButton,
                         showTitle: showTitle,
                         subView: subView,
                         buttons: buttons + [button],
                         onBackAction: onBackAction,
                         content: content
        )
    }
    
    public func showShadow(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: condition,
                  showBackButton: showBackButton,
                  showTitle: showTitle,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
    
    public func subView<S: View>(@ViewBuilder content: @escaping () -> S) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  showTitle: showTitle,
                  subView: AnyView(content()),
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: self.content
        )
    }
    
    public func hideBackButton(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: !condition,
                  showTitle: showTitle,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
    
    public func hideTitle(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  showTitle: !condition,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
}

public extension View {
    func seugiTopBar(_ title: String, onBackAction: (() -> Void)? = nil) -> SeugiTopBarView {
        SeugiTopBarView(
            title: title,
            showShadow: false,
            showBackButton: true,
            showTitle: true,
            buttons: [],
            onBackAction: onBackAction,
            content: AnyView(self)
        )
    }
}
