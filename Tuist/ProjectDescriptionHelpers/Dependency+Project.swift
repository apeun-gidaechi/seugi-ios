import ProjectDescription

public extension TargetDependency {
    enum Project {}
}

public extension TargetDependency.Project {
    static let DesignSystem = TargetDependency.project(target: "DesignSystem",
                                                       path: .relativeToRoot("Projects/DesignSystem"))
    static let Feature = TargetDependency.project(target: "Feature",
                                                  path: .relativeToRoot("Projects/Feature"))
    static let Service = TargetDependency.project(target: "Service",
                                                  path: .relativeToRoot("Projects/Service"))
    static let ThirdPartyLib = TargetDependency.project(target: "ThirdPartyLib",
                                                        path: .relativeToRoot("Projects/ThirdPartyLib"))
}
