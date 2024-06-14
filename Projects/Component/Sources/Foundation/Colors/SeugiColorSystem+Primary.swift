import SwiftUI

public extension Color.SeugiColorSystem {
    enum Primary: SeugiColorable, CaseIterable {
        case p050
        case p100
        case p200
        case p300
        case p400
        case p500
        case p600
        case p700
    }
}

public extension Color.SeugiColorSystem.Primary {
    var color: Color {
        switch self {
        case .p050: .init(0xF8FCFF)
        case .p100: .init(0xDCEFFF)
        case .p200: .init(0xB1DBFD)
        case .p300: .init(0x7EC4FC)
        case .p400: .init(0x4BA9F5)
        case .p500: .init(0x1D93F3)
        case .p600: .init(0x0481E6)
        case .p700: .init(0x0A6EC0)
        }
    }
}
