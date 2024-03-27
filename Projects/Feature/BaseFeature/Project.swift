import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.BaseFeature.rawValue, dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .SwiftUIUtil)
        ])
    ],
    scripts: [.swiftLint]
)

