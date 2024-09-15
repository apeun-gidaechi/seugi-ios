//
//  SeugiDrawer.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/4/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import SwiftUIUtil
import UIKit

public extension View {
    func seugiDrawer<Body>(
        isOpen: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Body = { EmptyView() }
    ) -> some View where Body: View {
        self.modifier(SeugiDrawerModifier(isOpen: isOpen, content: content))
    }
}

public struct SeugiDrawerModifier<C>: ViewModifier where C: View {
    
    @Binding private var isOpen: Bool
    private var content: () -> C
    
    private let width: CGFloat = min(320, (UIApplication.shared.screen?.bounds.width ?? .infinity) - 80)
    
    public init(
        isOpen: Binding<Bool>,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._isOpen = isOpen
        self.content = content
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                Color.black.opacity(isOpen ? 0.3 : 0)
                    .animation(.default, value: isOpen)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isOpen = false
                    }
                self.content()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .frame(width: width)
                    .background(Color.seugi(.sub(.white)))
                    .offset(
                        x: isOpen
                        ? 0
                        : width
                    )
                    .animation(.default, value: isOpen)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
    }
}
