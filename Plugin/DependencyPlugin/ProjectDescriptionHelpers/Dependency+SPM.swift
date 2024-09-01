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
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let SwiftBok = TargetDependency.external(name: "SwiftBok")
    static let ApeunStompKit = TargetDependency.external(name: "ApeunStompKit")
    static let Then = TargetDependency.external(name: "Then")
    static let RealmSwift = TargetDependency.external(name: "RealmSwift")
}
