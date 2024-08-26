import Foundation

public enum Modules {
    case data(Data)
    case shared(Shared)
}

public extension Modules {
    
    enum Data: String, CaseIterable {
        case Core
        case Network
        case Local
    }
    
    enum Shared: String, CaseIterable {
        case SwiftUIUtil
        case SwiftUtil
        case DateUtil
    }
}
