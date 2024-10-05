import Foundation
import SwiftUI

public enum ChatItemHorizontalAlignment: RawRepresentable {
    case leading
    case trailing
    
    public var rawValue: HorizontalAlignment {
        switch self {
        case .leading:
                .leading
        case .trailing:
                .trailing
        }
    }
    
    public init?(rawValue: HorizontalAlignment) {
        switch rawValue {
        case .leading:
            self = .leading
        case .trailing:
            self = .trailing
        default:
            return nil
        }
    }
}
