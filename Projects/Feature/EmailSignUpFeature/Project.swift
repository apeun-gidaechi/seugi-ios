import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.EmailSignUpFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.EmailSignUpFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.EmailSignUpFeature.rawValue, dependencies: [
            .feature(target: .EmailSignUpFeature)
        ])
    ],
    scripts: [.swiftLint]
)
