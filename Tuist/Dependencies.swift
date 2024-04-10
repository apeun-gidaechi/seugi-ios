import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: .init(
        [
            .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        ]
    ),
    platforms: [.iOS]
)
