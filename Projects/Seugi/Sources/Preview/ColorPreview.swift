//
//  ColorPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ColorPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ColorPreviewCell(colors: Color.SeugiColorSystem.Primary.allCases)
                ColorPreviewCell(colors: Color.SeugiColorSystem.Gray.allCases)
                ColorPreviewCell(colors: Color.SeugiColorSystem.Sub.allCases)
                ColorPreviewCell(colors: Color.SeugiColorSystem.Red.allCases)
                ColorPreviewCell(colors: Color.SeugiColorSystem.Orange.allCases)
                SeugiGradientSystem.primary
                    .frame(height: 128)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct ColorPreviewCell: View {
    
    var colors: [SeugiColorable]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(colors, id: \.color) { color in
                color.color
                    .frame(height: 128)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
