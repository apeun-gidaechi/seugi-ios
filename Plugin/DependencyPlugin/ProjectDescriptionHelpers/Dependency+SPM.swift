import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Flow = TargetDependency.external(name: "Flow")
    static let Nuke = TargetDependency.external(name: "Nuke")
    static let NukeUI = TargetDependency.external(name: "NukeUI")
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let ApeunStompKit = TargetDependency.external(name: "ApeunStompKit")
    static let Then = TargetDependency.external(name: "Then")
    static let RealmSwift = TargetDependency.external(name: "RealmSwift")
    static let MCEmojiPicker = TargetDependency.external(name: "MCEmojiPicker")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
    static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
}
