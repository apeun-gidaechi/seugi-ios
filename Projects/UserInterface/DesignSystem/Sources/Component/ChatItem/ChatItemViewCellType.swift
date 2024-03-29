//
//  ChatItemViewCellType.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public enum ChatItemViewCellType {
    case other
    case me
    
    var backgroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.white)
        case .me: .primary(.p500)
        }
    }
    
    var foregroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.black)
        case .me: .sub(.white)
        }
    }
    
    var corners: UIRectCorner {
        switch self {
        case .other: [.bottomLeft, .bottomRight, .topRight]
        case .me: [.bottomLeft, .bottomRight, .topLeft]
        }
    }
}
