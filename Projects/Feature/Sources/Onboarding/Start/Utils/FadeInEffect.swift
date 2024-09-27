//
//  FadeInEffect.swift
//  Feature
//
//  Created by hhhello0507 on 9/4/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

struct FadeInEffectViewModifier: ViewModifier {
    
    @State private var offsetY: CGFloat
    @State private var opacity: Double = 0.0
    
    private let time: Double
    
    init(
        time: Double,
        initialOffsetY: CGFloat = 16
    ) {
        self.time = time
        self.offsetY = initialOffsetY
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offsetY)
            .task {
                try? await Task.sleep(for: .seconds(time))
                withAnimation(.easeInOut(duration: 1)) {
                    offsetY = 0
                    opacity = 1
                }
            }
    }
}

extension View {
    func fadeInEffect(time: Double) -> some View {
        self.modifier(FadeInEffectViewModifier(time: time))
    }
}
