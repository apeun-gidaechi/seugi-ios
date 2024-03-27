//
//  AvatarPreivew.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct AvatarPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiAvatarType.allCases, id: \.self) {
                    SeugiAvatar(type: $0)
                }
            }
        }
    }
}
