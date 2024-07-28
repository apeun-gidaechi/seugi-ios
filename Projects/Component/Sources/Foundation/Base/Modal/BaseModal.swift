//
//  BaseModal.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIUtil

struct BaseModal<MC: View, C: View>: View {
    
    @Namespace var animation
    @State private var scaleEffect: CGFloat = 1.2
    @Binding var isPresent: Bool
    @State var opacity: Double = 0.0
    let backgroundColor: Color.SeugiColorSystem = .sub(.white)
    let cornerRadius: CGFloat = 16
    let shadow: SeugiShadowSystem = .evBlack(.ev1)
    @ViewBuilder let modalContent: () -> MC
    @ViewBuilder let content: () -> C
    
    var body: some View {
        ZStack {
            content()
            Color.black
                .opacity(0.2 * opacity)
                .ignoresSafeArea()
            // MARK: - Alert
            VStack {
                Spacer()
                modalContent()
                    .seugiBackground(backgroundColor)
                    .cornerRadius(cornerRadius)
                    .shadow(shadow)
                    .if(isPresent) {
                        $0.scaleEffect(scaleEffect)
                    }
                    .opacity(opacity)
                Spacer()
            }
        }
        .onChange(of: isPresent) { isPresent in
            withAnimation(.easeOut(duration: 0.2)) {
                opacity = isPresent ? 1 : 0
                scaleEffect = isPresent ? 1 : 1.1
            }
        }
    }
}