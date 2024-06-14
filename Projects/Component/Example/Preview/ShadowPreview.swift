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
                Text("EvBlack")
                    .font(.title(.t2))
                HStack {
                    ForEach(SeugiShadowSystem.EvBlack.allCases, id: \.self) {
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .seugiColor(.sub(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(.evBlack($0))
                    }
                }
                Text("EvPrimary")
                    .font(.title(.t2))
                HStack {
                    ForEach(SeugiShadowSystem.EvPrimary.allCases, id: \.self) {
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .seugiColor(.sub(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(.evPrimary($0))
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}
