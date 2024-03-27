import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.ChatFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.ChatFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.ChatFeature.rawValue,
         dependencies: [
            .feature(target: .ChatFeature)
         ])
    ],
    scripts: [.swiftLint]
)

