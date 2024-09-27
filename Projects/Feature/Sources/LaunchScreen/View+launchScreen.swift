//
//  View+launchScreen.swift
//  Feature
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

struct LaunchScreenViewModifier<C: View>: ViewModifier {
    
    @State private var opacity: Double = 1.0
    
    private let duration: Double
    private let content: () -> C
    
    init(duration: Double, content: @escaping () -> C) {
        self.duration = duration
        self.content = content
    }
    
    func body(content: Content) -> some View {
        if opacity == 0 {
            content
        } else {
            self.content()
                .opacity(opacity)
                .task {
                    try? await Task.sleep(for: .seconds(duration))
                    withAnimation {
                        opacity = 0
                    }
                }
        }
    }
}

let defaultDuration = 1.5

extension View {
    func launchScreen<C: View>(duration: Double = defaultDuration, _ content: @escaping () -> C) -> some View {
        self.modifier(LaunchScreenViewModifier(duration: duration, content: content))
    }
}
