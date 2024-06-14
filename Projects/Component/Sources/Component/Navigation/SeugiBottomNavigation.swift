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
    @Binding var tabs: SeugiBottomNavigationData
    
    public init(
        tabs: Binding<SeugiBottomNavigationData>
    ) {
        self._tabs = tabs
    }
    
    public var body: some View {
        HStack {
            ForEach(tabs.cellData, id: \.self) { tab in
                Spacer()
                Button {
                    tabs.selectedTab = tab.type
                } label: {
                    SeugiBottomNavigationCell(cellData: tab, isSelected: tabs.selectedTab == tab.type)
                }
                .applyAnimation()
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(12, corners: .allCorners)
        .onChange(of: tabs.selectedTab) { _ in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
        }
        .shadow(.bottomNavigation(.default))
    }
}
