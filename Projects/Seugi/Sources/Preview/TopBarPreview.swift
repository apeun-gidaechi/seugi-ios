//
//  TopBarPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct TopBarPreview: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            Text("Hello, Seugi!")
                .font(.seugi(.display1))
        }
        .seugiToolbar("로그인") {
            dismiss()
        }
    }
}
