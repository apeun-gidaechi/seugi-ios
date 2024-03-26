//
//  StartViewSheet.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct StartViewSheet: View {
    
    var body: some View {
        VStack(spacing: 8) {
            SeugiButton("이메일로 계속하기", type: .black) {
                // TODO: handle navigate to sign in view
            }
            .padding(.horizontal, 20)
            // TODO: change to OAuth button
            SeugiButton("Google로 계속하기", type: .shadow) {
                // TODO: handle navigate to sign in view
            }
            .padding(.horizontal, 20)
            SeugiButton("Apple로 계속하기", type: .shadow) {
                // TODO: handle navigate to sign in view
            }
            .padding(.horizontal, 20)
        }
        .presentationDetents([.height(300)])
    }
}
