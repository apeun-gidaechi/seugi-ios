import SwiftUI

public extension Color.SeugiColorSystem {
    enum Yellow: SeugiColorable, CaseIterable {
        case y100
        case y200
        case y300
        case y500
    }
}

public extension Color.SeugiColorSystem.Yellow {
    var color: Color {
        switch self {
        case .y100: .init(0xFFFDF7)
        case .y200: .init(0xFDF2CB)
        case .y300: .init(0xFFE999)
        case .y500: .init(0xF7CC33)
        }
    }
}
