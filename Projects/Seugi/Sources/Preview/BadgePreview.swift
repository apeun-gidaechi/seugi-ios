//
//  BadgePreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct BadgePreview: View {
    var body: some View {
        ScrollView {
            VStack {
                SeugiBadge(type: .normal)
                SeugiBadge(type: .number(1))
                SeugiBadge(type: .number(10))
                SeugiBadge(type: .number(72))
                SeugiBadge(type: .number(128))
                SeugiBadge(type: .number(999))
            }
        }
    }
}
