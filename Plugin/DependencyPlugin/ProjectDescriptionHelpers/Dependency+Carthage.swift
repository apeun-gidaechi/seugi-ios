import ProjectDescription

public extension TargetDependency {
    enum Carthage {}
}

public extension TargetDependency.Carthage {
    static let SocketRocket = TargetDependency.external(name: "SocketRocket")
}
