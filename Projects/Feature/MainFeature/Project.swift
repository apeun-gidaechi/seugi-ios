import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.MainFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.MainFeature.rawValue,
                 dependencies: [
                    .feature(target: .BaseFeature),
                    .feature(target: .HomeFeature),
                    .feature(target: .ChatFeature)
                 ]),
        .example(name: ModulePaths.Feature.MainFeature.rawValue,
                 dependencies: [
                    .feature(target: .MainFeature)
                 ])
    ],
    scripts: [.swiftLint]
)

