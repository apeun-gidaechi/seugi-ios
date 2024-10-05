import SwiftUI

public extension SeugiShadowSystem {
    enum EvBlack: CaseIterable, SeugiShadowable {
        case ev1
        case ev2
        case ev3
    }
}

extension SeugiShadowSystem.EvBlack {
    var color: Color {
        switch self {
        case .ev1: .init(0x000000, alpha: 0.04)
        case .ev2: .init(0x000000, alpha: 0.06)
        case .ev3: .init(0x000000, alpha: 0.08)
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .ev1: 9
        case .ev2: 12
        case .ev3: 18
        }
    }
    
    var x: CGFloat {
        0
    }
    
    var y: CGFloat {
        switch self {
        case .ev1: 3
        case .ev2: 4
        case .ev3: 6
        }
    } 
}
