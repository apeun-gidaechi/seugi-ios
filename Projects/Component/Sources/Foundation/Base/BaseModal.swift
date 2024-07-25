//
//  BaseModal.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import SwiftUI

struct BaseModal<MC: View, C: View>: View {
    
    @State private var scaleEffect: CGFloat = 1.2
    @Binding var isPresent: Bool
    @Binding var opacity: Double
    let backgroundColor: Color.SeugiColorSystem = .sub(.white)
    let cornerRadius: CGFloat = 16
    let shadow: SeugiShadowSystem = .evBlack(.ev1)
    let modalContent: () -> MC
    let content: () -> C
    
    var body: some View {
        ZStack {
            content()
            if isPresent || opacity > 0 {
                // MARK: - Alert
                VStack {
                    Spacer()
                    modalContent()
                        .seugiBackground(backgroundColor)
                        .cornerRadius(cornerRadius)
                        .shadow(shadow)
                    Spacer()
                }
                .scaleEffect(scaleEffect)
                .opacity(opacity)
                .onChange(of: isPresent) { isPresent in
                    withAnimation(.easeOut(duration: 0.2)) {
                        opacity = isPresent ? 1 : 0
                        scaleEffect = isPresent ? 1 : 1.2
                    }
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 0.2)) {
                        opacity = 1
                        scaleEffect = 1.0
                    }
                }
            }
        }
    }
}
