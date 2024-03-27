import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.EmailSignInFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.EmailSignInFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.EmailSignInFeature.rawValue, dependencies: [
            .feature(target: .EmailSignInFeature)
        ])
    ],
    scripts: [.swiftLint]
)
