//
//  ChatItemViewCellType.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public enum ChatItemViewCellType: Equatable {
    case other(isFirst: Bool, isLast: Bool)
    case ai(isFirst: Bool, isLast: Bool)
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
        case .other: [.bottomLeft, .bottomRight, .topRight]
        case .ai: [.bottomLeft, .bottomRight, .topRight]
        case .me: [.bottomLeft, .bottomRight, .topLeft]
        }
    }
    
    public var isLeft: Bool {
        switch self {
        case .other:
            true
        case .ai:
            true
        case .me:
            false
        }
    }
    
    public var isAi: Bool {
        if case .ai = self {
            true
        } else {
            false
        }
    }
    
    public var isOther: Bool {
        if case .other = self {
            true
        } else {
            false
        }
    }
    
    public var isMe: Bool {
        if case .me = self {
            true
        } else {
            false
        }
    }
}
