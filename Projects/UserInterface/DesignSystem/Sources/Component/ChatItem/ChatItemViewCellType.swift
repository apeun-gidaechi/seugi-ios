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
    case ai
    case me
    
    var backgroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.white)
        case .ai: .sub(.white)
        case .me: .primary(.p500)
        }
    }
    
    var foregroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.black)
        case .ai: .sub(.black)
        case .me: .sub(.white)
        }
    }
    
    var corners: UIRectCorner {
        switch self {
        case .other: [.bottomLeft, .bottomRight, .topRight]
        case .ai: [.bottomLeft, .bottomRight, .topRight]
        case .me: [.bottomLeft, .bottomRight, .topLeft]
        }
    }
    
    var isLeft: Bool {
        switch self {
        case .other:
            true
        case .ai:
            true
        case .me:
            false
        }
    }
}
