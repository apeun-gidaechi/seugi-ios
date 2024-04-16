import ProjectDescription

public enum MicroModule: String {
    case Feature = ""
    case Interface
    case Tests
    case Testing
    case Example
}

public extension MicroModule {
    var product: Product {
        switch self {
        case .Feature: .staticLibrary
        case .Interface: .framework
        case .Tests: .unitTests
        case .Testing: .framework
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
