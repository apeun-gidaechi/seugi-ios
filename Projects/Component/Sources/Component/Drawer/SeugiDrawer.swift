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
    @State private var translation: CGSize = .zero
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
                    .offset(x: max(translation.width, 0))
                    .animation(.default, value: isOpen)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.translation = value.translation
                            }
                            .onEnded { value in
                                // 절반 이상 움직였다면 drawer 닫기
                                let translation = value.translation
                                if translation.width >= self.translation.width / 2 {
                                    isOpen = false
                                }
                                
                                // 초기화
                                self.translation = .zero
                            }
                    )
            }
    }
}
