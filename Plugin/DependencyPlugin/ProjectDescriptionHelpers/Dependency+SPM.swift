import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Snapkit = TargetDependency.external(name: "SnapKit")
//    static let Alamofire = TargetDependency.external(name: "Alamofire")
//    static let AlamofireImage = TargetDependency.external(name: "AlamofireImage")
//    static let SkeletonUI = TargetDependency.external(name: "SkeletonUI")
//    static let Lottie = TargetDependency.external(name: "Lottie")
}
