import SwiftUI

public enum SeugiRoundedCircleImageType: Hashable {
    case icon(SeugiIconography)
    case image(SeugiImage)
    
    public enum Size: CGFloat {
        case large = 100
        case medium = 72
        case small = 36
        case extraSmall = 27
    }
    
    public var isIcon: Bool {
        if case .icon = self {
            true
        } else {
            false
        }
    }
}
