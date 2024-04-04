//
//  SeugiDrawer.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/4/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension View {
    func seugiDrawer<Body>(
        isDrawerOpen: Binding<Bool>,
        @ViewBuilder body: @escaping () -> Body = { EmptyView() }
    ) -> some View where Body: View {
        self.modifier(SeugiDrawerModifier(isDrawerOpen: isDrawerOpen, body: body))
    }
}

public struct SeugiDrawerModifier<Body>: ViewModifier where Body: View {
    
    @Binding private var isDrawerOpen: Bool
    private var body: () -> Body
    
    private let width = UIScreen.main.bounds.width - 80
    
    public init(
        isDrawerOpen: Binding<Bool>,
        @ViewBuilder body: @escaping () -> Body
    ) {
        self._isDrawerOpen = isDrawerOpen
        self.body = body
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            body()
                .frame(width: width)
                .offset(x: isDrawerOpen ? 0 : -width)
                .animation(.default, value: 1)
                .toLeading()
        }
    }
}
