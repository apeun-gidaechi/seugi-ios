import SwiftUI

public extension Color.SeugiColorSystem {
    enum Gray: SeugiColorable, CaseIterable {
        case g100
        case g200
        case g300
        case g400
        case g500
        case g600
        case g700
        case g800
    }
}

public extension Color.SeugiColorSystem.Gray {
    var color: Color {
        switch self {
        case .g100: .init(0xF4F5F9)
        case .g200: .init(0xF1F1F1)
        case .g300: .init(0xE6E6E6)
        case .g400: .init(0xD1D1D1)
        case .g500: .init(0xAAAAAA)
        case .g600: .init(0x787878)
        case .g700: .init(0x333333)
        case .g800: .init(0x1D1D1D)
        }
    }
}
