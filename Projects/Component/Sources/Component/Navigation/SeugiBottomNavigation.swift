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
            Spacer()
            ForEach(tabs, id: \.self) { tab in
                Button {
                    selectedTab = tab.type
                } label: {
                    SeugiBottomNavigationCell(cellData: tab, isSelected: selectedTab == tab.type)
                        .frame(height: 64)
                        .toHorizontal()
                }
                .applyAnimation()
            }
            Spacer()
        }
        .frame(height: 64)
        .background(.white)
        .cornerRadius(18, corners: .allCorners)
        .shadow(color: Color.black.opacity(0.06), radius: 18, y: 2)
        .onChange(of: selectedTab) { _ in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
        }
    }
}
