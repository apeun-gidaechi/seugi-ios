//
//  CategoryPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CategoryPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                SeugiCategory(text: "전체", isSelected: true) {}
                SeugiCategory(text: "바인드", isSelected: false) {}
            }
        }
    }
}
