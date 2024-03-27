import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.OAuthSignUpFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.OAuthSignUpFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.OAuthSignUpFeature.rawValue,
         dependencies: [
            .feature(target: .OAuthSignUpFeature)
         ])
    ],
    scripts: [.swiftLint]
)

