//
//  Notice.swift
//  App
//
//  Created by dgsw8th61 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI
import SwiftUIUtil

public struct SeugiBottomNavigation: View {
    @Binding var selectedTab: SeugiBottomNavigationType
    
    public init(selectedTab: Binding<SeugiBottomNavigationType>) {
        self._selectedTab = selectedTab
    }
    
    public var body: some View {
        HStack {
            let mainViews = SeugiBottomNavigationType.allCases
            ForEach(mainViews, id: \.self) { tab in
                Spacer()
                SeugiBottomNavigationCell(type: tab, isSelected: selectedTab == tab)
                    .onTapGesture {
                        selectedTab = tab
                    }
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(12, corners: .allCorners)
        .onChange(of: selectedTab) { _ in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
        }
        .shadow(.bottomNavigation(.default))
    }
}
