import SwiftUI

public extension Color.SeugiColorSystem {
    enum Sub: SeugiColorable, CaseIterable {
        case white
        case black
        case transparent
    }
}

public extension Color.SeugiColorSystem.Sub {
    var color: Color {
        switch self {
        case .white: .init(0xFFFFFF)
        case .black: .init(0x000000)
        case .transparent: .init(0x000000, alpha: 0)
        }
    }
}

