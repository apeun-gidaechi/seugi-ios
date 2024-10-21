import SwiftUI

public enum ChatItemAuthorType: Equatable {
    case other
    case bot
    case me
    
    public var backgroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.white)
        case .bot: .sub(.white)
        case .me: .primary(.p500)
        }
    }
    
    public var foregroundColor: Color.SeugiColorSystem {
        switch self {
        case .other: .sub(.black)
        case .bot: .sub(.black)
        case .me: .sub(.white)
        }
    }
    
    public var corners: UIRectCorner {
        switch self {
        case .other, .bot: [.bottomLeft, .bottomRight, .topRight]
        case .me: [.bottomLeft, .bottomRight, .topLeft]
        }
    }
    
    public var alignent: ChatItemHorizontalAlignment {
        switch self {
        case .other, .bot: .leading
        case .me: .trailing
        }
    }
}
