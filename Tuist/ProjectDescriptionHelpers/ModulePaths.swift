import Foundation

public enum ModulePaths {
    case app(App)
    case data(Data)
    case shared(Shared)
}

public extension ModulePaths {
    
    enum App: String, CaseIterable {
        case iOS
    }
    
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
    
    enum Single: String {
        case DIContainer
        case Component
        case Domain
    }
}
