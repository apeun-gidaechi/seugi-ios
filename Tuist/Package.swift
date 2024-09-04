// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    baseSettings: .settings(
        base: .init(),
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ],
        defaultSettings: .recommended
    ),
    projectOptions: [
        "LocalSwiftPackage": .options(disableSynthesizedResourceAccessors: false)
    ]
)
#endif

let package = Package(
    name: "Seugi",
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.7.1"),
        .package(url: "https://github.com/tevelee/SwiftUI-Flow.git", exact: "1.1.0"),
        .package(url: "https://github.com/kean/Nuke.git", exact: "12.5.0"),
        .package(url: "https://github.com/openid/AppAuth-iOS.git", exact: "1.7.5"),
        .package(url: "https://github.com/moya/Moya.git", exact: "15.0.3"),
        .package(url: "https://github.com/bestswlkh0310/SwiftBok", exact: "1.2.0"),
        .package(url: "https://github.com/apeun-gidaechi/apeun-stomp-kit", exact: "1.3.0"),
        .package(url: "https://github.com/devxoul/Then", exact: "3.0.0"),
        .package(url: "https://github.com/realm/realm-swift", exact: "10.53.0")
    ]
)
