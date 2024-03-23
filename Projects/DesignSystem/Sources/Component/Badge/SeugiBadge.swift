//
//  AlimoBadge.swift
//  App
//
//  Created by dgsw8th71 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

public struct SeugiBadge: View {
    
    var type: SeugiBadgeType
    
    public init(type: SeugiBadgeType) {
        self.type = type
    }
    
    public var body: some View {
        if case let .number(n) = type {
            let text = n >= 300 ? "300+" : String(n)
            Text(text)
                .font(.seugi(.caption2))
                .frame(height: type.size)
                .padding(.horizontal, 8)
                .background(Color.seugi(.orange(.o500)))
                .cornerRadius(type.size / 2, corners: .allCorners)
                .seugiForeground(.sub(.white))
        } else {
            Circle()
                .seugiForeground(.orange(.o500))
                .frame(height: type.size)
        }
    }
}
