//
//  SettingWorkspaceHeadline.swift
//  SettingWorkspaceFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct SettingWorkspaceHeadline: View {
    
    private let icon: SeugiIconography
    
    init(icon: SeugiIconography) {
        self.icon = icon
    }
    
    var body: some View {
        Image(icon: icon)
            .resizable()
            .renderingMode(.template)
            .frame(width: 28, height: 28)
            .toLeading()
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
    }
}
