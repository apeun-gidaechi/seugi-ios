//
//  ChatItemViewCellType.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public enum ChatItemViewCellType: Equatable {
    case other
    case ai
    case me
    
    public var backgroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.white)
        case .ai: .sub(.white)
        case .me: .primary(.p500)
        }
    }
    
    public var foregroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.black)
        case .ai: .sub(.black)
        case .me: .sub(.white)
        }
    }
    
    public var corners: UIRectCorner {
        switch self {
        case .other, .ai: [.bottomLeft, .bottomRight, .topRight]
        case .me: [.bottomLeft, .bottomRight, .topLeft]
        }
    }
    
    public var alignent: ChatItemHorizontalAlignment {
        switch self {
        case .other, .ai: .leading
        case .me: .trailing
        }
    }
    
    public var isAi: Bool {
        if case .ai = self {
            true
        } else {
            false
        }
    }
}