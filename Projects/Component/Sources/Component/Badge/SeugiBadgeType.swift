import Foundation

public enum SeugiBadgeType {
    case normal
    case number(Int)
    
    var size: CGFloat {
        switch self {
        case .normal: 12
        case .number: 20
        }
    }
}
