// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    productTypes: [
        "Flow": .framework,
        "Nuke": .framework,
        "NukeUI": .framework
    ],
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
        .package(url: "https://github.com/tevelee/SwiftUI-Flow.git", exact: "1.1.0"),
        .package(url: "https://github.com/kean/Nuke.git", exact: "12.5.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", branch: "main"),
        .package(url: "https://github.com/moya/Moya.git", exact: "15.0.3"),
        .package(url: "https://github.com/apeun-gidaechi/apeun-stomp-kit", exact: "1.3.5"),
        .package(url: "https://github.com/hhhello0507/ScopeKit", branch: "main"),
        .package(url: "https://github.com/realm/realm-swift", exact: "10.53.0"),
        .package(url: "https://github.com/izyumkin/MCEmojiPicker", exact: "1.2.3"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", branch: "main")
    ]
)
