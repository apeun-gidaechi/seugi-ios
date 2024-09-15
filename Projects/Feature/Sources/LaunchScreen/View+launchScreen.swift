//
//  View+launchScreen.swift
//  Feature
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

struct LaunchScreenViewModifier<C: View>: ViewModifier {
    
    @State private var opacity = 1.0
    
    private let content: () -> C
    
    init(content: @escaping () -> C) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        content.overlay {
            if opacity > 0 {
                self.content()
                    .opacity(opacity)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation {
                opacity = 0
            }
        }
    }
}

extension View {
    func launchScreen<C: View>(_ content: @escaping () -> C) -> some View {
        self.modifier(LaunchScreenViewModifier(content: content))
    }
}
