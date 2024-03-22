import SwiftUI

public extension Color.SeugiColorSystem {
    enum Red: SeugiColorable {
        case r100
        case r200
        case r300
        case r500
    }
}

public extension Color.SeugiColorSystem.Red {
    var color: Color {
        switch self {
        case .r100: .init(0xFFF7F7)
        case .r200: .init(0xFFE8E8)
        case .r300: .init(0xFFACAC)
        case .r500: .init(0xF90707)
        }
    }
}
