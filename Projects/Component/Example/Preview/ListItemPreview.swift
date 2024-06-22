//
//  SeugiListItemPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

struct ListItemPreview: View {
    @State var isOn = false
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SeugiListItem.normal(title: "서비스 정책")
                SeugiListItem.toggle(title: "알림 설정", isOn: $isOn)
                SeugiListItem.description(title: "버전", description: "v1.0.0")
            }
        }
    }
}
