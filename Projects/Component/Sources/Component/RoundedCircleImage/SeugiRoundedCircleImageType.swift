import SwiftUI

public enum SeugiRoundedCircleImageType: Hashable {
    case icon(SeugiIconography)
    case image(SeugiImage)
    
    public enum Size: CGFloat {
        case large = 180
        case medium = 128
        case small = 64
        case extraSmall = 48
    }
    
    public var isIcon: Bool {
        if case .icon = self {
            true
        } else {
            false
        }
    }
}
