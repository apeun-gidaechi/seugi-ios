import SwiftUI

public extension SeugiShadowSystem {
    enum EvPrimary: CaseIterable, SeugiShadowable {
        case ev1
        case ev2
        case ev3
    }
}

extension SeugiShadowSystem.EvPrimary {
    var color: Color {
        switch self {
        case .ev1: .seugi(.primary(.p500)).opacity(0.04)
        case .ev2: .seugi(.primary(.p500)).opacity(0.06)
        case .ev3: .seugi(.primary(.p500)).opacity(0.08)
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
