import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: .init(
        [
            .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .exact("5.7.1")),
            .remote(url: "https://github.com/tevelee/SwiftUI-Flow.git", requirement: .exact("1.1.0")),
            .remote(url: "https://github.com/kean/Nuke.git", requirement: .exact("12.5")),
            .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .exact("6.1.0")),
            .remote(url: "https://github.com/moya/Moya.git", requirement: .exact("15.0.3")),
            .remote(url: "https://github.com/bestswlkh0310/SwiftBok", requirement: .exact("1.2.0"))
        ]
    ),
    platforms: [.iOS]
)
