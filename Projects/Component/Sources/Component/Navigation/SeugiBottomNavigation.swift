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
    @Binding private var selectedTab: SeugiBottomNavigationType
    private var tabs: [SeugiBottomNavigationCellData]
    
    public init(
        selectedTab: Binding<SeugiBottomNavigationType>,
        tabs: [SeugiBottomNavigationCellData]
    ) {
        self._selectedTab = selectedTab
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                Spacer()
                Button {
                    selectedTab = tab.type
                } label: {
                    SeugiBottomNavigationCell(cellData: tab, isSelected: selectedTab == tab.type)
                }
                .applyAnimation()
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
