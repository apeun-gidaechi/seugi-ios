import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.HomeFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.HomeFeature.rawValue,
         dependencies: [
            .feature(target: .HomeFeature)
         ])
    ],
    scripts: [.swiftLint]
)

