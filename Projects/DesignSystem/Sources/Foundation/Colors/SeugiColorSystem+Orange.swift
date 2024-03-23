import SwiftUI

public extension Color.SeugiColorSystem {
    enum Orange: SeugiColorable, CaseIterable {
        case o100
        case o200
        case o300
        case o500
    }
}

public extension Color.SeugiColorSystem.Orange {
    var color: Color {
        switch self {
        case .o100: .init(0xFFF9F7)
        case .o200: .init(0xFDDDCB)
        case .o300: .init(0xFFBE99)
        case .o500: .init(0xF76E33)
        }
    }
}
