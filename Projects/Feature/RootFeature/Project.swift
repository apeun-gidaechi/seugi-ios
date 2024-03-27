import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.RootFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.RootFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .EmailSignInFeature),
            .feature(target: .EmailSignUpFeature),
            .feature(target: .JoinSchoolFeature),
            .feature(target: .LaunchScreenFeature),
            .feature(target: .OAuthSignUpFeature),
            .feature(target: .SelectingJobFeature),
            .feature(target: .StartFeature)
        ]),
        .example(name: ModulePaths.Feature.RootFeature.rawValue,
         dependencies: [
            .feature(target: .RootFeature)
         ])
    ],
    scripts: [.swiftLint]
)

