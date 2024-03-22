import SwiftUI

public extension Color.SeugiColorSystem {
    enum Sub: SeugiColorable {
        case white
        case black
    }
}

public extension Color.SeugiColorSystem.Sub {
    var color: Color {
        switch self {
        case .white: .init(0xFFFFFF)
        case .black: .init(0x000000)
        }
    }
}

