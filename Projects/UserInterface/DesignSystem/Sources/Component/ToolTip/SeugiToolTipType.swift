import SwiftUI

public enum SeugiToolTipType: CaseIterable {
    case left
    case right
    case center
    
    var alignment: HorizontalAlignment {
        switch self {
        case .left: .leading
        case .right: .trailing
        case .center: .center
        }
    }
}

public extension SeugiToolTipType {
    enum Size: CaseIterable {
        case large
        case small
    }
    
    enum Direction: CaseIterable {
        case top
        case bottom
    }
}
