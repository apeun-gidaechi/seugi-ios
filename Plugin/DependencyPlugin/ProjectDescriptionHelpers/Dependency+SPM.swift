import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Snapkit = TargetDependency.external(name: "SnapKit")
    static let Flow = TargetDependency.external(name: "Flow")
    static let Nuke = TargetDependency.external(name: "Nuke")
    static let NukeUI = TargetDependency.external(name: "NukeUI")
}
