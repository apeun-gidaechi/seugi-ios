import Foundation

public enum SeugiAppIconType {
    case appIcon
    case extraLarge
    case large
    case medium
    case small
    case extraSmall
    
    var size: CGFloat {
        switch self {
        case .appIcon: 512
        case .extraLarge: 108
        case .large: 64
        case .medium: 32
        case .small: 28
        case .extraSmall: 24
        }
    }
}
