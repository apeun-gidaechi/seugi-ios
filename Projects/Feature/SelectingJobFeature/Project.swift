import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.SelectingJobFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.SelectingJobFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.SelectingJobFeature.rawValue,
         dependencies: [
            .feature(target: .SelectingJobFeature)
         ])
    ],
    scripts: [.swiftLint]
)

