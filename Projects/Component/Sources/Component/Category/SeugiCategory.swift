//
//  SeugiCategory.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiCategory: View {
    
    public typealias AsyncAction = () -> Void
    
    private static let categoryHeight: CGFloat = 34
    
    var text: String
    var isSelected: Bool
    var action: AsyncAction
    
    public init(
        text: String,
        isSelected: Bool,
        action: @escaping AsyncAction
    ) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        
        let foregroundColor: Color.SeugiColorSystem = isSelected ? .sub(.white) : .gray(.g500)
        let backgroundColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g100))
        
        Text(text)
            .font(.subtitle(.s2))
            .frame(height: Self.categoryHeight)
            .padding(.horizontal, 16)
            .seugiColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(Self.categoryHeight / 2, corners: .allCorners)
            .button {
                action()
            }
            .applyAnimation()
    }
}
