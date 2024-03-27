//
//  TabbarCeil.swift
//  App
//
//  Created by dgsw8th71 on 2/24/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

struct SeugiBottomNavigationCell: View {
    
    let type: SeugiBottomNavigationType
    let isSelected: Bool
    
    init(type: SeugiBottomNavigationType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    
    var body: some View {
        
        let imageColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        let textColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g500))
        
        VStack {
            type.image
                .renderingMode(.template)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.top, 4)
                .foregroundStyle(imageColor)
            Text(type.text)
                .font(.seugi(.caption2))
                .foregroundStyle(textColor)
        }
        .padding(.horizontal, 4)
    }
}
