//
//  HomeArrowIcon.swift
//  Feature
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct HomeArrowIcon: View {
    var body: some View {
        Image(icon: .expandRightLine)
            .resizable()
            .renderingMode(.template)
            .seugiColor(.gray(.g500))
            .frame(width: 24, height: 24)
    }
}
