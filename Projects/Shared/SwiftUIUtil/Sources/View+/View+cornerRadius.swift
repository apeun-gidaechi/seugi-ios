//
//  View+cornerRadius.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
    
    func stroke(_ radius: CGFloat, color: Color, lineWidth: CGFloat = 1) -> some View {
        let roundedCorner = RoundedCornerShape(radius: radius, corners: .allCorners)
        return self
            .clipShape(roundedCorner)
            .overlay {
                roundedCorner
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}
