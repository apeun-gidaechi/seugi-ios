//
//  SeugiShadowSystem+BottomNavigation.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension SeugiShadowSystem {
    enum BottomNavigation: CaseIterable, SeugiShadowable {
        case `default`
    }
}

extension SeugiShadowSystem.BottomNavigation {
    
    
    var color: Color {
        switch self {
        case .default: .init(0x000000, alpha: 0.04)
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .default: 12
        }
    }
    
    var x: CGFloat {
        0
    }
    
    var y: CGFloat {
        0
    }
        
}
