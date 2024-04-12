import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: .init(
        [
            .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .exact("5.7.1"))
        ]
    ),
    platforms: [.iOS]
)
