//
//  ShadowPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ShadowPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiShadowSystem.Ev.allCases, id: \.self) {
                    Rectangle()
                        .frame(width: 64, height: 64)
                        .seugiColor(.sub(.white))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(.ev($0))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}
