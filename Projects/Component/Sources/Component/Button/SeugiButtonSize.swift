import SwiftUI

enum SeugiButtonSize {
    case large
    case small
    
    var height: CGFloat {
        switch self {
        case .large: 54
        case .small: 36
        }
    }
    
    var font: Font {
        switch self {
        case .large: .subtitle(.s2)
        case .small: .body(.b2)
        }
    }
}
