//
//  SeugiCategory.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiCategory: View {
    
    private static let categoryHeight: CGFloat = 34
    
    var text: String
    var isSelected: Bool
    var action: () -> Void
    
    public init(
        text: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        
        let foregroundColor: Color.SeugiColorSystem = isSelected ? .sub(.white) : .gray(.g500)
        let backgroundColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g100))
        
        Button {
            action()
        } label: {
            Text(text)
                .font(.seugi(.subtitle2))
                .frame(height: Self.categoryHeight)
                .padding(.horizontal, 16)
                .seugiForeground(foregroundColor)
                .background(backgroundColor)
                .cornerRadius(Self.categoryHeight / 2, corners: .allCorners)
        }
        .applyAnimation()
    }
}
