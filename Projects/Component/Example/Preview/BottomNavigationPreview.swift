//
//  BottomNavigationPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

struct BottomNavigationPreview: View {
    @State private var tabs = SeugiBottomNavigationData(
        cellData: [
            .init(type: .home, hasBadge: true),
            .init(type: .chat, hasBadge: true),
            .init(type: .room, hasBadge: false),
            .init(type: .notification, hasBadge: false),
            .init(type: .profile, hasBadge: false)
        ],
        selectedTab: .home
    )
    var body: some View {
        ScrollView {
            VStack {
                SeugiBottomNavigation(tabs: $tabs)
            }
        }
    }
}
