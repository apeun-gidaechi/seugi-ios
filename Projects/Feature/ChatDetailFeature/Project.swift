import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.ChatDetailFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.ChatDetailFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.ChatDetailFeature.rawValue,
         dependencies: [
            .feature(target: .ChatDetailFeature)
         ])
    ],
    scripts: [.swiftLint]
)

