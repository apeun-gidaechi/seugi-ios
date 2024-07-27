import ProjectDescription

public enum MicroFeatureModule: String {
    case Feature = ""
    case Interface
    case Tests
    case Testing
    case Example
}

public extension MicroFeatureModule {
    var product: Product {
        switch self {
        case .Feature: .staticLibrary
        case .Interface: .staticFramework
        case .Tests: .unitTests
        case .Testing: .staticFramework
        case .Example: .app
        }
    }
    
    var source: String {
        switch self {
        case .Feature: "Sources"
        case .Interface: "Interface"
        case .Tests: "Tests"
        case .Testing: "Testing"
        case .Example: "Example"
        }
    }
}
