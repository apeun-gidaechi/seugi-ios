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
    @State var backdropOpacity: Double = 0.0
    let backgroundColor: Color.SeugiColorSystem = .sub(.white)
    let cornerRadius: CGFloat = 16
    let shadow: SeugiShadowSystem = .evBlack(.ev1)
    let modalContent: () -> MC
    let content: () -> C
    
    var body: some View {
        ZStack {
            content()
            
            Color.black.opacity(0.2).ignoresSafeArea()
                .opacity(backdropOpacity)
            
            if isPresent || backdropOpacity > 0 {
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
                .opacity(backdropOpacity)
                .onChange(of: isPresent) { isPresent in
                    withAnimation(.easeOut(duration: 0.2)) {
                        backdropOpacity = isPresent ? 1 : 0
                        scaleEffect = isPresent ? 1 : 1.2
                    }
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 0.2)) {
                        backdropOpacity = 1
                        scaleEffect = 1.0
                    }
                }
            }
        }
    }
}
