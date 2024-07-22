import Foundation

public enum ModulePaths {
    case app(App)
    case feature(Feature)
    case data(Data)
    case shared(Shared)
}

public extension ModulePaths {
    
    enum App: String, CaseIterable {
        case iOS
    }
    
    enum Feature: String, CaseIterable {
        case Base
        case Root
        case Onboarding
        case LaunchScreen
        case JoinWorkspace
        case Main
        case Home
        case Chat
        case ChatDetail
        case CreateGroupChat
        case Notification
        case Profile
    }
    
    enum Data: String, CaseIterable {
        case Core
        case Network
        case Local
    }
    
    enum Shared: String, CaseIterable {
        case GlobalThirdPartyLibrary
        case SwiftUIUtil
        case SwiftUtil
        case DateUtil
        case Config
    }
    
    enum Single: String {
        case DIContainer
        case Component
        case Domain
    }
}
