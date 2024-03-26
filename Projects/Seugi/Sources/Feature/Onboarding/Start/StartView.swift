//
//  StartView.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct StartView: View {
    
    @State private var offsetY1: CGFloat = 16
    @State private var opacity1 = 0.0
    
    @State private var offsetY2: CGFloat = 16
    @State private var opacity2 = 0.0
    
    var body: some View {
        ZStack {
            SeugiGradientSystem.primary
                .ignoresSafeArea()
            VStack {
                Spacer()
                DesignSystemAsset.cloud1.swiftUIImage
                    .toTrailing()
                    .opacity(opacity1)
                    .offset(y: offsetY1)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("스기")
                        .font(.seugi(.display1))
                        .seugiForeground(.sub(.white))
                    Text("학생, 선생님 모두 함께하는\n스마트 스쿨 플랫폼")
                        .multilineTextAlignment(.leading)
                        .font(.seugi(.subtitle2))
                        .seugiForeground(.sub(.white))
                }
                .toLeading()
                .padding(.leading, 20)
                .opacity(opacity1)
                .offset(y: offsetY1)
                Spacer()
                DesignSystemAsset.cloud2.swiftUIImage
                    .toLeading()
                    .opacity(opacity2)
                    .offset(y: offsetY2)
                Spacer()
                SeugiButton("시작하기", type: .shadow) {
                    // TODO: handle
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 20)
                .opacity(opacity2)
                .offset(y: offsetY2)
            }
        }
        .task {
            do {
                try await Task.sleep(for: .seconds(0.25))
            } catch {}
            withAnimation(.easeInOut(duration: 1)) {
                offsetY1 = 0
                opacity1 = 1
            }
            do {
                try await Task.sleep(for: .seconds(0.75))
            } catch {}
            withAnimation(.easeInOut(duration: 1)) {
                offsetY2 = 0
                opacity2 = 1
            }
        }
    }
}
