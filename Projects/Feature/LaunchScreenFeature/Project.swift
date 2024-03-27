import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.LaunchScreenFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.LaunchScreenFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.LaunchScreenFeature.rawValue,
         dependencies: [
            .feature(target: .LaunchScreenFeature)
         ])
    ],
    scripts: [.swiftLint]
)

