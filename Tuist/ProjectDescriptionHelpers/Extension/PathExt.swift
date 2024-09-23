import ProjectDescription

public extension Path {
    static var dIContainer: Self {
        .relativeToRoot("Projects/DIContainer")
    }
    static func app(_ path: String) -> Self {
        .relativeToRoot("Projects/App/\(path)")
    }
    static var feature: Self {
        .relativeToRoot("Projects/Feature")
    }
    static var component: Self {
        .relativeToRoot("Projects/Component")
    }
    static var domain: Self {
        .relativeToRoot("Projects/Domain")
    }
    static var data: Self {
        .relativeToRoot("Projects/Data")
    }
    static var shared: Self {
        .relativeToRoot("Projects/Shared")
    }
    static func relativeToXCConfig(_ path: String) -> Self {
        .relativeToRoot("XCConfig/\(path)")
    }
    static func relativeToScript(_ path: String) -> Self {
        .relativeToRoot("Script/\(path)")
    }
    static var releaseConfig: Path {
        .relativeToXCConfig("Release.xcconfig")
    }
    static var debugConfig: Path {
        .relativeToXCConfig("Debug.xcconfig")
    }
}
