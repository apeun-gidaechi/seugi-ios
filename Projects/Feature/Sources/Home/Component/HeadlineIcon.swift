//
//  HeadlineIcon.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct HomeHeadlineIcon: View {
    private let icon: SeugiIconography
    
    init(icon: SeugiIconography) {
        self.icon = icon
    }
    
    var body: some View {
        Image(icon: icon)
            .resizable()
            .renderingMode(.template)
            .seugiColor(.gray(.g600))
            .frame(width: 24, height: 24)
            .padding(4)
            .seugiBackground(.gray(.g100))
            .cornerRadius(8, corners: .allCorners)
    }
}
