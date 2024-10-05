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
