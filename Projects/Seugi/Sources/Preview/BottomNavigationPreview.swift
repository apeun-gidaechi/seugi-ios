//
//  BottomNavigationPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct BottomNavigationPreview: View {
    
    @State var selectedTab = SeugiBottomNavigationType.allCases[0]
    
    var body: some View {
        ScrollView {
            VStack {
                SeugiBottomNavigation(selectedTab: $selectedTab)
            }
        }
    }
}
